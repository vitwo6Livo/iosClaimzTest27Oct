// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/viewModel/claimsStatusViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/checkInOutRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/components/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../res/appUrl.dart';
import '../views/screens/success_tick_screen.dart';

class CheckInOutViewModel with ChangeNotifier {
  final checkInOutRepository = CheckInOutRepository();

  Map<String, dynamic> _breakOut = {};

  Map<String, dynamic> _breakIn = {};

  bool _status = false;

  bool get status {
    return _status;
  }

  Map<String, dynamic> get breakOut {
    return {..._breakOut};
  }

  Map<String, dynamic> get breakIn {
    return {..._breakIn};
  }

  Future<void> toggleStatus() async {
    // await Future.delayed(const Duration(seconds: 4));
    _status = !_status;
    print('Statusss: $_status');
    notifyListeners();
  }

  Future<void> checkInOutViewModel(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    var response = await http.post(Uri.parse(AppUrl.checkInOut),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        });

    var jsonResponse = json.decode(response.body);

    if (jsonResponse['status'] == 200) {
      print('JSON RESPONSE: $jsonResponse');
      localStorage.setInt('loginId', jsonResponse['id']);

      Provider.of<ClaimzStatusViewModel>(context, listen: false)
          .getClaimzStatuss();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));

      notifyListeners();
    } else {
      var jsonResponse = json.decode(response.body);

      print('Check In: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Check In Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
  }

  Future<void> checkOutViewModel(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    print('CHECK OUT VIEEWWW; $data');

    // checkInOutRepository
    //     .checkOut(authToken, data)
    //     .then((value) {})
    //     .onError((error, stackTrace) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => CustomDialog(
    //             onOk: () => Navigator.of(context).pop(),
    //             onCancel: () => Navigator.of(context).pop(),
    //             title: 'Error',
    //             subtitle: '',
    //           ));
    // });
    var response = await http.post(Uri.parse(AppUrl.checkOut),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        });

    var jsonResponse = json.decode(response.body);

    if (jsonResponse['status'] == 200) {
      // localStorage.setInt('loginId', jsonResponse['id'][0]['id']);

      _status = false;

      Provider.of<ClaimzStatusViewModel>(context, listen: false)
          .getClaimzStatuss();

      print('CHECKOUT SUCCCESSSSS: ${jsonResponse}');

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));
    } else {
      var jsonResponse = json.decode(response.body);

      print('CHECKOUT FAILED: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'CheckOut Failed',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<dynamic> breakStart(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .post(Uri.parse(AppUrl.breakOut), body: json.encode({}), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _breakOut = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'CheckOut Failed',
        message: 'You Are On Break',
        barBlur: 20,
      ).show(context);
    } else {
      _breakOut = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'CheckOut Failed',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    return _breakOut;
  }

  Future<dynamic> breakOver(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .post(Uri.parse(AppUrl.breakIn), body: json.encode({}), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _breakIn = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'CheckOut Failed',
        message: 'You Are Out Of Break',
        barBlur: 20,
      ).show(context);
    } else {
      _breakIn = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'CheckOut Failed',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }

    return _breakIn;
  }
}
