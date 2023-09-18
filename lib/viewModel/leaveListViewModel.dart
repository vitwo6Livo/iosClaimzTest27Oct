import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../repository/leaveListRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/leaveListModel.dart';
import '../data/response/apiResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../res/appUrl.dart';

class LeaveListViewModel with ChangeNotifier {
  final leaveListRepository = LeaveListRepository();

  ApiResponse<LeaveListModel> leaveList = ApiResponse.loading();

  Map<String, dynamic> _editListResponse = {};

  Map<String, dynamic> get editListResponse {
    return {..._editListResponse};
  }

  // Map<String, dynamic> _leaveList = {};

  // dynamic _leaveList;

  // dynamic get leaveListData {
  //   return _leaveList;
  // }

  setLeaveList(ApiResponse<LeaveListModel> response) {
    leaveList = response;
    notifyListeners();
  }

  Future<void> getLeaveList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    leaveListRepository.getLeaveList(authToken).then((value) {
      setLeaveList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setLeaveList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> editLeave(int id, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.editReason),
        body: json.encode({'id': id}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _editListResponse = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Leave Edited',
        // message: 'Checked In',
        barBlur: 20,
      ).show(context);
    } else {
      _editListResponse = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Leave Edited',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    print('LEave Response: $_editListResponse');
  }
}
