import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/leaveRemainingModel.dart';
import '../res/appUrl.dart';

class LeaveRemainingRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getRemainingLeaves(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.remainingLeaves, token);
      response = LeaveRemainingModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
