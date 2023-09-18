import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';
import '../models/dashboardModel.dart';

class AttendanceRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getWorkList(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      response = AttendanceModel.fromJson(response['data']['dashboard_data']);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
