import '../models/dashboardModel.dart';
import '../res/appUrl.dart';
import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';

class HolidayRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<HolidayModel> getHolidays(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      response = HolidayModel.fromJson(response['data']['dashboard_data']);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Future<dynamic> getHolidays(String token) async {
  //   try {
  //     dynamic response =
  //         await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
  //     return json.decode(response.body);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
