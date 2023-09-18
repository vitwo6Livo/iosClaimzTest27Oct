import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/models/checkinClaimzMeetingModel.dart';
import 'package:claimz/models/checkinClaimzModel.dart';
import 'package:claimz/models/checkoutModel.dart';
import 'package:claimz/models/claimzDetailModel.dart';
import 'package:claimz/models/estimasteDistanceModel.dart';
import 'package:claimz/repository/claimzRepository.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ClaimzViewModel with ChangeNotifier {
  LinearGradient _defaultGradient = LinearGradient(
    colors: <Color>[
      Color(0XFF00D58D),
      Color(0XFF00C2A0),
    ],
  );

  LinearGradient get defaultGradient => _defaultGradient;

  set defaultGradient(LinearGradient color) {
    _defaultGradient = color;
    notifyListeners();
  }

  Map<String, dynamic> _conveyanceResponse = {};

  Map<String, dynamic> get conveyanceResponse {
    return {..._conveyanceResponse};
  }

  String _msg = "";

  String get msg => _msg;

  set msg(String msg) {
    _msg = msg;
    notifyListeners();
  }

  final ClaimzRespository = ClaimzRepository();
  ApiResponse<claimzdetailModel> claimzdata = ApiResponse.loading();
  ApiResponse<claimzdetailModel> claimzrange = ApiResponse.loading();
  ApiResponse<checkin_claimz_Model> checkin_claimz = ApiResponse.loading();
  ApiResponse<checkin_claimz_meeting_Model> checkin_claimz_meeting =
      ApiResponse.loading();
  ApiResponse<checkoutModel> claimz_checkout = ApiResponse.loading();
  ApiResponse<estimateDistanceModel> estimate_distance = ApiResponse.loading();

  setClaimzDetail(ApiResponse<claimzdetailModel> response) {
    claimzdata = response;
    notifyListeners();
  }

  setClaimzRange(ApiResponse<claimzdetailModel> response) {
    claimzrange = response;
    notifyListeners();
  }

  setClaimzCheckin(ApiResponse<checkin_claimz_Model> response) {
    checkin_claimz = response;
    notifyListeners();
  }

  setClaimzCheckinMeeting(ApiResponse<checkin_claimz_meeting_Model> response) {
    checkin_claimz_meeting = response;
    notifyListeners();
  }

  setClaimzCheckout(ApiResponse<checkoutModel> response) {
    claimz_checkout = response;
    notifyListeners();
  }

  Future<void> getClaimzDetails(BuildContext context) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    final String? token = localStorage.getString('token');
    ClaimzRespository.getCheckinDetailsClaimz(token).then((value) {
      setClaimzDetail(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setClaimzDetail(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postSelfie(BuildContext context, dynamic data, File file) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.claimz_execute));

    request.headers
        .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    request.fields['lat'] = data['lat'];
    request.fields['lng'] = data['lng'];
    request.fields['origin_address'] = data['origin_address'];
    request.fields['remarks'] = data['remarks'];
    request.fields['purpose'] = data['purpose'];
    request.fields['doc'] = data['doc'];
    request.files
        .add(await http.MultipartFile.fromPath('selfie', file.path.toString()));

    var response = await request.send();

    var streamedResponse = await http.Response.fromStream(response);

    print('SELFIEEEEEEEEe: $streamedResponse');
  }

  Future<dynamic> claimzExecute(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.claimz_execute),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _conveyanceResponse = json.decode(response.body);
      Flushbar(
        message: _conveyanceResponse["status"].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    } else {
      _conveyanceResponse = json.decode(response.body);
      Flushbar(
        message: 'An Error Occured',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }

    return _conveyanceResponse;
  }

  Future<void> postClaimzExecute(BuildContext context, dynamic data) async {
    //sc
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postClaimzExecute(token, data).then((value) {
      // _conveyanceResponse = value;
      Flushbar(
        message: value["status"].toString(),
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
    // return _conveyanceResponse;
  }

  Future<dynamic> postCheckRange(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    var response = ClaimzRespository.postClaimzRange(token, data).then((value) {
      notifyListeners();
      return value;
    }).onError((error, stackTrace) {
      print(ApiResponse.error(error.toString()));
    });
    return response;
  }

  Future<dynamic> getEstimatedDetails(BuildContext context, Map data) async {
    String url = AppUrl.estimatedistance +
        "&origins=" +
        data["from_lat"] +
        "," +
        data["from_long"] +
        "&destinations=" +
        data["to_lat"] +
        "," +
        data["to_long"] +
        "&key=" +
        AppUrl.APIKEY;
    var response = ClaimzRespository.getEstimatedData(url).then((value) {
      notifyListeners();
      return value;
    });
    return response;
  }

  Future<void> postClaimzCheckin(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postCheckinClaimz(token, data).then((value) {
      Flushbar(
        message: value.data.toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);

      setClaimzCheckin(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setClaimzCheckin(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postClaimzCheckinMeeting(
      BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postCheckinMeetingClaimz(token, data).then((value) {
      Flushbar(
        message: value.data.toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
      setClaimzCheckinMeeting(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setClaimzCheckinMeeting(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postClaimzCheckout(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postCheckoutClaimz(token, data).then((value) {
      setClaimzCheckout(ApiResponse.completed(value));
      var snackBar = SnackBar(
        content: Text(value.data![0].msg.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).onError((error, stackTrace) {
      setClaimzCheckout(ApiResponse.error(error.toString()));
    });
  }
}
