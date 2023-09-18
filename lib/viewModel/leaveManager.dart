import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/appUrl.dart';

class LeaveManager with ChangeNotifier {
  Map<String, dynamic> _leaveManager = {};

  Map<String, dynamic> get leaveManager {
    return {..._leaveManager};
  }

  Future<dynamic> manageLeaves(int id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response =
        await http.get(Uri.parse('${AppUrl.leaveManager}$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode == 200) {
      _leaveManager = json.decode(response.body);
    } else {
      _leaveManager = {};
    }
    print('Leave Manager: $_leaveManager');
    notifyListeners();
  }
}
