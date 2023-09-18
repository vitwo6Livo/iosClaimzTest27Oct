import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/dashboardModel.dart';
import '../res/appUrl.dart';

class ClaimzDashboard {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getClaimzStatus(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.dashBoard, token);
      response = DashboardData.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
