// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../res/appUrl.dart';
import 'dart:convert';
import '../views/screens/success_tick_screen.dart';
import '../views/widgets/managerScreenWidgets/leaveRequest/leaveRequestManager.dart';
import 'reportingTreeViewModel.dart';

class LeaveRequestViewModel with ChangeNotifier {
  Map<String, dynamic> _leaveList = {};
  Map<String, dynamic> _leaveResponse = {};
  List<Map<String, dynamic>> _pendingLeaves = [];
  List<Map<String, dynamic>> _approvedLeaves = [];
  List<Map<String, dynamic>> _rejectedLeaves = [];

  // List<Map<String, dynamic>> _allLeaves = [];

  Map<String, dynamic> get leaveList {
    return {..._leaveList};
  }

  Map<String, dynamic> get leaveResponse {
    return {..._leaveResponse};
  }

  List<Map<String, dynamic>> get pendingLeaves {
    return [..._pendingLeaves];
  }

  List<Map<String, dynamic>> get approvedLeaves {
    return [..._approvedLeaves];
  }

  List<Map<String, dynamic>> get rejectedLeaves {
    return [..._rejectedLeaves];
  }

  Future<void> getLeaveRequest(String fromDate, String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('From Date: $fromDate');
    print('To Date: $toDate');

    _pendingLeaves = [];
    _approvedLeaves = [];
    _rejectedLeaves = [];

    final response = await http.post(Uri.parse(AppUrl.viewLeaveManager),
        body: json.encode({'from_date': fromDate, 'to_date': toDate}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _leaveList = json.decode(response.body);
      for (int i = 0; i < _leaveList['data'].length; i++) {
        if (_leaveList['data'][i]['status'] == 0) {
          _pendingLeaves.add(_leaveList['data'][i]);
        } else if (_leaveList['data'][i]['status'] == 1) {
          _approvedLeaves.add(_leaveList['data'][i]);
        } else {
          _rejectedLeaves.add(_leaveList['data'][i]);
        }
      }
    } else {
      _leaveList = json.decode(response.body);

      // _leaveList = {};
    }
    print('LEAVE REQUESTS: $_leaveList');

    print('PENDING REQUESTS: $_pendingLeaves');

    notifyListeners();
  }

  Future<dynamic> manageApproveLeave(int id, int status, BuildContext context,
      Map<String, dynamic> data, String fromDate, String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    DateTime date = DateTime.parse(data['created_at']);

    String month = date.month.toString();
    String year = date.year.toString();

    print('ID: $id');
    print('Status: $status');

    final response = await http.post(Uri.parse(AppUrl.leaveManager),
        body: json.encode({'id': id, 'status': status}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _leaveResponse = json.decode(response.body);

      _approvedLeaves.add(data);

      _pendingLeaves.removeWhere((value) => value['leave_id'] == id);

      Provider.of<LeaveRequestViewModel>(context, listen: false)
          .getLeaveRequest(fromDate, toDate);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LeaveRequestManager()));
      });

      // Navigator.of(context).pop();
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LeaveRequestManager()));
    } else {
      _leaveResponse = json.decode(response.body);

      print('ERRRORR RESPONSEEEEEEEEE: $_leaveResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error Occured',
        message: '',
        barBlur: 20,
      ).show(context).then((value) => Navigator.of(context).pop());

      _leaveResponse = {};
    }
    notifyListeners();
  }

  Future<dynamic> manageRejectLeave(int id, int status, BuildContext context,
      Map<String, dynamic> data, String fromDate, String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    DateTime date = DateTime.parse(data['created_at']);

    String month = date.month.toString();
    String year = date.year.toString();

    print('ID: $id');
    print('Status: $status');

    final response = await http.post(Uri.parse(AppUrl.leaveManager),
        body: json.encode({'id': id, 'status': status}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _leaveResponse = json.decode(response.body);

      Provider.of<LeaveRequestViewModel>(context, listen: false)
          .getLeaveRequest(fromDate, toDate);

      _rejectedLeaves.add(data);
      _pendingLeaves.removeWhere((value) => value['leave_id'] == id);

      // Provider.of<ReportingTreeViewModel>(context, listen: false)
      //     .getRecords(id, month, year, context);

      print(' REJECCCCCT RESPONSEEEEEEEEE: $_leaveResponse');

      // Flushbar(
      //   duration: const Duration(seconds: 4),
      //   flushbarPosition: FlushbarPosition.BOTTOM,
      //   borderRadius: BorderRadius.circular(10),
      //   icon: const Icon(Icons.error, color: Colors.white),
      //   // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      //   title: 'Leave Rejected',
      //   message: _leaveResponse['data'],
      //   barBlur: 20,
      // ).show(context).then((value) => Navigator.of(context).pop());

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LeaveRequestManager()));
      });
    } else {
      _leaveResponse = json.decode(response.body);

      print('ERRRORR RESPONSEEEEEEEEE: $_leaveResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error Occured',
        message: '',
        barBlur: 20,
      ).show(context).then((value) => Navigator.of(context).pop());

      _leaveResponse = {};
    }
    notifyListeners();
  }

  Future<dynamic> manageLeaves(int id, int status, BuildContext context,
      Map<String, dynamic> data, String fromDate, String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    DateTime date = DateTime.parse(data['created_at']);

    String month = date.month.toString();
    String year = date.year.toString();

    print('ID: $id');
    print('Status: $status');

    final response = await http.post(Uri.parse(AppUrl.leaveManager),
        body: json.encode({'id': id, 'status': status}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _leaveResponse = json.decode(response.body);

      print('RESPONSEEEEEEEEE: $_leaveResponse');

      Provider.of<ReportingTreeViewModel>(context, listen: false)
          .getRecords(id, month, year, context);

      if (status == 1) {
        _approvedLeaves.add(data);

        _pendingLeaves.removeWhere((value) => value['leave_id'] == id);

        Provider.of<LeaveRequestViewModel>(context, listen: false)
            .getLeaveRequest(fromDate, toDate);

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          message: _leaveResponse['data'],
          barBlur: 20,
        ).show(context);
      } else {
        _leaveResponse = json.decode(response.body);

        print(' REJECCCCCT RESPONSEEEEEEEEE: $_leaveResponse');
        _rejectedLeaves.add(data);
        _pendingLeaves.removeWhere((value) => value['leave_id'] == id);

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          title: 'Leave Rejected',
          message: _leaveResponse['data'],
          barBlur: 20,
        ).show(context);
      }
    } else {
      _leaveResponse = json.decode(response.body);

      print('ERRRORR RESPONSEEEEEEEEE: $_leaveResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error Occured',
        message: '',
        barBlur: 20,
      ).show(context);

      _leaveResponse = {};
    }
    print('Leave Manager: $_leaveResponse');
    print('Approved Leave: $_approvedLeaves');
    print('Approved Leave: $_rejectedLeaves');

    notifyListeners();
    return _leaveResponse;
  }
}
