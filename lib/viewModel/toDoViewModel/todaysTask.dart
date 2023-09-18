import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/response/apiResponse.dart';
import '../../models/taskList/toDoModel.dart';
import '../../repository/tasksRespository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../repository/toDoRepository.dart';
import '../../res/components/alert_dialog.dart';
import '../toDoViewModel.dart';

class TodaysTaskList with ChangeNotifier {
  final toDoRepository = ToDoRepository();

  ApiResponse<ToDoModel> toDoList = ApiResponse.loading();
  ApiResponse<TodayModel> todayModelList = ApiResponse.loading();

  setToDoList(ApiResponse<ToDoModel> response) {
    toDoList = response;
    notifyListeners();
  }

  setTodayList(ApiResponse<TodayModel> response) {
    todayModelList = response;
    notifyListeners();
  }

  Future<void> getTodayList() async {
    EasyLoading.show(status: 'loading...');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    toDoRepository.getToDoToday(authToken).then((value) {
      EasyLoading.dismiss();
      setTodayList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      setTodayList(ApiResponse.error(error.toString()));
    });
  }

  Map<String, dynamic> _getToDoList = {};

  List<Map<String, dynamic>> _workCurrent = [];

  List<Map<String, dynamic>> _workPrevious = [];

  List<Map<String, dynamic>> _workUpcoming = [];

  List<Map<String, dynamic>> _personal = [];

  List<Map<String, dynamic>> _personalCurrent = [];

  List<Map<String, dynamic>> _personalPrevious = [];

  List<Map<String, dynamic>> _personalUpcoming = [];

  Map<String, dynamic> get getToDoList {
    return {..._getToDoList};
  }

  List<Map<String, dynamic>> get workCurrent {
    return [..._workCurrent];
  }

  List<Map<String, dynamic>> get workPrevious {
    return [..._workPrevious];
  }

  List<Map<String, dynamic>> get workUpcoming {
    return [..._workUpcoming];
  }

  List<Map<String, dynamic>> get personalCurrent {
    return [..._personalCurrent];
  }

  List<Map<String, dynamic>> get personalPrevious {
    return [..._personalPrevious];
  }

  List<Map<String, dynamic>> get personalUpcoming {
    return [..._personalUpcoming];
  }

  Future<dynamic> postTodaysTask(
      Map<String, dynamic> data, int difference, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print('DIFFFFFEEEEEREEENCE: $difference');
    }

    var response = await http
        .post(Uri.parse(AppUrl.addToDoList), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      print('TASK ADDDDDDDDD: $responseData');

      if (difference == 0) {
        // _getToDoList['today'].add(data);
        Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (difference > 0) {
        print('DIFFFFFEEEEEREEENCE EEEEEEE: $difference');

        // _getToDoList['upcoming'].add(data);
        Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else {
        // _getToDoList['previous'].add(data);
        Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }
      // showDialog(context: context, builder: (context) => CustomDialog(
      //   title: 'Task Added',
      //   subtitle: response['data'],
      // ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'],
        barBlur: 20,
      )
          .show(context)
          .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              }));
    } else {
      var responseData = json.decode(response.body);

      print('TASK ADDDDDDDDD: $responseData');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'An Error Occured, Please Try Again Later',
        barBlur: 20,
      ).show(context);
    }

    print('Product Added: ${_getToDoList['today']}');
    notifyListeners();
  }

  Future<dynamic> assignTask(
      Map<String, dynamic> data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .post(Uri.parse(AppUrl.assignTask), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'],
        barBlur: 20,
      ).show(context);
    } else {
      var responseData = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        leftBarIndicatorColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'],
        barBlur: 20,
      ).show(context);
    }

    print('TASK ASSIGN RESPONSE: ${json.decode(response.body)}');
  }

  Future<dynamic> markTaskComplete(
      Map<String, dynamic> data, BuildContext context) async {}

  // Future<dynamic> updateTaskStatus(Map<String, dynamic> payload, BuildContext context) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   var response = await http
  //       .post(Uri.parse(AppUrl.toDoListStatus), body: json.encode(payload), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${localStorage.getString('token')}'
  //   });

  //   if(response.statusCode == 200) {
  //     _getToDoList['completed']
  //   }
  // }

  Future<void> getTodaysTasks(int num) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Numberrrrr: $num');

    _workCurrent = [];
    _workPrevious = [];
    _workUpcoming = [];

    _personalCurrent = [];
    _personalPrevious = [];
    _personalUpcoming = [];

    var response = await http.post(Uri.parse(AppUrl.toDoList),
        body: json.encode({'all': num}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _getToDoList = json.decode(response.body);

      // _getToDoList.addAll({"today_length":_getToDoList["previous"].length});

      for (int i = 0; i < _getToDoList['today'].length; i++) {
        if (_getToDoList['today'][i]['category'] == 'work') {
          _workCurrent.add(_getToDoList['today'][i]);
        } else {
          _personalCurrent.add(_getToDoList['today'][i]);
        }
      }

      for (int j = 0; j < _getToDoList['previous'].length; j++) {
        if (_getToDoList['previous'][j]['category'] == 'work') {
          _workPrevious.add(_getToDoList['previous'][j]);
        } else {
          _personalPrevious.add(_getToDoList['previous'][j]);
        }
      }

      for (int k = 0; k < _getToDoList['upcoming'].length; k++) {
        if (_getToDoList['upcoming'][k]['category'] == 'work') {
          _workUpcoming.add(_getToDoList['upcoming'][k]);
        } else {
          _personalUpcoming.add(_getToDoList['upcoming'][k]);
        }
      }
    } else {
      _getToDoList = {};
    }
    print('TO DO LIST: $_getToDoList');
    notifyListeners();
  }

  Future<void> deleteTask(
      Map<String, dynamic> data, int selection, String type) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // _workCurrent = [];
    // _workPrevious = [];
    // _workUpcoming = [];

    // _personalCurrent = [];
    // _personalPrevious = [];
    // _personalUpcoming = [];

    var response = await http
        .get(Uri.parse('${AppUrl.deleteToDoList}${data['id']}'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      print('ACTUAL LISTTTTTTT: $_workPrevious');

      print('LISTTTTTTT: ${_getToDoList['previous']}');

      // data.removeWhere((element) => element['task_id'].toString() == num);

      // _getToDoList['previous'].removeWhere((element) => element['task_id'].toString() == num);

      if (selection == 0 && type == 'Pending') {
        _getToDoList['previous'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
      } else if (selection == 0 && type == 'Today') {
        _getToDoList['today'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 0 && type == 'Upcoming') {
        _getToDoList['upcoming'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }

      if (selection == 1 && type == 'Pending') {
        _getToDoList['previous'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
      } else if (selection == 1 && type == 'Today') {
        _workCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['today'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 1 && type == 'Upcoming') {
        _workUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['upcoming'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }

      if (selection == 2 && type == 'Pending') {
        _getToDoList['previous'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
      } else if (selection == 2 && type == 'Today') {
        _personalCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['today'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 2 && type == 'Upcoming') {
        _personalUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['upcoming'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }

      // _getToDoList.addAll({"today_length":_getToDoList["previous"].length});

      // for (int i = 0; i < _getToDoList['today'].length; i++) {
      //   if (_getToDoList['today'][i]['category'] == 'work') {
      //     _workCurrent.removeAt(_getToDoList['today'][i]);
      //   } else {
      //     _personalCurrent.removeAt(_getToDoList['today'][i]);
      //   }
      // }

      // for (int j = 0; j < _getToDoList['previous'].length; j++) {
      //   if (_getToDoList['previous'][j]['category'] == 'work') {
      //     _workPrevious.removeAt(_getToDoList['previous'][j]);
      //   } else {
      //     _personalPrevious.removeAt(_getToDoList['previous'][j]);
      //   }
      // }

      // for (int k = 0; k < _getToDoList['upcoming'].length; k++) {
      //   if (_getToDoList['upcoming'][k]['category'] == 'work') {
      //     _workUpcoming.removeAt(_getToDoList['upcoming'][k]);
      //   } else {
      //     _personalUpcoming.removeAt(_getToDoList['upcoming'][k]);
      //   }
      // }
      print('TO DO LIST: $responseData');
    } else {
      _getToDoList = {};
    }
    notifyListeners();
  }

  Future<void> changeTaskStatus(
      String type, int selection, dynamic data, BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.toDoListStatus),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      EasyLoading.dismiss();

      var responseData = json.decode(response.body);

      if (selection == 0 && type == 'Pending') {
        _getToDoList['previous'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 0 && type == 'Today') {
        _getToDoList['today'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 0 && type == 'Upcoming') {
        _getToDoList['upcoming'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _workUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _personalUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }

      if (selection == 1 && type == 'Pending') {
        _workPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['previous'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 1 && type == 'Today') {
        _workCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['today'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 1 && type == 'Upcoming') {
        _workUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['upcoming'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }

      if (selection == 2 && type == 'Pending') {
        _personalPrevious.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['previous'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 2 && type == 'Today') {
        _personalCurrent.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['today'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      } else if (selection == 2 && type == 'Upcoming') {
        _personalUpcoming.removeWhere(
            (element) => element['task_id'].toString() == data['id']);

        _getToDoList['upcoming'].removeWhere(
            (element) => element['task_id'].toString() == data['id']);
        // Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(1);
      }

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Task Marked As Completed',
        message: responseData['data'],
        barBlur: 20,
      ).show(context);
      // .then((value) =>
    } else {
      var responseData = json.decode(response.body);
      print(responseData);
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'An Error Occured',
        message: responseData['data'],
        // message: responseData['data'],
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }
}
