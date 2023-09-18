import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/response/apiResponse.dart';
import '../../models/taskList/toDoModel.dart';
import '../../repository/toDoRepository.dart';

class PreviousTaskList with ChangeNotifier {
  final toDoRepository = ToDoRepository();
  bool isLoading = false;

  ApiResponse<ToDoModel> toDoList = ApiResponse.loading();
  ApiResponse<PreviousModel> previousModelList = ApiResponse.loading();

  setToDoList(ApiResponse<ToDoModel> response) {
    toDoList = response;
    notifyListeners();
  }

  setPreviousList(ApiResponse<PreviousModel> response) {
    previousModelList = response;
    notifyListeners();
  }

  Future<void> getPreviousList() async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    // setLoading(true);

    toDoRepository.getToDoPrevious(authToken).then((value) {
      // setLoading(false);
      EasyLoading.dismiss();
      setPreviousList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setPreviousList(ApiResponse.error(error.toString()));
    });
  }
}
