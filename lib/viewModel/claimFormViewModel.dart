import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/repository/claimzRepository.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClaimzFormViewModel with ChangeNotifier {
  final ClaimzRespository = ClaimzRepository();

  Future<void> postClaimzForm(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postClaimzForm(AppUrl.claimz_form, data, token)
        .then((value) {
      Flushbar(
        message: value['msg'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }).onError((error, stackTrace) {
      Flushbar(
        message: error.toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    });
  }

  Future<void> postClaimzForm_submit(BuildContext context, dynamic data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postClaimzForm(AppUrl.claimz_submit, data, token)
        .then((value) {
      Flushbar(
        message: value['msg'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }).onError((error, stackTrace) {
      Flushbar(
        message: error.toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    });
  }
}
