import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/taskList/toDoModel.dart';
import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';
import 'dart:convert';
import '../models/postTaskModel.dart';

class ToDoRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getToDoToday(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      response = TodayModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getToDoPrevious(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      response = PreviousModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getToDoUpcoming(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      response = UpcomingModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getToDoCompleted(String token) async {
    try {
      // dynamic response =
      //     await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.toDoList, {'all': 1}, token);
      response = CompletedModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postStatus(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.toDoListStatus, data, token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> addStatus(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.addToDoList, data, token);
      return response = TaskPostResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> editStatus(String token, dynamic data) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.editToDoList, data, token);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
