import 'package:flutter/material.dart';
import '../res/appUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationAndEvent with ChangeNotifier {
  Map<String, dynamic> _notification = {};
  Map<String, dynamic> _event = {};

  Map<String, dynamic> get notification {
    return {..._notification};
  }

  Map<String, dynamic> get event {
    return {..._event};
  }

  Future<void> getNotification() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response =
        await http.get(Uri.parse(AppUrl.notificationList), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _notification = json.decode(response.body);
    } else {
      _notification = {};
    }

    print('Notification List: $_notification');
  }

  Future<void> getEvent() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response = await http.get(Uri.parse(AppUrl.eventList), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _event = json.decode(response.body);
    } else {
      _event = {};
    }

    print('Event List: $_event');
  }
}
