import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../res/appUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AttendanceReportViewModel with ChangeNotifier {
  Map<String, dynamic> _attendanceReport = {};
  Map<String, dynamic> _allAttendanceReport = {};
  Map<String, dynamic> _allLeaveReport = {};
  List<String> _leaveType = [];
  List<String> _shortForms = [];

  int _absentCount = 0;

  Map<String, dynamic> get attendanceReport {
    return {..._attendanceReport};
  }

  Map<String, dynamic> get allAttendanceReport {
    return {..._allAttendanceReport};
  }

  Map<String, dynamic> get allLeaveReport {
    return {..._allLeaveReport};
  }

  List<String> get leaveType {
    return [..._leaveType];
  }

  List<String> get shortForms {
    return [..._shortForms];
  }

  int get absentCount {
    return _absentCount;
  }

  Future<dynamic> getAttendanceReport(String month, String year) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _absentCount = 0;

    var response = await http.post(Uri.parse(AppUrl.attendanceReport),
        body: json.encode({'month': month, 'year': year}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _attendanceReport = json.decode(response.body);
      for (int i = 0; i < _attendanceReport['data'].length; i++) {
        if (_attendanceReport['data'][i]['attendance_status'] == 0) {
          _absentCount++;
        }
      }
    }

    print('Attendance Report: $_attendanceReport');

    notifyListeners();

    return _attendanceReport;
  }

  Future<dynamic> getAllAttendanceReport(String month, String year) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Month: $month Year: $year');

    _absentCount = 0;

    var response = await http.post(Uri.parse(AppUrl.allAttendanceReport),
        body: json.encode({'month': month, 'year': year}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _allAttendanceReport = json.decode(response.body);
      // for (int i = 0; i < _attendanceReport['data'].length; i++) {
      //   if (_attendanceReport['data'][i]['attendance_status'] == 0) {
      //     _absentCount++;
      //   }
      // }
      for (int i = 0; i < _allAttendanceReport['data'].length; i++) {
        _allAttendanceReport['data'][i]['expanded'] = false;
        if (_allAttendanceReport['data'][i]['attendance_status'] == 0) {
          _absentCount++;
        }
      }
    } else {
      print('An Error Occured');
    }

    print('All Attendance Report: $_allAttendanceReport');

    notifyListeners();

    return _allAttendanceReport;
  }

  Future<void> getAllLeaveReport() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // print('Month: $month Year: $year');

    _absentCount = 0;

    var response = await http.get(Uri.parse(AppUrl.allLeaveReport),
        // body: json.encode({'month': month, 'year': year}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _allLeaveReport = json.decode(response.body);
      for (int i = 0; i < _allLeaveReport['all_leaves'].length; i++) {
        _leaveType.add(_allLeaveReport['all_leaves'][i]['leave_types']);
      }
      for (int i = 0; i < _allLeaveReport['data'].length; i++) {
        _allLeaveReport['data'][i]['total'] = 0;

        _allLeaveReport['data'][i]['expanded'] = false;
        for (int j = 0; j < _allLeaveReport['data'][i]['leave'].length; j++) {
          _allLeaveReport['data'][i]['total'] +=
              _allLeaveReport['data'][i]['leave'][j]['leave_balance'];
        }
      }
    } else {
      print('An Error Occured');
    }

    print('All Leave Report: $_allLeaveReport');

    print('Leave Type: $_leaveType');

    notifyListeners();

    // return _allLeaveReport;
  }
}
