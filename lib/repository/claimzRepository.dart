import 'package:claimz/data/network/baseApiService.dart';
import 'package:claimz/data/network/networkApiService.dart';
import 'package:claimz/models/User_limit.dart';
import 'package:claimz/models/checkinClaimzMeetingModel.dart';
import 'package:claimz/models/checkinClaimzModel.dart';
import 'package:claimz/models/checkoutModel.dart';
import 'package:claimz/models/claimzDetailModel.dart';
import 'package:claimz/models/claimz_HistoryModel.dart';
import 'package:claimz/models/estimasteDistanceModel.dart';
import 'package:claimz/models/searchUserModel.dart';
import 'package:claimz/res/appUrl.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ClaimzRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> postClaimzForm(
    String url,
    dynamic data,
    String token,
  ) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(url, data, token);
      Map<String, dynamic> resp = Map();
      resp['status'] = response['status'];
      resp['msg'] = response['data'];
      response = resp;
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<checkin_claimz_Model> postCheckinClaimz(
      String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.checkin_claimz, data, token);
      response = checkin_claimz_Model.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postClaimzExecute(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.claimz_execute, data, token);
      Map<String, dynamic> resp = Map();
      resp['status'] = response['status'];
      response = resp;
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postClaimzRange(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.claimz_check_in_range, data, token);
      Map<String, dynamic> resp = Map();
      resp['status'] = response['status'];
      resp['distance'] = response['distance'];
      response = resp;
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postclaimzSubmission(String token, dynamic file_data,
      XFile file, Map<String, String> field_data) async {
    try {
      dynamic response = await baseApiService.postAuth_uploadImage(
          field_data, file, file_data, AppUrl.claimz_form_submit, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postclaimzSubmissionIncidental(String token,
      dynamic file_data, dynamic file, Map<String, String> field_data) async {
    try {
      dynamic response = await baseApiService.postAuth_uploadImage(
          field_data, file, file_data, AppUrl.claimz_incidental_submit, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Future<dynamic> postFinalClaimzSubmissionIncidental(
  //     String token,
  //     // dynamic file_data,
  //     // dynamic file,
  //     Map <String,String> field_data
  //     ) async {
  //   try {
  //     dynamic response = await baseApiService.postAuth_uploadImage( field_data,
  //     // file,
  //     // file_data,
  //         AppUrl.incidentalFinalSubmit, token);
  //     return response;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<checkin_claimz_meeting_Model> postCheckinMeetingClaimz(
      String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.checkin_claimz_meeting, data, token);
      response = checkin_claimz_meeting_Model.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<claimzdetailModel> getCheckinDetailsClaimz(token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.claimz_page_data, token);
      response = claimzdetailModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Future<User_limit> getClaimzUserLimit(dynamic data, token) async {
  //   try {
  //     dynamic response = await baseApiService.postAuthRequests(AppUrl.claimz_form_limit, data, token);
  //     response = User_limit.fromJson(response);
  //     return response;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<estimateDistanceModel> getEstimatedData(String Url) async {
    try {
      dynamic response = await baseApiService.getApiResponse(Url);

      dynamic dataResponse = {
        "destination": response["destination_addresses"][0].toString(),
        "distance": (int.parse(response["rows"][0]["elements"][0]["distance"]
                        ["value"]
                    .toString()) /
                1000)
            .toString(),
        "time": (int.parse(response["rows"][0]["elements"][0]["duration"]
                        ["value"]
                    .toString()) /
                60)
            .toString()
      };

      response = estimateDistanceModel.fromJson(dataResponse);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<checkoutModel> postCheckoutClaimz(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.claimz_checkout, data, token);
      response = checkoutModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Claimz_HistoryModel> postClaimzHistoryList(String token, data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.claimz_list, data, token);
      response = Claimz_HistoryModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Search_UserModel> postUserList(String token, data) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.userSearch, data, token);
      response = Search_UserModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postapproval(String token, data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.claimzapproval, data, token);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
