import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/response/apiResponse.dart';
import '../../models/taskList/toDoModel.dart';
import '../../repository/tasksRespository.dart';
import '../../repository/toDoRepository.dart';

class UpcomingTaskList with ChangeNotifier {
  final toDoRepository = ToDoRepository();

  ApiResponse<ToDoModel> toDoList = ApiResponse.loading();
  ApiResponse<UpcomingModel> nextModelList = ApiResponse.loading();

  setToDoList(ApiResponse<ToDoModel> response) {
    toDoList = response;
    notifyListeners();
  }

  setUpcomingList(ApiResponse<UpcomingModel> response) {
    nextModelList = response;
    notifyListeners();
  }

  Future<void> getUpcomingList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.getToDoUpcoming(authToken).then((value) {
      setUpcomingList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUpcomingList(ApiResponse.error(error.toString()));
    });
  }
}
