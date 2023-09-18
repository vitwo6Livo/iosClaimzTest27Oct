import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/lateCheckinRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lateCheckinModel.dart';
import '../res/components/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LateCheckinViewModel with ChangeNotifier {
  final lateCheckinRepository = LateCheckinRepository();
  ApiResponse<LateCheckinModel> lateCheckin = ApiResponse.loading();
  Map<String, dynamic> _lateCheckIns = {};

  List<dynamic> _pendingCheckIns = [];

  List<dynamic> get pendingCheckIns {
    return [..._pendingCheckIns];
  }

  List<dynamic> _approvedCheckIns = [];

  List<dynamic> get approvedCheckIns {
    return [..._approvedCheckIns];
  }

  List<dynamic> _rejectedCheckIns = [];

  List<dynamic> get rejectedCheckIns {
    return [..._rejectedCheckIns];
  }

  setLateCheckinList(ApiResponse<LateCheckinModel> response) {
    lateCheckin = response;
    notifyListeners();
  }

  void setPendingCheckins(dynamic value) {
    value.data.forEach((element) => _pendingCheckIns.add(element));

    value.data.forEach((element) {
      if (element.status == 1 || element.status == 2) {
        _approvedCheckIns.add(element);
      }
    });

    value.data.forEach((element) {
      if (element.status == 2) {
        _rejectedCheckIns.add(element);
      }
    });

    notifyListeners();
  }

  void removeAndAddList(int selectedValue, int index) {
    if (selectedValue == 1 || selectedValue == 2) {
      print('SELECTED VALUEEEEEEEEE: ${_pendingCheckIns[index]}');
      _approvedCheckIns.add(_pendingCheckIns[index]);
      _pendingCheckIns.removeAt(index);
    } else {
      _rejectedCheckIns.add(_pendingCheckIns[index]);
      _pendingCheckIns.removeAt(index);
    }
    notifyListeners();
  }

  Future<void> getLateCheckin(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // var response = await http.get(Uri.parse(AppUrl.lateCheckinList), headers: {
    //   'Authorization': 'Bearer ${localStorage.getString('token')}',
    //   'Content-Type': 'application/json',
    // });

    // _pendingCheckIns = [];
    // _approvedCheckIns = [];
    // _rejectedCheckIns = [];

    // if(response.statusCode == 200) {
    //   _lateCheckIns = json.decode(response.body);

    // }

    String token = localStorage.getString('token').toString();

    lateCheckinRepository.getLateCheckinRequests(token).then((value) {
      setLateCheckinList(ApiResponse.completed(value));
      print('LATE CHECK INNNN: ${value.data[0].empName}');

      setPendingCheckins(value);
    }).onError((error, stackTrace) {
      setLateCheckinList(ApiResponse.error(error.toString()));
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: 'Error',
      //         subtitle: error.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: error.toString(),
        barBlur: 20,
      ).show(context);
    });
  }

  Future<void> lateCheckInApproval(BuildContext context, dynamic data,
      int? lateId, int index, int selectedValue) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String token = localStorage.getString('token').toString();

    // removeAndAddList(selectedValue, index);

    lateCheckinRepository
        .postLateCheckInApproval(token, data, lateId!)
        .then((value) {
      if (kDebugMode) {
        print('Valueeeeeeeeeeeeeeeeeeeeeeeeeee: $value');
      }

      // setLateCheckinList(ApiResponse.completed(value.data));

      Provider.of<LateCheckinViewModel>(context, listen: false)
          .getLateCheckin(context);

      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Late Check In',
      //           subtitle: value.data.toString(),
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Late Check In',
        message: value.data.toString(),
        barBlur: 20,
      ).show(context);
    }).onError((error, stackTrace) {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Error Occured',
      //           subtitle: error.toString(),
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error Occured',
        message: error.toString(),
        barBlur: 20,
      ).show(context);
    });
  }
}
