import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/compOffRequestViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../repository/compOffRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/components/alert_dialog.dart';
import '../views/screens/success_tick_screen.dart';

class CompOffViewModel with ChangeNotifier {
  final compoffRepository = CompOffRepository();

  Future<void> postCompOff(dynamic data, BuildContext context, String fromDate,
      String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    compoffRepository.postCompOffRepository(authToken, data).then((value) {
      // showDialog(context: context, builder: (context) => CustomDialog(
      //   title: 'CompOff Submitted',
      //   subtitle: value.data.toString(),
      //   onOk: () => Navigator.pushNamed(context, RouteNames.navbar),
      //   onCancel: () => Navigator.of(context).pop(),
      // ));
      // EasyLoading.showSuccess("CompOff Submitted")
      //     .then((value) => Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => SuccessTickScreen())))
      //     .then((value) {
      //   // Provider.of<UserIncidentalViewModel>(context, listen: false)
      //   //     .getUserIncidental();
      //   Provider.of<CompOffManagerViewModel>(context, listen: false)
      //   .getCompOffRequests();
      //   Navigator.of(context).pop();
      // });
      // EasyLoading.dismiss();
      // Flushbar(
      //   duration: const Duration(seconds: 4),
      //   flushbarPosition: FlushbarPosition.BOTTOM,
      //   borderRadius: BorderRadius.circular(10),
      //   icon: const Icon(Icons.error, color: Colors.white),
      //   // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      //   title: 'CompOff Submitted',
      //   message: value.data.toString(),
      //   barBlur: 20,
      // ).show(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Provider.of<CompOffManagerViewModel>(context, listen: false)
            .getCompOffRequests(fromDate, toDate);
        Navigator.of(context).pop();
      });
    }).onError((error, stackTrace) {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'CompOff Submission Failed',
        message: error.toString(),
        barBlur: 20,
      ).show(context);
      // showDialog(context: context, builder: (context) => CustomDialog(
      //   title: 'CompOff Submission Failed',
      //   subtitle: error.toString(),
      //   onOk: () => Navigator.of(context).pop(),
      //   onCancel: () => Navigator.of(context).pop(),
      // ));
    });
  }
}
