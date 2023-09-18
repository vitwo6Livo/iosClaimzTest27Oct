// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../repository/regulariationRequestsRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/regularizationManagerModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../res/appUrl.dart';
import 'dart:convert';

import '../res/components/alert_dialog.dart';
import '../views/screens/success_tick_screen.dart';

class RegularisationRequestViewModel with ChangeNotifier {
  Map<String, dynamic> _regularisationList = {};
  Map<String, dynamic> _regulariseReponse = {};
  List<Map<String, dynamic>> _pendingRegularisation = [];
  List<Map<String, dynamic>> _approvedRegularisation = [];
  List<Map<String, dynamic>> _rejectedRegularisation = [];

  Map<String, dynamic> get regularisationList {
    return {..._regularisationList};
  }

  Map<String, dynamic> get regulariseReponse {
    return {..._regulariseReponse};
  }

  List<Map<String, dynamic>> get pendingRegularisation {
    return [..._pendingRegularisation];
  }

  List<Map<String, dynamic>> get approvedRegularisation {
    return [..._approvedRegularisation];
  }

  List<Map<String, dynamic>> get rejectedRegularisation {
    return [..._rejectedRegularisation];
  }

  Future<void> getRegularisationRequest(String fromDate, String toDate) async {
    print("fromDate: $fromDate");
    print('toDate: $toDate');
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _pendingRegularisation = [];
    _approvedRegularisation = [];
    _rejectedRegularisation = [];

    final response = await http.post(
        Uri.parse(AppUrl.viewRegularizationManager),
        body: json.encode({'from_date': fromDate, 'to_date': toDate}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _regularisationList = json.decode(response.body);
      print('REGULARISATION REQUESTS: $_regularisationList');

      if (_regularisationList['status'] == 205) {
        _pendingRegularisation = [];
        _approvedRegularisation = [];
        _rejectedRegularisation = [];
      } else {
        for (int i = 0; i < _regularisationList['data'].length; i++) {
          // print('TYPEEEEEEEEEE: ${_regularisationList['data'][i]['status'].runtimeType}');
          // print('i TYPEEEEEEEEEEE: $i');
          if (_regularisationList['data'][i]['status'] == 0) {
            _pendingRegularisation.add(_regularisationList['data'][i]);
          } else if (_regularisationList['data'][i]['status'] == 1) {
            _approvedRegularisation.add(_regularisationList['data'][i]);
          } else {
            _rejectedRegularisation.add(_regularisationList['data'][i]);
          }
        }
        print('REGULARISATION REQUESTSSSS: $_pendingRegularisation');
      }
    } else {
      _regularisationList = json.decode(response.body);

      // _regularisationList = {};
    }
    notifyListeners();
  }

  Future<dynamic> postRegularizationReqest(int id, dynamic selection,
      Map<String, dynamic> data, BuildContext context, String reason) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('DATA: $data');

    print('URL: ${AppUrl.postRegularizationManager}$id');

    final response =
        await http.post(Uri.parse('${AppUrl.postRegularizationManager}$id'),
            body: json.encode({
              'remarks': reason,
            }),
            headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _regulariseReponse = json.decode(response.body);
      _approvedRegularisation.add(data);
      _pendingRegularisation
          .removeWhere((element) => element['regularize_id'] == id);
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));
    } else {
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'An Error Occured',
              message: 'Regularisation Not Approved')
          .show(context);
      print('Error: ${json.decode(response.body)}');
    }

    print('REGULARISATION REQUEST POST: $_regulariseReponse');

    notifyListeners();

    return _regulariseReponse;
  }

  Future<dynamic> postRejectRegularizationReqest(int id, dynamic selection,
      Map<String, dynamic> data, BuildContext context, String reason) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // print('URL: ${AppUrl.postRegularizationManager}$id');re

    print('DATA: $data');

    final response = await http
        .post(Uri.parse('${AppUrl.postRejectRegularizationManager}$id'),
            body: json.encode({
              'remarks': reason,
            }),
            headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _regulariseReponse = json.decode(response.body);
      _rejectedRegularisation.add(data);
      _pendingRegularisation
          .removeWhere((element) => element['regularize_id'] == id);
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Regularisation Rejected',
      //           subtitle: _regulariseReponse['data'],
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Navigator.pop(context);
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Regularisation Rejected',
              message: 'Regularisation Rejected')
          .show(context);
    } else {
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'An Error Occured',
              message: 'Regularisation Not Rejected')
          .show(context);

      print('Error: ${json.decode(response.body)}');
    }

    print('REGULARISATION REQUEST POST: $_regulariseReponse');

    notifyListeners();

    return _regulariseReponse;
  }
}
