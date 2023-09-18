import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/appUrl.dart';

class BirthdayViewModel with ChangeNotifier {
  Map<String, dynamic> _birthdayWishResponse = {};
  Map<String, dynamic> _birthdayWishList = {};

  List<Map<String, dynamic>> _birthdayWishes = [];

  Map<String, dynamic> get birthdayWishResponse {
    return {..._birthdayWishResponse};
  }

  Map<String, dynamic> get birthdayWishList {
    return {..._birthdayWishList};
  }

  List<Map<String, dynamic>> get birthdayWishes {
    return [..._birthdayWishes];
  }

  Future<dynamic> birthdayWishPost(
      dynamic data, int index, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Birthday Data: $data');

    // Navigator.of(context).pop();

    var response = await http.post(Uri.parse(AppUrl.birthdayWish),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _birthdayWishResponse = json.decode(response.body);

      if (_birthdayWishResponse['data'] == 'You have already Posted') {
        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          // title: 'CheckOut Failed',
          message: _birthdayWishResponse['data'],
          barBlur: 20,
        ).show(context);
      } else if (_birthdayWishResponse['data'] == 'Posted Successfully') {
        _birthdayWishes.add({
          'wish': data['wish'],
          'emp_name': data['name'],
          'profile_photo': data['profilePicture'],
          'updated_at': data['date']
        });
        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          // title: 'CheckOut Failed',
          message: 'Your wish has been sent',
          barBlur: 20,
        ).show(context);
      }
    } else {
      _birthdayWishResponse = json.decode(response.body);

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

    print('Birthday Wish: $_birthdayWishResponse');

    notifyListeners();

    return _birthdayWishResponse;
  }

  Future<void> birthdayWish(int index, BuildContext context) async {
    _birthdayWishes = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.birthdayComment), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _birthdayWishList = json.decode(response.body);
      for (int i = 0;
          i < _birthdayWishList['data'][index]['comments'].length;
          i++) {
        _birthdayWishes.add(_birthdayWishList['data'][index]['comments'][i]);
      }
    } else {
      _birthdayWishList = json.decode(response.body);

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
    notifyListeners();
  }
}
