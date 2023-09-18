import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/models/postTaskModel.dart';
import 'package:flutter/material.dart';
import '../models/taskList/toDoModel.dart';
import '../repository/tasksRespository.dart';
import '../data/response/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../repository/toDoRepository.dart';
import '../res/appUrl.dart';
import 'dart:convert';

import '../res/components/alert_dialog.dart';

class ToDoViewModel with ChangeNotifier {
  final toDoRepository = ToDoRepository();

  ApiResponse<ToDoModel> toDoList = ApiResponse.loading();
  ApiResponse<TaskPostResponse> taskPost = ApiResponse.loading();

  ApiResponse<TodayModel> todayModelList = ApiResponse.loading();
  ApiResponse<PreviousModel> previousModelList = ApiResponse.loading();
  ApiResponse<UpcomingModel> nextModelList = ApiResponse.loading();
  ApiResponse<CompletedModel> completedModelList = ApiResponse.loading();

  setToDoList(ApiResponse<ToDoModel> response) {
    toDoList = response;
    notifyListeners();
  }

  setTodayList(ApiResponse<TodayModel> response) {
    todayModelList = response;
    notifyListeners();
  }

  setPreviousList(ApiResponse<PreviousModel> response) {
    previousModelList = response;
    notifyListeners();
  }

  setUpcomingList(ApiResponse<UpcomingModel> response) {
    nextModelList = response;
    notifyListeners();
  }

  setCompletedList(ApiResponse<CompletedModel> response) {
    completedModelList = response;
    notifyListeners();
  }

  postTaskList(ApiResponse<TaskPostResponse> response) {
    taskPost = response;
    notifyListeners();
  }

  Map<String, dynamic> _taskList = {};

  Map<String, dynamic> get taskList {
    return {..._taskList};
  }

  Future<void> getAllToDoList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(AppUrl.toDoList), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });
    if (response.statusCode == 200) {
      _taskList = json.decode(response.body);
    } else {
      _taskList = {};
    }
    notifyListeners();
  }

  Future<void> getTodayList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.getToDoToday(authToken).then((value) {
      setTodayList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setTodayList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getPreviousList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.getToDoPrevious(authToken).then((value) {
      setPreviousList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPreviousList(ApiResponse.error(error.toString()));
    });
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

  Future<void> getCompletedList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.getToDoCompleted(authToken).then((value) {
      setCompletedList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCompletedList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postToDoList(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.postStatus(authToken, data).then((value) {
      setToDoList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setToDoList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> addToDo(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.addStatus(authToken, data).then((value) {
      postTaskList(ApiResponse.completed(value));
      // showDialog(
      //   context: context,
      //   builder: (context) => CustomDialog(
      //     title: 'Task Added Successfully',
      //     subtitle: value.toString(),
      //     onOk: () => Navigator.of(context).pop(),
      //     onCancel: () => Navigator.of(context).pop(),
      //   ));
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Task Added Successfully',
              message: value.toString())
          .show(context);
    }).onError((error, stackTrace) {
      postTaskList(ApiResponse.error(error.toString()));
      // showDialog(
      //   context: context,
      //   builder: (context) => CustomDialog(
      //     title: 'Task Addition Failed',
      //     subtitle: error.toString(),
      //     onOk: () => Navigator.of(context).pop(),
      //     onCancel: () => Navigator.of(context).pop(),
      //   ));
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Task Addition Failed',
              message: error.toString())
          .show(context);
    });
  }

  // Future<dynamic> addToDo(dynamic data, BuildContext context) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   var response = await http.post(Uri.parse(AppUrl.toDoList), body: json.encode(data), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${localStorage.getString('token')}'
  //   });

  //   if(response.statusCode == 200) {

  //   }
  // }

  Future<void> editToDo(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.editStatus(authToken, data).then((value) {
      setToDoList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setToDoList(ApiResponse.error(error.toString()));
    });
  }
}
