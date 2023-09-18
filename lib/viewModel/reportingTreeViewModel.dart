import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

class ReportingTreeViewModel with ChangeNotifier {
  Map<String, dynamic> _tree = {};
  List<Map<String, dynamic>> _present = [];
  List<Map<String, dynamic>> _onLeave = [];
  List<Map<String, dynamic>> _checkedOut = [];
  List<Map<String, dynamic>> _absent = [];
  List<Map<String, dynamic>> _weekEnd = [];
  List<Map<String, dynamic>> _holiday = [];

  List<Map<String, dynamic>> _all = [];
  Map<String, dynamic> _otherTree = {};
  List<Map<String, dynamic>> _others = [];
  List<Map<String, dynamic>> _attendance = [];
  List<Map<String, dynamic>> _regularisation = [];
  List<Map<String, dynamic>> _leave = [];
  Map<String, dynamic> _report = {};

  List<Map<String, dynamic>> _allLeaves = [];

  List<Map<String, dynamic>> get allLeaves {
    return [..._allLeaves];
  }

  Map<String, dynamic> get tree {
    return {..._tree};
  }

  Map<String, dynamic> get otherTree {
    return {..._otherTree};
  }

  List<Map<String, dynamic>> get present {
    return [..._present];
  }

  // List<Map<String, dynamic>> get onLeave {
  //   return [..._onLeave];
  // }

  List<Map<String, dynamic>> get checkedOut {
    return [..._checkedOut];
  }

  List<Map<String, dynamic>> get absent {
    return [..._absent];
  }

  List<Map<String, dynamic>> get weekEnd {
    return [..._weekEnd];
  }

  List<Map<String, dynamic>> get holiday {
    return [..._holiday];
  }

  List<Map<String, dynamic>> get all {
    return [..._all];
  }

  List<Map<String, dynamic>> get others {
    return [..._others];
  }

  List<Map<String, dynamic>> get attendance {
    return [..._attendance];
  }

  List<Map<String, dynamic>> get regularisation {
    return [..._regularisation];
  }

  List<Map<String, dynamic>> get leave {
    return [..._leave];
  }

  Map<String, dynamic> get report {
    return {..._report};
  }

  Future<void> getReportingTree(BuildContext context, int id) async {
    _present = [];
    _all = [];
    _absent = [];
    _checkedOut = [];
    _leave = [];
    _onLeave = [];
    _weekEnd = [];
    _holiday = [];

    print('User ID: $id');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse('${AppUrl.reportingTree}$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200) {
      _tree = json.decode(response.body);
      for (int i = 0; i < _tree['attendance'].length; i++) {
        _all.add(_tree['attendance'][i]);

        if (_tree['attendance'][i]['status'] == 'Present' &&
            _tree['attendance'][i]['checkout_time'] == '') {
          _present.add(_tree['attendance'][i]);
        }
        if (_tree['attendance'][i]['status'] == 'Absent' &&
            _tree['attendance'][i]['checkout_time'] == '') {
          _absent.add(_tree['attendance'][i]);
        }
        if (_tree['attendance'][i]['status'] == 'Absent' &&
                _tree['attendance'][i]['checkout_time'] != '' ||
            _tree['attendance'][i]['status'] == 'Present' &&
                _tree['attendance'][i]['checkout_time'] != '') {
          _checkedOut.add(_tree['attendance'][i]);
        }

        if (_tree['attendance'][i]['status'] == 'Weekend') {
          _weekEnd.add(_tree['attendance'][i]);
        }
        if (_tree['attendance'][i]['status'] == 'Leave') {
          _leave.add(_tree['attendance'][i]);
        }
        if (_tree['attendance'][i]['status'] == 'Holiday') {
          _holiday.add(_tree['attendance'][i]);
        }
      }
    } else {
      _tree = {};
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'No Record Found',
        message: 'No Record Found',
        barBlur: 20,
      ).show(context);
    }
    print('Reporting Tree gets Called: $_tree');
    print('Reporting All gets Called: $_all');
    print('Tree Count: ${_tree['attendance'].length}');
    print('Present Count: ${_present.length}');

    notifyListeners();
  }

  Future<List<dynamic>> getOthersReportingTree(
      BuildContext context, int id) async {
    _others = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse('${AppUrl.reportingTree}$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200) {
      _otherTree = json.decode(response.body);
      if (_otherTree['attendance'].isEmpty) {
        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          title: 'No Record Found',
          message: 'No Record Found',
          barBlur: 20,
        ).show(context);
      } else {
        for (int i = 0; i < _otherTree['attendance'].length; i++) {
          // _all.add(_tree['attendance'][i]);
          _others.add(_otherTree['attendance'][i]);
          // if (_tree['attendance'][i]['status'] == 'present') {
          //   _present.add(_tree['attendance'][i]);
          // }
        }
      }
    } else {
      _otherTree = {};
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'No Record Found',
        message: 'No Record Found',
        barBlur: 20,
      ).show(context);
    }
    print('Reporting Tree gets Called: $_otherTree');
    print('Reporting All gets Called: $_all');
    print('Tree Count: ${_otherTree['attendance'].length}');
    // print('Present Count: ${_present.length}');
    notifyListeners();

    return _others;
  }

  Future<void> getRecords(
      int id, String startDate, String endDate, BuildContext context) async {
    _report = {};

    _allLeaves = [];

    print('IDDDDDDDDDDDd: $id');

    print('Start Date: $startDate');

    print('End Date: $endDate');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.employeeRecord),
        body:
            json.encode({'id': id, 'from_date': startDate, 'to_date': endDate}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _report = json.decode(response.body);

      for (int i = 0; i < _report['leave'].length; i++) {
        if (_report['leave'][i]['status'] == 0) {
          _allLeaves.add(_report['leave'][i]);
        } else {
          _allLeaves = [];
        }
      }

      print('ALL Reporrrrrrt LEAVESSSSSS: $_allLeaves');
    } else {
      _report = {};
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'An Error Occured',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    print('Employee Record: $_report');
    notifyListeners();
  }
}
