import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/dashboardModel.dart';
import '../res/appUrl.dart';

class DashboardAnnouncementRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getDashboardAnnouncement(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      return AnnouncementModel.fromJson(response['data']['dashboard_data']);
    } catch (e) {
      throw e;
    }
  }
}
