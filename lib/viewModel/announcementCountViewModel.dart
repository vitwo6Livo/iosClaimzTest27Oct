import 'package:claimz/data/response/apiResponse.dart';
import 'package:flutter/material.dart';
import '../models/dashboardModel.dart';
import '../repository/announcementCountRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementCountViewModel with ChangeNotifier {
  final announcementCountRepository = AnnouncementCountRepository();
  ApiResponse<Dashboard> dashBoardData = ApiResponse.loading();

  setAnnouncementCount(ApiResponse<Dashboard> response) {
    dashBoardData = response;
    notifyListeners();
  }

  Future<void> getAnnouncementCount() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    announcementCountRepository
        .getAnnouncementCount(token)
        .then((value) => setAnnouncementCount(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            setAnnouncementCount(ApiResponse.error(error.toString())));
  }
}
