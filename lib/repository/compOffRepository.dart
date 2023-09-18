import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/lateCheckinResponseModel.dart';
import '../res/appUrl.dart';

class CompOffRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<LateCheckinResponseModel> postCompOffRepository(
      String token, dynamic data) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.compOffAdd, data, token);
      return LateCheckinResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
