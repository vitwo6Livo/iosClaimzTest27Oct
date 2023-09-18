import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/models/travellistlog.dart';
import 'package:claimz/repository/logsClaimRepository.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:http/http.dart' as http;

import '../models/conveynanceLogsListModel.dart';

class LogsViewModel with ChangeNotifier {
  Map<String, dynamic> _incidentalExpense = {};

  Map<String, dynamic> get incidentalExpense {
    return {..._incidentalExpense};
  }

  LogsClaimRepository _LogsClaimRepository = LogsClaimRepository();

  ApiResponse<travellistlogModel> travelList = ApiResponse.loading();

  ApiResponse<ConyenanceLogsListModel> conyenanceList = ApiResponse.loading();

  setConyenanceList(ApiResponse<ConyenanceLogsListModel> response) {
    conyenanceList = response;
    notifyListeners();
  }

  void setTravelList(ApiResponse<travellistlogModel> response) {
    travelList = response;
    notifyListeners();
  }

  Future<void> postTravelLogslist(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('TRAVEEEEEEEEEL: $data');

    String authToken = localStorage.getString('token').toString();

    _LogsClaimRepository.postLogsList(
            AppUrl.travel_claim_listlog, data, authToken)
        .then((value) {
      setTravelList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setTravelList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getManagerIncidental(String fromDate, String toDate) async {
    print('FROM DATE: $fromDate & TO DATE: $toDate');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.incidental_claim_listlog),
        body: json
            .encode({'status': "", "from_date": fromDate, "to_date": toDate}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    print(localStorage.getString('token'));

    if (response.statusCode == 200) {
      _incidentalExpense = json.decode(response.body);
    } else {
      // print('ERROR');
      _incidentalExpense = json.decode(response.body);
    }
    if (kDebugMode) {
      print('Manager Incidental Expenses: $_incidentalExpense');
    }

    notifyListeners();
  }

  Future<void> postConyenanceList(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    _LogsClaimRepository.postConveynanceList(
            AppUrl.conveynance_claim_listlog, data, token)
        .then((value) {
      setConyenanceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setConyenanceList(ApiResponse.error(error.toString()));
    });
  }
}
