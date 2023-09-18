import 'package:claimz/models/checkinClaimzModel.dart';

import '../models/profileDetailsModel.dart';
import '../res/appUrl.dart';
import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';

class ProfileRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<ProfileDetails> getProfileDetails(String token, String id) async {
    try {
      dynamic response = await baseApiService.getAuthRequests(
          '${AppUrl.profileDetails}$id', token);
      return response = ProfileDetails.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
