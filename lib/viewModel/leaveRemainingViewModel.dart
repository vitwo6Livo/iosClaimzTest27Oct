import 'package:flutter/material.dart';
import '../repository/leaveRemainingRepository.dart';
import '../models/leaveRemainingModel.dart';
import '../data/response/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../res/appUrl.dart';

class LeaveRemainingViewModel with ChangeNotifier {
  Map<String, dynamic> _leaveBalance = {};
  List<Map<String, dynamic>> _leaveTypes = [];
  List<dynamic> _leaveReasons = [];

  Map<String, dynamic> get leaveBalance {
    return {..._leaveBalance};
  }

  List<Map<String, dynamic>> get leaveTypes {
    return [..._leaveTypes];
  }

  List<dynamic> get leaveReasons {
    return [..._leaveReasons];
  }

  double _totalLeaves = 0.0;
  int _availableLeaves = 0;

  double get totalLeaves {
    return _totalLeaves;
  }

  int get availableLeaves {
    return _availableLeaves;
  }

  // List<String> images = [
  //   'assets/img/casualLEave-01.png',
  //   'assets/img/sickLeave-01.png',
  //   'assets/img/privilageLeave-01.png',
  //   'assets/img/privilageLeave-01.png',
  //   'assets/img/compoff.png'
  // ];

  Future<void> getLeaveBalance() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _leaveTypes = [];
    _totalLeaves = 0.0;

    var response = await http.get(Uri.parse(AppUrl.remainingLeaves), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode == 200) {
      _leaveBalance = json.decode(response.body);

      for (int i = 0; i < _leaveBalance['data'].length; i++) {
        if (_leaveBalance['data'][i]['leave_types'] != 'Compoff Balance') {
          _totalLeaves += _leaveBalance['data'][i]['number'];
        }

        _leaveBalance['data'][i]['image'] = 'assets/img/casualLEave-01.png';
        _leaveTypes.add(_leaveBalance['data'][i]);
      }
    } else {
      _leaveBalance = {};
    }
    print('Leave Balance: $_leaveBalance');
    print('Total Leaves: $_totalLeaves');
    print('Leave Types: $_leaveTypes');

    notifyListeners();
  }

  Future<void> getLeaveReasons() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var responseBody;

    _leaveReasons = [];

    var response = await http.get(Uri.parse(AppUrl.leaveReason), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      responseBody = json.decode(response.body);

      _leaveReasons = responseBody['data'];

      // _leaveReasons.add({
      //   'leave_reason_id': 999,
      //   'reason': 'Other',
      //   'created_at': null,
      //   'updated_at': null
      // });
    } else {
      responseBody = json.decode(response.body);

      // _leaveReasons = json.decode(response.body);

      print('ERROR RESPONSE: $responseBody');
    }
    print('Leave Reason: $_leaveReasons');
  }
}
