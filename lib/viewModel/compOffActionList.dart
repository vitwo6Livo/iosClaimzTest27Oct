import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CompOffActionList with ChangeNotifier {
  Map<String, dynamic> _compOffList = {};
  List<Map<String, dynamic>> _pendingCompOff = [];
  List<Map<String, dynamic>> _approvedCompOff = [];
  List<Map<String, dynamic>> _rejectedCompOff = [];

  Map<String, dynamic> get compOffList {
    return {..._compOffList};
  }

  List<Map<String, dynamic>> get pendingCompOff {
    return [..._pendingCompOff];
  }

  List<Map<String, dynamic>> get approvedCompOff {
    return [..._approvedCompOff];
  }

  List<Map<String, dynamic>> get rejectedCompOff {
    return [..._rejectedCompOff];
  }

  Future<void> getManagerCompOffList(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _pendingCompOff = [];
    _approvedCompOff = [];
    _rejectedCompOff = [];

    var response =
        await http.get(Uri.parse(AppUrl.compOffManagerView), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _compOffList = json.decode(response.body);

      print('LISSSSSST: $_compOffList');

      for (int i = 0; i < _compOffList['data'].length; i++) {
        if (_compOffList['data'][i]['status'] == 2) {
          _pendingCompOff.add(_compOffList['data'][i]);
        } else if (_compOffList['data'][i]['status'] == 3) {
          _approvedCompOff.add(_compOffList['data'][i]);
        } else if (_compOffList['data'][i]['status'] == 4) {
          _rejectedCompOff.add(compOffList['data'][i]);
        }
      }
    } else {
      _compOffList = json.decode(response.body);

      print('ERRRROR: $_compOffList');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'An Error Oc',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> approveManagerCompOffList(BuildContext context, int compOffId,
      int userId, Map<String, dynamic> data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.compOffManagerApprove),
        body: json.encode({'id': compOffId, 'user_id': userId}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      print('RESPONSEEEEE APPROVVVEEE: $responseData');

      _approvedCompOff.add(data);
      _pendingCompOff.removeWhere((value) => value['compoff_id'] == compOffId);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'].toString(),
        barBlur: 20,
      ).show(context);
    } else {
      var responseData = json.decode(response.body);

      print('RESPONSEEEEE APPROVVVEEE ERRROR: $responseData');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'].toString(),
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> rejecteManagerCompOffList(
      BuildContext context, int compOffId, Map<String, dynamic> data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .get(Uri.parse('${AppUrl.compOffManagerReject}$compOffId'), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      print('RESPONSEEEEE REJECTTTTT: $responseData');

      _rejectedCompOff.add(data);
      _pendingCompOff.removeWhere((value) => value['compoff_id'] == compOffId);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'].toString(),
        barBlur: 20,
      ).show(context);
    } else {
      var responseData = json.decode(response.body);

      print('RESPONSEEEEE REJECTTTTT ERROR: $responseData');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: responseData['data'].toString(),
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }
}
