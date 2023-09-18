import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dashboardModel.dart';
import '../repository/announcementCountRepository.dart';
import '../repository/announcementRespository.dart';
import '../models/allAnouncmentsModel.dart';
import '../data/response/apiResponse.dart';
import '../res/appUrl.dart';
import './dashboardAnnouncementViewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AnnouncementViewModel with ChangeNotifier {
  Map<String, dynamic> _allAnouncements = {};
  List<dynamic> _announcementFilter = [];

  Map<String, dynamic> get allAnouncements {
    return {..._allAnouncements};
  }

  List<dynamic> get announcementFilter {
    return [..._announcementFilter];
  }

  Future<void> getAllAnouncements(String month, String year) async {
    print('month in api call: $month');
    print('year in api call: $year');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _announcementFilter = [];
    _allAnouncements = {};

    var response = await http.post(Uri.parse(AppUrl.allAnouncements),
        body: json.encode({'month': month, 'year': year}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _allAnouncements = json.decode(response.body);

      _allAnouncements['data']
          .forEach((value) => _announcementFilter.add(value));
    } else {
      _allAnouncements = {};
    }

    if (kDebugMode) {
      print('ALL ANOUNCEMENTS: $_allAnouncements');

      print('ALL FILTERED ANOUNCEMENTS: $_announcementFilter');
    }
    notifyListeners();
  }
}
