import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/components/alert_dialog.dart';
import 'package:flutter/material.dart';
import '../models/dashboardModel.dart';
import '../data/response/apiResponse.dart';
import '../repository/attendanceRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceViewModel with ChangeNotifier {
  final attendanceRepository = AttendanceRepository();

  ApiResponse<Dashboard> dashboard = ApiResponse.loading();
  ApiResponse<AttendanceModel> attendance = ApiResponse.loading();

  setAttendanceList(ApiResponse<AttendanceModel> response) {
    attendance = response;
    notifyListeners();
  }

  Future<void> getAttendanceList(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    print('CLICKEDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');

    attendanceRepository.getWorkList(authToken).then((value) {
      setAttendanceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAttendanceList(ApiResponse.error(error.toString()));
      // CustomDialog(
      //         title: 'Error',
      //         subtitle: error.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop());
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Task Status Changed',
        message: error.toString(),
        barBlur: 20,
      ).show(context);
    });
  }
}
