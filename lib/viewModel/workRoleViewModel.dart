import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/response/apiResponse.dart';
import '../repository/workRoleRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/managerDepartmentModel.dart';
import '../res/components/alert_dialog.dart';
import 'package:http/http.dart' as http;
import '../res/appUrl.dart';
import 'dart:convert';

class WorkRoleViewModel with ChangeNotifier {
  final workRoleRepository = WorkRoleRepository();
  // ApiResponse<ManagerDepartmentModel> getDepartmentList = ApiResponse.loading();

  // setDepartmentList(ApiResponse<ManagerDepartmentModel> response) {
  //   getDepartmentList = response;
  //   notifyListeners();
  // }

  Map<String, dynamic> _departmentList = {};
  Map<String, dynamic> _response = {};
  List<Map<String, dynamic>> _workRoleList = [];

  Map<String, dynamic> get departmentList {
    return {..._departmentList};
  }

  List<dynamic> get workRoleList {
    return [..._workRoleList];
  }

  Future<void> getManagerDepartmentList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse(AppUrl.managerDepartment), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      _departmentList = json.decode(response.body);
      // _workRoleList = _departmentList['data'];
    } else {
      _departmentList = {};
    }

    print('Work Role List: $_workRoleList');

    notifyListeners();

    // String token = localStorage.getString('token').toString();

    // workRoleRepository.managerDepartment(token).then((value) {
    //   setDepartmentList(ApiResponse.completed(value));
    // }).onError((error, stackTrace) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => CustomDialog(
    //             title: 'An Error Occured',
    //             subtitle: error.toString(),
    //             onOk: () => Navigator.of(context).pop(),
    //             onCancel: () => Navigator.of(context).pop(),
    //           ));
    // });
  }

  Future<void> onSiteEnable(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Onsite: $data');

    var response = await http
        .post(Uri.parse(AppUrl.onSite), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      _response = json.decode(response.body);
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Status Changed',
      //           subtitle: _response['msg'],
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Status Changed',
              message: _response['msg'])
          .show(context);
      Provider.of<WorkRoleViewModel>(context, listen: false)
          .getManagerDepartmentList();
    } else {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Error Occured',
      //           subtitle: _response['msg'],
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Error Occured',
              message: _response['msg'])
          .show(context);
    }

    notifyListeners();

    // String token = localStorage.getString('token').toString();

    // workRoleRepository.onSiteResponse(data, token).then((value) {
    //   Provider.of<WorkRoleViewModel>(context, listen: false)
    //       .getManagerDepartmentList(context);

    //   showDialog(
    //       context: context,
    //       builder: (context) => CustomDialog(
    //             title: 'Success',
    //             subtitle: value.msg.toString(),
    //             onOk: () => Navigator.of(context).pop(),
    //             onCancel: () => Navigator.of(context).pop(),
    //           ));
    // }).onError((error, stackTrace) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => CustomDialog(
    //             title: 'Error',
    //             subtitle: error.toString(),
    //             onOk: () => Navigator.of(context).pop(),
    //             onCancel: () => Navigator.of(context).pop(),
    //           ));
    // });
  }

  Future<void> offSiteEnable(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Offsite: $data');

    var response = await http
        .post(Uri.parse(AppUrl.offSite), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      _response = json.decode(response.body);
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Status Changed',
      //           subtitle: _response['msg'],
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Status Changed',
              message: _response['msg'])
          .show(context);
      Provider.of<WorkRoleViewModel>(context, listen: false)
          .getManagerDepartmentList();
    } else {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Error Occured',
      //           subtitle: _response['msg'],
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));

      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Error Occured',
              message: _response['msg'])
          .show(context);
    }

    notifyListeners();

    // String token = localStorage.getString('token').toString();

    // workRoleRepository.offSiteResponse(data, token).then((value) {
    //   Provider.of<WorkRoleViewModel>(context, listen: false)
    //       .getManagerDepartmentList(context);

    //   showDialog(
    //       context: context,
    //       builder: (context) => CustomDialog(
    //             title: 'Success',
    //             subtitle: value.msg.toString(),
    //             onOk: () => Navigator.of(context).pop(),
    //             onCancel: () => Navigator.of(context).pop(),
    //           ));
    // }).onError((error, stackTrace) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => CustomDialog(
    //             title: 'Error',
    //             subtitle: error.toString(),
    //             onOk: () => Navigator.of(context).pop(),
    //             onCancel: () => Navigator.of(context).pop(),
    //           ));
    // });
  }
}
