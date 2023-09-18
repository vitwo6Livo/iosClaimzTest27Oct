import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/organisationModel.dart';
import '../res/appUrl.dart';

class OrganizationRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getOrganisation(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.organisation, token);
      return OrganisationModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
