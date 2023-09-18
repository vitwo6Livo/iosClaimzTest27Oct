import 'package:claimz/models/dashboardModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/holidayRepository.dart';
import 'package:provider/provider.dart';
import './userViewModel.dart';
import '../data/response/apiResponse.dart';

class HolidayViewModel with ChangeNotifier {
  final holidayRepository = HolidayRepository();

  ApiResponse<Dashboard> dashBoardData = ApiResponse.loading();
  ApiResponse<HolidayModel> holidayData = ApiResponse.loading();

  setHolidayList(ApiResponse<HolidayModel> response) {
    holidayData = response;
    print('Holiday Response: $holidayData');
    notifyListeners();
  }

  Future<void> getHolidayList(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // String authToken =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2OTI2MDc2NjMsInN1YiI6OTI1LCJpc3MiOiJodHRwOi8vY2xhaW16LnZpdHdvLmluL2FwaS9sb2dpbiIsImlhdCI6MTY2MTA3MTY2MywibmJmIjoxNjYxMDcxNjYzLCJqdGkiOiI3VHlnVmdHZGFVaHo3dnNpIn0.IbrrW58QtHr7_epP3m9x-NSZvvCjiWCg1CpSLEHS_Io';

    String authToken = localStorage.getString('token').toString();

    print('TOKEEEEEEEEEEEEEN: $authToken');

    setHolidayList(ApiResponse.loading());

    holidayRepository
        .getHolidays(localStorage.getString('token').toString())
        .then((value) {
      print('Value: $value');
      setHolidayList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setHolidayList(ApiResponse.error(error.toString()));
    });
  }

  // Future<void> getHolidayList(BuildContext context) async {
  //   _data = holidayRepository.getHolidays(
  //       Provider.of<UserViewModel>(context, listen: false)
  //           .getUser()
  //           .toString());

  //   print('DATA: $_data');
  // }
}
