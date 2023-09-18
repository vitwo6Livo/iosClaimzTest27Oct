import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/viewModel/toDoViewModel/upcomingTaskList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../models/taskList/toDoModel.dart';
import '../../repository/tasksRespository.dart';
import '../../res/appUrl.dart';
import '../../res/components/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './previousTaskList.dart';
import './todaysTask.dart';
import './todaysTask.dart';
import 'package:http/http.dart' as http;

class TasksViewModel with ChangeNotifier {
  final tasksRepository = TaskListRepository();
  ApiResponse<ToDoModel> toDoList = ApiResponse.loading();
  ApiResponse<TodayModel> todayModelList = ApiResponse.loading();
  ApiResponse<PreviousModel> previousModelList = ApiResponse.loading();
  ApiResponse<UpcomingModel> nextModelList = ApiResponse.loading();
  ApiResponse<CompletedModel> completedModelList = ApiResponse.loading();

  // setUpcomingTaskList(ApiResponse<ToDoModel> response) {
  //   toDoList = response;
  //   notifyListeners();
  // }

  setTodaysTaskList(ApiResponse<TodayModel> response) {
    todayModelList = response;
    notifyListeners();
  }

  setPreviousTaskList(ApiResponse<PreviousModel> response) {
    previousModelList = response;
    notifyListeners();
  }

  setUpcomingTaskList(ApiResponse<UpcomingModel> response) {
    nextModelList = response;
    notifyListeners();
  }

  setCompletedTaskList(ApiResponse<CompletedModel> response) {
    completedModelList = response;
    notifyListeners();
  }

  Future<void> getTodaysTask() async {
    EasyLoading.show(status: 'loading...');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    print('ENTEREEEEEEED');

    tasksRepository.getTodaysTasks(token).then((value) {
      EasyLoading.dismiss();
      setTodaysTaskList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setTodaysTaskList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getPreviousTask() async {
    EasyLoading.show(status: 'loading...');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    tasksRepository.getPreviousTasks(token).then((value) {
      setPreviousTaskList(ApiResponse.completed(value));
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setPreviousTaskList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getUpcomingTask() async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    tasksRepository.getUpcomingTasks(token).then((value) {
      EasyLoading.dismiss();
      setUpcomingTaskList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setUpcomingTaskList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCompletedTask() async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    tasksRepository.getCompletedTasks(token).then((value) {
      EasyLoading.dismiss();
      setCompletedTaskList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setCompletedTaskList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> addTasks(dynamic data, BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    tasksRepository.addTask(data, token).then((value) {
      print('BLOCK ENTERED');
      EasyLoading.dismiss();
      Provider.of<TasksViewModel>(context, listen: false).getTodaysTask();

      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Task Added',
      //           subtitle: value.data.toString(),
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Task Added',
        message: value.data.toString(),
        barBlur: 20,
      ).show(context);

      // Provider.of<TasksViewModel>(context, listen: false).getPreviousTasks();
      // Provider.of<TasksViewModel>(context, listen: false).getTodaysTasks();
      // Provider.of<TasksViewModel>(context, listen: false).getUpcomingTasks();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Task Added',
        message: error.toString(),
        barBlur: 20,
      ).show(context);
    }
        // showDialog(
        //     context: context,
        //     builder: (context) => CustomDialog(
        //           title: 'An Error Occured',
        //           subtitle: error.toString(),
        //           onOk: () => Navigator.of(context).pop(),
        //           onCancel: () => Navigator.of(context).pop(),
        //         ))

        );
  }

  Future<void> editTask(dynamic data, BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    tasksRepository.editTask(data, token).then((value) {
      EasyLoading.dismiss();
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Task Edited',
      //           subtitle: value.data.toString(),
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Task Edited',
        message: value.data.toString(),
        barBlur: 20,
      ).show(context);
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Task Edited',
        message: error.toString(),
        barBlur: 20,
      ).show(context);
    }
        // showDialog(
        //     context: context,
        //     builder: (context) => CustomDialog(
        //           title: 'An Error Occured',
        //           subtitle: error.toString(),
        //           onOk: () => Navigator.of(context).pop(),
        //           onCancel: () => Navigator.of(context).pop(),
        //         ))
        );
  }
}
