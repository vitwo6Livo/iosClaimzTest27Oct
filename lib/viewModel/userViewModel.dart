import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/authenticationModel.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(Data auth) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    localStorage.setString('token', auth.accessToken.toString());
    localStorage.setInt('role', auth.role!);
    localStorage.setInt('userId', auth.id!);
    localStorage.setString('approval', auth.approval!);
    localStorage.setInt('userId', auth.id!);
    localStorage.setInt('candidateStatus', auth.candidateStatus!);
    localStorage.setString('email', auth.email!);
    localStorage.setString('name', auth.name!);
    localStorage.setString('verificationCode', auth.verificationCode!);

    notifyListeners();
    return true;
  }

  Future<void> saveKam(String kamToken) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.setString('kamToken', kamToken);

    notifyListeners();
  }

  Future<Data?> getUser() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    final String? token = localStorage.getString('token');
    print('Saved Token: $token');
    return Data(accessToken: token.toString());
  }

  void removeToken() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('kamToken');
    localStorage.clear();
  }

  saveLocationData(Map<String, String> data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    if (data.isNotEmpty) {
      localStorage.setString('location', json.encode(data));
      notifyListeners();
    } else {
      Map<String, String> decodedloc =
          json.decode(localStorage.getString('location').toString());
      decodedloc.addAll(data);
      localStorage.setString('location', json.encode(decodedloc));
      notifyListeners();
    }
  }
}
