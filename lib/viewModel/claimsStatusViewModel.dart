import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/repository/claimzRepository.dart';
import 'package:flutter/material.dart';
import '../repository/claimzDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/response/apiResponse.dart';
import '../models/dashboardModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../res/appUrl.dart';

class ClaimzStatusViewModel with ChangeNotifier {
  List<dynamic> _present = [];
  List<dynamic> _absent = [];
  List<dynamic> _onLeave = [];
  List<dynamic> _checkedOut = [];
  List<dynamic> _weekEnd = [];
  List<dynamic> _holiday = [];
  List<dynamic> _all = [];
  Map<String, dynamic> _commonHolidays = {};
  Map<String, dynamic> _optionalHolidays = {};
  Map<String, dynamic> _postHolidays = {};

  int _count = 0;
  String _checkinTime = '';
  String _checkoutTime = '';
  String _checkinStatus = '';
  int _attendanceId = 0;

  String get checkinTime {
    return _checkinTime;
  }

  String get checkoutTime {
    return _checkoutTime;
  }

  String get checkinStatus {
    return _checkinStatus;
  }

  int get attendanceId {
    return _attendanceId;
  }

  List<dynamic> get allEmployees {
    return [..._all];
  }

  int get count {
    return _count;
  }

  List<dynamic> get presentEmployees {
    return [..._present];
  }

  List<dynamic> get absentEmployees {
    return [..._absent];
  }

  List<dynamic> get onLeaveEmployees {
    return [..._onLeave];
  }

  List<dynamic> get checkedOutEmployees {
    return [..._checkedOut];
  }

  List<dynamic> get weekendEmployees {
    return [..._weekEnd];
  }

  List<dynamic> get onHoliday {
    return [..._holiday];
  }

  Map<String, dynamic> _claimzStatus = {};

  Map<String, dynamic> get claimzStatuss {
    return {..._claimzStatus};
  }

  Map<String, dynamic> get commonHolidays {
    return {..._commonHolidays};
  }

  Map<String, dynamic> get optionalHolidays {
    return {..._optionalHolidays};
  }

  Map<String, dynamic> get postHolidays {
    return {..._postHolidays};
  }

  Future<void> getOptionalHolidays() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.userHolidays), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}',
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _optionalHolidays = json.decode(response.body);
    } else {
      print('An Error Occured');
    }

    print('Common Holidays: $_optionalHolidays');
  }

  Future<void> postOptionalHoliday(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.userHolidaysPost),
        body: json.encode({}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}',
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _postHolidays = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'CheckOut Failed',
        message: 'Optional Holiday Applied',
        barBlur: 20,
      ).show(context);
    } else {
      _postHolidays = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'CheckOut Failed',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }

    print('Post Holidays: $_postHolidays');
  }

  Future<void> getCommonHolidays() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.holidays), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}',
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _commonHolidays = json.decode(response.body);
    } else {
      print('An Error Occured');
    }

    print('Optional Holidays: $_commonHolidays');
  }

  Future<void> getClaimzStatuss() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _count = 0;

    _present = [];
    _all = [];
    _absent = [];
    _onLeave = [];
    _checkedOut = [];
    _weekEnd = [];
    _holiday = [];

    var response = await http.get(Uri.parse(AppUrl.dashBoard), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}',
    });

    if (response.statusCode == 200) {
      _claimzStatus = json.decode(response.body);
      _all = _claimzStatus['data']['dashboard_data']['attendance'];
      _count = _claimzStatus['data']['dashboard_data']['unread_announcements'];

      _checkinTime = _claimzStatus['data']['dashboard_data']['checkin_time'];

      _checkoutTime = _claimzStatus['data']['dashboard_data']['checkout_time'];

      _checkinStatus =
          _claimzStatus['data']['dashboard_data']['checkin_status'] ?? 'null';

      _attendanceId = _claimzStatus['data']['dashboard_data']['attendance_id'];

      for (int index = 0;
          index < _claimzStatus['data']['dashboard_data']['attendance'].length;
          index++) {
        if (_claimzStatus['data']['dashboard_data']['attendance'][index]
                    ['status'] ==
                'Present' &&
            _claimzStatus['data']['dashboard_data']['attendance'][index]
                    ['checkout_time'] ==
                '') {
          _present.add(
              _claimzStatus['data']['dashboard_data']['attendance'][index]);
        }
        if (_claimzStatus['data']['dashboard_data']['attendance'][index]
                    ['status'] ==
                'Absent' &&
            _claimzStatus['data']['dashboard_data']['attendance'][index]
                    ['checkout_time'] ==
                '') {
          _absent.add(
              _claimzStatus['data']['dashboard_data']['attendance'][index]);
        }
        if (_claimzStatus['data']['dashboard_data']['attendance'][index]
                        ['status'] ==
                    'Present' &&
                _claimzStatus['data']['dashboard_data']['attendance'][index]
                        ['checkout_time'] !=
                    '' ||
            _claimzStatus['data']['dashboard_data']['attendance'][index]
                        ['status'] ==
                    'Absent' &&
                _claimzStatus['data']['dashboard_data']['attendance'][index]
                        ['checkout_time'] !=
                    '') {
          _checkedOut.add(
              _claimzStatus['data']['dashboard_data']['attendance'][index]);
        }
        if (_claimzStatus['data']['dashboard_data']['attendance'][index]
                ['status'] ==
            'Weekend') {
          _weekEnd.add(
              _claimzStatus['data']['dashboard_data']['attendance'][index]);
        }
        if (_claimzStatus['data']['dashboard_data']['attendance'][index]
                ['status'] ==
            'Leave') {
          _onLeave.add(
              _claimzStatus['data']['dashboard_data']['attendance'][index]);
        }
        if (_claimzStatus['data']['dashboard_data']['attendance'][index]
                ['status'] ==
            'Holiday') {
          _holiday.add(
              _claimzStatus['data']['dashboard_data']['attendance'][index]);
        }
      }
    } else {
      _claimzStatus = {};
      print('Status Code: ${response.statusCode}');
    }
    print('CLaimzzzzz: $_claimzStatus');
    print('PRESENT: $_present');
    print('COUNTTTTTTTTTTTTTTTTTTTTTTTTTTT: $_count');
    print('Checkin Time: $_checkinTime');
    print('Checkout Time: $_checkoutTime');
    print('Checkin Status: $_checkinStatus');

    notifyListeners();
  }

  final claimzRepository = ClaimzDashboard();
  ApiResponse<DashboardData> claimzStatus = ApiResponse.loading();
  // ApiResponse<DashboardData> claimzStatus = ApiResponse.loading();

  setClaimzStatus(ApiResponse<DashboardData> response) {
    claimzStatus = response;
    notifyListeners();
  }

  Future<void> getClaimzStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    // setClaimzStatus(ApiResponse.loading());

    print('CLAIMZ API CALLED');

    claimzRepository.getClaimzStatus(authToken).then((value) {
      setClaimzStatus(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setClaimzStatus(ApiResponse.error(error.toString()));
    });
  }
}
