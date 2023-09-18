import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserHolidayViewModel with ChangeNotifier {
  Map<String, dynamic> _allHolidays = {};
  List<Map<String, dynamic>> _optionalHolidays = [];
  List<Map<String, dynamic>> _commonHolidays = [];
  int? _limit;

  Map<String, dynamic> get allHolidays {
    return {..._allHolidays};
  }

  List<Map<String, dynamic>> get optionalHolidays {
    return [..._optionalHolidays];
  }

  List<Map<String, dynamic>> get commonHolidays {
    return [..._commonHolidays];
  }

  int get limit {
    return _limit!;
  }

  Future<void> getHolidayList(BuildContext context) async {
    _optionalHolidays = [];

    _commonHolidays = [];

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.holidays), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      _allHolidays = json.decode(response.body);

      _limit = int.parse(_allHolidays['limit']);

      for (int i = 0; i < _allHolidays['data'].length; i++) {
        if (_allHolidays['data'][i]['type'] == 'optional') {
          _allHolidays['data'][i]['isChecked'] = false;

          _optionalHolidays.add(_allHolidays['data'][i]);

          print('Optional Holidays: $_optionalHolidays');
        } else {
          _commonHolidays.add(_allHolidays['data'][i]);
        }
      }
    } else {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<bool> postHoliday(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Sent Holiday: $data');

    print('Data Length: ${data['holidays'].length}');

    if (data['holidays'].length > _limit) {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'You can opt for a maximum of $_limit optional holiday(s)',
        barBlur: 20,
      ).show(context);

      return false;
    } else {
      var response = await http.post(Uri.parse(AppUrl.userHolidaysPost),
          body: json.encode(data),
          headers: {
            'Authorization': 'Bearer ${localStorage.getString('token')}',
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        print('Success Response: ${json.decode(response.body)}');

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          // title: 'Login Successful',
          message:
              'You have opted for ${data['holidays'].length} optional holiday(s)',
          barBlur: 20,
        ).show(context);
        return true;
      } else if (response.statusCode == 205) {
        var responseData = json.decode(response.body);

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          // title: 'Login Successful',
          message: responseData['data'],
          barBlur: 20,
        ).show(context);
        return false;
      } else {
        var responseData = json.decode(response.body);

        print('Response Data: $responseData');

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          // title: 'Login Successful',
          message: 'An Error Occured',
          barBlur: 20,
        ).show(context);
        return false;
      }
    }
  }
}
