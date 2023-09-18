import 'package:claimz/data/response/apiResponse.dart';
import 'package:flutter/material.dart';
import '../models/allHolidayModel.dart';
import '../repository/allHolidayRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllHolidayViewModel with ChangeNotifier {
  final allHolidayRepository = AllHolidayRepository();

  ApiResponse<AllHolidayModel> allHoliday = ApiResponse.loading();

  setAllHolidays(ApiResponse<AllHolidayModel> response) {
    allHoliday = response;
    notifyListeners();
  }

  Future<void> getAllHolidayList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    allHolidayRepository
        .getAllHolidayList(token)
        .then((value) => setAllHolidays(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            setAllHolidays(ApiResponse.error(error.toString())));
  }
}
