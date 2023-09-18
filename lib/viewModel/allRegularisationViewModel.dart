import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AllRegularisationViewModel with ChangeNotifier {
  Map<String, dynamic> _allRegularisation = {};

  Map<String, dynamic> get allRegularisation {
    return {..._allRegularisation};
  }

  Future<void> getAllRegularisations(String fromDate, String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.viewAllRegularisations),
        body: json.encode({'from_date': fromDate, 'to_date': toDate}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _allRegularisation = json.decode(response.body);
    } else {
      _allRegularisation = {};
    }
    print('View All Regularisations: $_allRegularisation');
    notifyListeners();
  }
}
