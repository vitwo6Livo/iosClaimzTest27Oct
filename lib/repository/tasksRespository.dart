import 'package:shared_preferences/shared_preferences.dart';
import '../models/taskList/toDoModel.dart';
import '../data/network/baseApiService.dart';
import '../data/network/networkApiService.dart';
import '../res/appUrl.dart';
import '../models/taskList/tasksResponseModel.dart';

class TaskListRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> getTodaysTasks(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      return TodayModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPreviousTasks(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      return PreviousModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getUpcomingTasks(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      return UpcomingModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getCompletedTasks(String token) async {
    try {
      dynamic response =
          await baseApiService.getAuthRequests(AppUrl.toDoList, token);
      return UpcomingModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<TasksResponseModel> addTask(dynamic data, String token) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.addToDoList, data, token);
      return TasksResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<TasksResponseModel> editTask(dynamic data, String token) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.editToDoList, data, token);
      return TasksResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<TasksResponseModel> updateTaskStatus(
      dynamic data, String token) async {
    try {
      dynamic response = await baseApiService.postAuthRequests(
          AppUrl.toDoListStatus, data, token);
      return TasksResponseModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
