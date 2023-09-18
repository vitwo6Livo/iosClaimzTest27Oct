import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';
import '../models/leaveRequestModel.dart';

class LeaveRequestRepository {
  BaseApiService _baseApiService = NetworkServiceApi();

  Future<LeaveRequestResponseModel> requestLeave(
      String token, dynamic data) async {
    try {
      dynamic response = await _baseApiService.postAuthRequests(
          AppUrl.leaveRequest, data, token);
      return LeaveRequestResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
