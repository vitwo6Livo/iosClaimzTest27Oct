import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/models/allClaimModel.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/repository/travelClaimRepository.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:http/http.dart' as http;
import '../views/screens/success_tick_screen.dart';

class AllClaimViewModel with ChangeNotifier {
  TravelClaimRepository _travelClaimRepository = TravelClaimRepository();

  ApiResponse<allClaimModel> allclaimzList = ApiResponse.loading();

  void setClaimList(ApiResponse<allClaimModel> response) {
    allclaimzList = response;
    notifyListeners();
  }

  Future<void> postClaimlist(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    _travelClaimRepository
        .postClaimList(AppUrl.all_claim, data, authToken)
        .then((value) {
      setClaimList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setClaimList(ApiResponse.error(error.toString()));
    });
  }
}
