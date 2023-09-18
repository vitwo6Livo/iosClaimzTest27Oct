import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/dashboardModel.dart';
import '../res/appUrl.dart';

class OnOffRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getOnOff(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      return WorkstationModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
