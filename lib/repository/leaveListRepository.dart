import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/leaveListModel.dart';
import '../res/appUrl.dart';
import 'dart:convert';

class LeaveListRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getLeaveList(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.leaveList, token);
      response = LeaveListModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
