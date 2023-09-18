import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/allHolidayModel.dart';
import '../res/appUrl.dart';

class AllHolidayRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getAllHolidayList(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.allHoliday, token);
      return AllHolidayModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
