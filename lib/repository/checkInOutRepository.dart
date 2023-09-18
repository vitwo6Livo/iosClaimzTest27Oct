import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';

class CheckInOutRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> checkInOut(String token, dynamic data) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.checkInOut, data, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> checkOut(String token, dynamic data) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.checkOut, data, token);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
