import 'package:claimz/data/response/apiResponse.dart';
import 'package:flutter/material.dart';
import '../models/dashboardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/announcementCountRepository.dart';
import '../repository/dashboardAnouncementRepository.dart';

class DashboardAnnouncementViewModel with ChangeNotifier {
  final dashboardAnouncementRepository = DashboardAnnouncementRepository();
  final announcementCountRepository = AnnouncementCountRepository();

  ApiResponse<AnnouncementModel> dashboardAnnouncement = ApiResponse.loading();
  ApiResponse<Dashboard> dashBoardData = ApiResponse.loading();

  setDashBoardAnnouncementList(ApiResponse<AnnouncementModel> response) {
    dashboardAnnouncement = response;
    notifyListeners();
  }

  setAnnouncementCount(ApiResponse<Dashboard> response) {
    dashBoardData = response;
    notifyListeners();
  }

  Future<void> getDashboardAnnouncements() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    dashboardAnouncementRepository
        .getDashboardAnnouncement(token)
        .then((value) =>
            setDashBoardAnnouncementList(ApiResponse.completed(value)))
        .onError((error, stackTrace) {
      setDashBoardAnnouncementList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getDashboardAnnouncementCount() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    announcementCountRepository.getAnnouncementCount(token).then((value) {
      setAnnouncementCount(ApiResponse.completed(value));
      print('COUNT VALUE: ${value.toString()}');
    }).onError((error, stackTrace) =>
        setAnnouncementCount(ApiResponse.error(error.toString())));
  }
}
