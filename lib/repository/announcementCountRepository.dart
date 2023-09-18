import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/dashboardModel.dart';
import '../res/appUrl.dart';

class AnnouncementCountRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getAnnouncementCount(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      return Dashboard.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
