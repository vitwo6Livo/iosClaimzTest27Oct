import 'package:claimz/data/network/baseApiService.dart';
import 'package:claimz/data/network/networkApiService.dart';
import 'package:claimz/models/conveynanceLogsListModel.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/models/travellistlog.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:image_picker/image_picker.dart';

class LogsClaimRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<travellistlogModel> postLogsList(
      String Logs_list_date, data, String authToken) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          Logs_list_date, data, authToken);
      response = travellistlogModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postLogsApprove(
      String Logs_approval, data, String authToken) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(Logs_approval, data, authToken);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<ConyenanceLogsListModel> postConveynanceList(
      String url, data, String authToken) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(url, data, authToken);
      response = ConyenanceLogsListModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
