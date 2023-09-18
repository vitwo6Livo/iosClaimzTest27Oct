import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../repository/regularizationRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/components/alert_dialog.dart';
import '../views/screens/success_tick_screen.dart';
import '../views/screens/tickScreen2.dart';

class RegularizationViewModel with ChangeNotifier {
  final regularizationRepository = RegularisationRepository();

  Future<dynamic> addRegularization(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    regularizationRepository.addRegularization(data, authToken).then((value) {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Regularisation Added',
      //           subtitle: value.data.toString(),
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));

      print('VALUEEEEE: ${value.toString()}');

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SuccessTickScreenTwo()));

      // EasyLoading.showSuccess("Submmited Regularise")
      //     .then((value) => Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => SuccessTickScreen())))
      //     .then((value) {
      //   // Provider.of<UserIncidentalViewModel>(context, listen: false)
      //   //     .getUserIncidental();
      //   Navigator.of(context).pop();
      // });
      // EasyLoading.dismiss();

      // Flushbar(
      //   duration: const Duration(seconds: 4),
      //   flushbarPosition: FlushbarPosition.BOTTOM,
      //   borderRadius: BorderRadius.circular(10),
      //   icon: const Icon(Icons.error, color: Colors.white),
      //   // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      //   title: 'Regularisation Added',
      //   message: value.data.toString()
      // ).show(context);
    }).onError((error, stackTrace) {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: error.toString(),
      //         subtitle: error.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));

      print('VALUEEEEE: ${error.toString()}');

      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: error.toString(),
              message: error.toString())
          .show(context);
    });
  }
}
