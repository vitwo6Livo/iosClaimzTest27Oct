import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/response/apiResponse.dart';
import '../../models/taskList/toDoModel.dart';
import '../../repository/toDoRepository.dart';

class CompletedTaskList with ChangeNotifier {
  final toDoRepository = ToDoRepository();

  ApiResponse<ToDoModel> toDoList = ApiResponse.loading();
  ApiResponse<CompletedModel> completedModelList = ApiResponse.loading();

  setToDoList(ApiResponse<ToDoModel> response) {
    toDoList = response;
    notifyListeners();
  }

  setCompletedList(ApiResponse<CompletedModel> response) {
    completedModelList = response;
    notifyListeners();
  }

  Future<void> getCompletedList() async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.getToDoCompleted(authToken).then((value) {
      EasyLoading.dismiss();

      setCompletedList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setCompletedList(ApiResponse.error(error.toString()));
    });
  }
}
