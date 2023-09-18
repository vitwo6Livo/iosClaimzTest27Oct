import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IosDashboard with ChangeNotifier {
  Map<String, dynamic> _dashboard = {};
  Map<String, dynamic> _birthday = {};
  Map<String, dynamic> _holiday = {};
  Map<String, dynamic> _attendance = {};
  Map<String, dynamic> _announcement = {};
  Map<String, dynamic> _compOff = {};
  Map<String, dynamic> _claimApproval = {};

  Map<String, dynamic> get dashboard {
    return {..._dashboard};
  }

  Map<String, dynamic> get birthday {
    return {..._birthday};
  }

  Map<String, dynamic> get holiday {
    return {..._holiday};
  }

  Map<String, dynamic> get attendance {
    return {..._attendance};
  }

  Map<String, dynamic> get announcement {
    return {..._announcement};
  }

  Map<String, dynamic> get compoff {
    return {..._compOff};
  }

  Map<String, dynamic> get claimApproval {
    return {..._claimApproval};
  }

  Future<void> getDashboard() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.iosDashboard), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _dashboard = json.decode(response.body);
    }
    print('IOS DASHBOARD: $_dashboard');
  }

  Future<void> getBirthday() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.iosBirthday), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _birthday = json.decode(response.body);
    }
    print('IOS DASHBOARD: $_birthday');
  }

  Future<void> getHoliday() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.iosHoliday), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _holiday = json.decode(response.body);
    }
    print('IOS DASHBOARD: $_holiday');
  }

  Future<void> getAttendance() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.iosAttendance), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _attendance = json.decode(response.body);
    }
    print('IOS DASHBOARD: $_attendance');
  }

  Future<void> getAnnouncement() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.iosAnnouncement), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _announcement = json.decode(response.body);
    }
    print('IOS DASHBOARD: $_announcement');
  }

  Future<void> getCompOff() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.iosCompoff), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _compOff = json.decode(response.body);
    }
    print('IOS DASHBOARD: $_compOff');
  }
}
