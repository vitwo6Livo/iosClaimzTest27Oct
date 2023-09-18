import 'package:claimz/data/network/baseApiService.dart';
import 'package:claimz/data/network/networkApiService.dart';
import 'package:claimz/models/allClaimModel.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/models/travelListModel.dart';
import 'package:claimz/models/travelListstatusModel.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:image_picker/image_picker.dart';

class TravelClaimRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<iternaryModel> postIternaryDetails(
    String url,
    dynamic data,
    String token,
  ) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(url, data, token);
      response = iternaryModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<iternaryModel> getDocDetails(
    String url,
    dynamic data,
    String token,
  ) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(url, data, token);
      response = iternaryModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postPurpose(
      String travel_purpose, data, String authToken) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          travel_purpose, data, authToken);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<iternaryModel> postListTravel(
    String url,
    dynamic data,
    String token,
  ) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(url, data, token);
      response = iternaryModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postFormSubmit(String token, dynamic file_data, XFile file,
      Map<String, String> field_data) async {
    try {
      dynamic response = await baseApiService.postAuth_uploadImage(
          field_data, file, file_data, AppUrl.travel_form_submit, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postFormSubmit2(String token, dynamic file_data, dynamic file,
      dynamic file2, Map<String, String> field_data) async {
    try {
      dynamic response = await baseApiService.postAuth_uploadImage_two_files(
          field_data, file, file2, file_data, AppUrl.travel_form_submit, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<travelListModel> postTravelList(
      String travel_list_date, data, String authToken) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          travel_list_date, data, authToken);
      response = travelListModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<allClaimModel> postClaimList(
      String travel_list_date, data, String authToken) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          travel_list_date, data, authToken);
      response = allClaimModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<travelListstatusModel> postTravelListstatus(
      String travel_list_date_status, data, String authToken) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          travel_list_date_status, data, authToken);
      response = travelListstatusModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postTravelApprove(
      String travel_approval, data, String authToken) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          travel_approval, data, authToken);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
