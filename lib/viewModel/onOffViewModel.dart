import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:flutter/material.dart';
import '../repository/onOffRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dashboardModel.dart';
import '../res/components/alert_dialog.dart';

class OnOffViewModel with ChangeNotifier {
  final onOffRepository = OnOffRepository();
  ApiResponse<WorkstationModel> workstation = ApiResponse.loading();

  setWorkStationList(ApiResponse<WorkstationModel> response) {
    workstation = response;
    notifyListeners();
  }

  Future<void> getWorkstation(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    onOffRepository.getOnOff(token).then((value) {
      setWorkStationList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // showDialog(context: context, builder: (context) => CustomDialog(
      //   title: 'Error',
      //   subtitle: error.toString(),
      //   onOk: () => Navigator.of(context).pop(),
      //   onCancel: () => Navigator.of(context).pop(),
      // ));
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Error',
              message: error.toString())
          .show(context);
    });
  }
}
