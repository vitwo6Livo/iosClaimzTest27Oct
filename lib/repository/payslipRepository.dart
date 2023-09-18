import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';

class PaySlipRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> downloadPayslip(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.downloadPayslip, token);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
