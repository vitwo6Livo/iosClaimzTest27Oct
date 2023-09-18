import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../models/managerDepartmentModel.dart';
import '../models/onsiteResponseModel.dart';
import '../res/appUrl.dart';

class WorkRoleRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> managerDepartment(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.managerDepartment, token);
      return ManagerDepartmentModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<OnSiteResponseModel> onSiteResponse(dynamic data, String token) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.onSite, data, token);
      return OnSiteResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<OnSiteResponseModel> offSiteResponse(
      dynamic data, String token) async {
    try {
      dynamic response =
          await baseApiService.postAuthRequests(AppUrl.offSite, data, token);
      return OnSiteResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
