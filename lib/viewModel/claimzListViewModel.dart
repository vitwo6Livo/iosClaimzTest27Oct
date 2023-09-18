import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/appUrl.dart';

class ClaimzListViewModel with ChangeNotifier {
  Map<String, dynamic> _claimzList = {};

  Map<String, dynamic> get claimzList {
    return {..._claimzList};
  }

  Future<void> getClaimzList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.claimz_list), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });
    if (response.statusCode == 200) {
      _claimzList = json.decode(response.body);
    } else {
      _claimzList = {};
    }
    notifyListeners();
  }
}
