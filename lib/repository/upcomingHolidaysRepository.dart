import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/dashboardModel.dart';
import '../res/appUrl.dart';

class UpcomingHolidaysRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getUpcomingList(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      return HolidayModel.fromJson(response['data']['dashboard_data']);
    } catch (e) {
      throw e;
    }
  }
}
