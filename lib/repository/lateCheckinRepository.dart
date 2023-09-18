import 'package:flutter/foundation.dart';

import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/lateCheckinModel.dart';
import '../models/lateCheckinResponseModel.dart';
import '../res/appUrl.dart';

class LateCheckinRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getLateCheckinRequests(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.lateCheckinList, token);
      response = LateCheckinModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<LateCheckinResponseModel> postLateCheckInApproval(
      String token, dynamic data, int lateId) async {
    if (kDebugMode) {
      print(token);
      print(data);
      print(lateId);
    }

    try {
      dynamic response = await baseApiService.postAuthRequests(
          '${AppUrl.lateCheckinApproval}$lateId', data, token);
      if (kDebugMode) {
        print('RESPONSEEEEEEEEEEEEEEEEEEEEEEEE ${response["msg"]}');
      }
      return LateCheckinResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
