import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/models/claimz_HistoryModel.dart';
import 'package:claimz/models/searchUserModel.dart';
import 'package:claimz/repository/claimzRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../res/appUrl.dart';

class ClaimzHistoryViewModel with ChangeNotifier {
  final ClaimzRespository = ClaimzRepository();

  Map<String, dynamic> _claimList = {};
  List<dynamic> _conveyanceList = [];
  Map<String, dynamic> _manualConveyance = {};

  Map<String, dynamic> get claimList {
    return {..._claimList};
  }

  List<dynamic> get conveyanceList {
    return [..._conveyanceList];
  }

  Map<String, dynamic> get manualConveyance {
    return {..._manualConveyance};
  }

  Future<void> getClaimList(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _claimList = {};

    _conveyanceList = [];

    print('DATAAAAAAAAAAAAA: $data');

    var response = await http
        .post(Uri.parse(AppUrl.claimz_list), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 301) {
      _claimList = json.decode(response.body);

      for (int i = 0; i < _claimList['data'].length; i++) {
        _conveyanceList.add(_claimList['data'][i]);
      }

      print('CONVEYANCE LIST: $_conveyanceList');
    } else {
      Flushbar(
        duration: const Duration(seconds: 10),
        leftBarIndicatorColor: Colors.red,
        message: 'An Error Occured',
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> manualCreation(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('DATAAAAAAAAAAAAA: $data');

    var response = await http.post(Uri.parse(AppUrl.manualConveyance),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 301) {
      _manualConveyance = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 10),
        leftBarIndicatorColor: Colors.red,
        message: 'Form Created Successfully',
      ).show(context);
    } else {
      Flushbar(
        duration: const Duration(seconds: 10),
        leftBarIndicatorColor: Colors.red,
        message: 'An Error Occured',
      ).show(context);
    }
    notifyListeners();
  }

  ApiResponse<Claimz_HistoryModel> claimzhistory = ApiResponse.loading();
  ApiResponse<Search_UserModel> searchUserRecord = ApiResponse.loading();

  setClaimzHistoryList(ApiResponse<Claimz_HistoryModel> response) {
    claimzhistory = response;
    notifyListeners();
  }

  setSearchResult(ApiResponse<Search_UserModel> response) {
    searchUserRecord = response;
    notifyListeners();
  }

  Future<void> postClaimzHistoryList(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postClaimzHistoryList(token, data).then((value) {
      setClaimzHistoryList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postSearchUser(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postUserList(token, data).then((value) {
      setSearchResult(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postApprovalReject(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postapproval(token, data).then((value) {
      Flushbar(
        message: value['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }).onError((error, stackTrace) {
      print(ApiResponse.error(error.toString()));
    });
  }
}
