import 'package:flutter/material.dart';

import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';

class AuthRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await baseApiService.postApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> logOut(String token) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.logOut, {}, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changePassword(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.changePassword, data, token);
    } catch (e) {
      throw e;
    }
  }
}
