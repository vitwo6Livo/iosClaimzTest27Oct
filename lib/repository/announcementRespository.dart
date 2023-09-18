import '../models/dashboardModel.dart';
import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';
import '../models/allAnouncmentsModel.dart';

class AnnouncementRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getAnnouncement(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.allAnouncements, token);
      response = AllAnouncementsModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
