import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';
import '../models/regularizationManagerModel.dart';

class RegularisationRequestRepository {
  BaseApiService apiService = NetworkServiceApi();

  Future<dynamic> getRegularisationRequests(String token) async {
    try {
      dynamic response =
          apiService.getAuthRequests(AppUrl.viewRegularizationManager, token);
      response = ViewRegularizationManagers.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
