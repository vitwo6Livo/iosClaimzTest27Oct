import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/lateCheckinResponseModel.dart';
import '../res/appUrl.dart';

class RegularisationRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<LateCheckinResponseModel> addRegularization(
      dynamic data, dynamic token) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.regularizationAdd, data, token);
      return LateCheckinResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
