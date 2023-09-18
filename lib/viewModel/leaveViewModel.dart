import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../repository/leaveRequestRepository.dart';
import '../data/response/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/components/alert_dialog.dart';
import '../res/appUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../views/screens/success_tick_screen.dart';

class LeaveViewModel with ChangeNotifier {
  final leaveRepository = LeaveRequestRepository();

  Future<void> postLeaveRequests(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    leaveRepository.requestLeave(authToken, data).then((value) {
      print('LEAVEEEEEE: $value');

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));
      // EasyLoading.showSuccess("Leave Request Submitted")
      //     .then((value) => Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => SuccessTickScreen())))
      //     .then((value) {
      //   // Provider.of<UserIncidentalViewModel>(context, listen: false)
      //   //     .getUserIncidental();
      //   // Navigator.of(context).pop();
      // });
      // EasyLoading.dismiss();

      // Flushbar(
      //   duration: const Duration(seconds: 4),
      //   flushbarPosition: FlushbarPosition.BOTTOM,
      //   borderRadius: BorderRadius.circular(10),
      //   icon: const Icon(Icons.error, color: Colors.white),
      //   // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      //   title: 'Leave Request Submitted',
      //   message: value.data.toString()
      // ).show(context);
    }).onError((error, stackTrace) {
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Leave Request Failed',
              message: error.toString())
          .show(context);
    });
  }

  Future<void> postCompOffRequest(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.applyCompOff),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    var serverResponse = json.decode(response.body);

    if (serverResponse['status'] != 205) {
      print('COMP OFF: $serverResponse');

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));

      // EasyLoading.showSuccess("Comp Off Submission").then((value) =>
      //     Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => SuccessTickScreen())));
      // EasyLoading.dismiss();

      // if (serverResponse['status'] == 205) {
      //   Flushbar(
      //           duration: const Duration(seconds: 3),
      //           flushbarPosition: FlushbarPosition.BOTTOM,
      //           borderRadius: BorderRadius.circular(10),
      //           icon: const Icon(Icons.error, color: Colors.white),
      //           // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      //           // title: 'Leave Request Submitted',
      //           message: serverResponse['data'])
      //       .show(context);
      // } else {
      //   EasyLoading.showSuccess("Comp Off Submission").then((value) =>
      //       Navigator.of(context).push(
      //           MaterialPageRoute(builder: (context) => SuccessTickScreen())));
      //   EasyLoading.dismiss();
      // }
    } else if (response.statusCode == 205 || serverResponse['status'] == 205) {
      var serverResponse = json.decode(response.body);

      print('COMP OFF: $serverResponse');
      Flushbar(
              duration: const Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              // title: 'Leave Request Submitted',
              message: serverResponse['data'])
          .show(context);
    } else {
      var serverResponse = json.decode(response.body);

      print('COMP OFF FAILED: $serverResponse');
      Flushbar(
              duration: const Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              // title: 'Leave Request Submitted',
              message: 'Comp Off Submission Failed')
          .show(context);
    }
  }
}
