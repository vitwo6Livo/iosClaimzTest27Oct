import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/res/components/alert_dialog.dart';
import 'package:flutter/material.dart';
import '../models/dashboardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/upcomingHolidaysRepository.dart';

class UpcomingHolidaysViewModel with ChangeNotifier {
  final upcomingHolidaysRepository = UpcomingHolidaysRepository();
  ApiResponse<HolidayModel> upcomingHolidays = ApiResponse.loading();

  setUpcomingHolidayList(ApiResponse<HolidayModel> response) {
    upcomingHolidays = response;
    notifyListeners();
  }

  Future<void> getUpcomingHolidayList(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    upcomingHolidaysRepository.getUpcomingList(token).then((value) {
      setUpcomingHolidayList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Error',
              message: error.toString())
          .show(context);
    }
        // showDialog(
        //     context: context,
        //     builder: (context) => CustomDialog(
        //           title: 'Error',
        //           subtitle: error.toString(),
        //           onOk: () => Navigator.of(context).pop(),
        //           onCancel: () => Navigator.of(context).pop(),
        //         ))
        );
  }
}
