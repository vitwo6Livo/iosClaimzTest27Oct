// ignore_for_file: avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../res/appUrl.dart';
import 'dart:convert';
import '../views/screens/success_tick_screen.dart';

class CompOffManagerViewModel with ChangeNotifier {
  Map<String, dynamic> _compOff = {};
  Map<String, dynamic> _userCompOff = {};
  Map<String, dynamic> _compOffResponse = {};
  Map<String, dynamic> _managerCompOff = {};
  List<dynamic> _pendingCompOffData = [];
  List<dynamic> _approvedCompOffData = [];
  List<dynamic> _rejectedCompOffData = [];

  List<dynamic> _pendingCompOffLeaveData = [];
  List<dynamic> _approvedCompOffLeaveData = [];

  Map<String, dynamic> get compOff {
    return {..._compOff};
  }

  Map<String, dynamic> get managerCompOff {
    return {..._managerCompOff};
  }

  Map<String, dynamic> get compOffReponse {
    return {..._compOffResponse};
  }

  Map<String, dynamic> get userCompOff {
    return {..._userCompOff};
  }

  List<dynamic> get pendingCompOffData {
    return [..._pendingCompOffData];
  }

  List<dynamic> get approvedCompOffData {
    return [..._approvedCompOffData];
  }

  List<dynamic> get rejectedCompOffData {
    return [..._rejectedCompOffData];
  }

  List<dynamic> get pendingCompOffLeaveData {
    return [..._pendingCompOffLeaveData];
  }

  List<dynamic> get approvedCompOffLeaveData {
    return [..._approvedCompOffLeaveData];
  }

  Future<void> getUserCompOffRequests() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
  }

  Future<void> getCompOffRequests(String fromDate, String toDate) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(AppUrl.viewUserCompOff),
        body: json.encode({'from_date': fromDate, 'to_date': toDate}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _userCompOff = json.decode(response.body);

      for (int i = 0; i < _userCompOff['data'].length; i++) {}
    } else {
      _userCompOff = {};
    }
    print('COMPOFF REQUESTS: $_userCompOff');

    notifyListeners();
  }

  Future<void> getManagerCompOffRequests(String start, String end) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('START DATE: $start');

    print('END DATE: $end');

    _pendingCompOffData = [];
    _approvedCompOffData = [];
    _pendingCompOffLeaveData = [];
    _approvedCompOffLeaveData = [];
    _rejectedCompOffData = [];

    final response = await http.post(Uri.parse(AppUrl.viewCompOffManager),
        body: json.encode({'from_date': start, 'to_date': end}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _managerCompOff = json.decode(response.body);

      for (int i = 0; i < _managerCompOff['data'].length; i++) {
        if (_managerCompOff['data'][i]['status'] == 0) {
          _pendingCompOffData.add(_managerCompOff['data'][i]);
        } else if (_managerCompOff['data'][i]['status'] == 1) {
          _approvedCompOffData.add(_managerCompOff['data'][i]);
        } else if (_managerCompOff['data'][i]['status'] == 2) {
          _pendingCompOffLeaveData.add(_managerCompOff['data'][i]);
        } else if (_managerCompOff['data'][i]['status'] == 3) {
          _approvedCompOffLeaveData.add(_managerCompOff['data'][i]);
        } else {
          _rejectedCompOffData.add(_managerCompOff['data'][i]);
        }
      }
      print('COMP OFF REQUESTSSSS: $_pendingCompOffData');
      print('COMP OFF LEAVEEEEE REQUESTSSSS: $_pendingCompOffLeaveData');
    } else {
      _managerCompOff = {};
    }
    print('COMPOFF REQUESTS: $_managerCompOff');

    notifyListeners();
  }

  Future<dynamic> manageCompOff(int id, int selectedValue,
      Map<String, dynamic> data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final response =
        await http.post(Uri.parse('${AppUrl.compOffManager}$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode == 200) {
      _compOffResponse = json.decode(response.body);
      if (selectedValue == 1) {
        _approvedCompOffData.add(data);
        _pendingCompOffData
            .removeWhere((element) => element['compoff_id'] == id);

        // showDialog(
        //     context: context,
        //     builder: (context) => CustomDialog(
        //         title: 'Comp Off Approved',
        //         subtitle: _compOffResponse['data'],
        //         onOk: () => Navigator.of(context).pop(),
        //         onCancel: () => Navigator.of(context).pop()));
        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          title: 'Comp Off Approved',
          message: _compOffResponse['data'],
          barBlur: 20,
        ).show(context);
      } else {
        _rejectedCompOffData.add(data);
        _pendingCompOffData
            .removeWhere((element) => element['compoff_id'] == id);

        // showDialog(
        //     context: context,
        //     builder: (context) => CustomDialog(
        //         title: 'Comp Off Rejected',
        //         subtitle: _compOffResponse['data'],
        //         onOk: () => Navigator.of(context).pop(),
        //         onCancel: () => Navigator.of(context).pop()));

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          title: 'Comp Off Rejected',
          message: _compOffResponse['data'],
          barBlur: 20,
        ).show(context);
      }
    } else {
      _compOffResponse = {};
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: 'Error',
      //         subtitle: response.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: response.toString(),
        barBlur: 20,
      ).show(context);
    }
    print('COMPOFF Manager: $_compOffResponse');
    notifyListeners();
    return _compOffResponse;
  }

  Future<dynamic> compOffManagerApprove(
      BuildContext context, int compOffId, int empId, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('COMP OFF ID: $compOffId');

    print('EMP ID: $empId');

    var response = await http.post(Uri.parse(AppUrl.compOffManagerApprove),
        body: json.encode({'id': compOffId, 'user_id': empId}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _compOffResponse = json.decode(response.body);

      _approvedCompOffLeaveData.add(data);
      _pendingCompOffLeaveData
          .removeWhere((element) => element['compoff_id'] == compOffId);

      print('APPROVE COMP OFF: $_compOffResponse');

      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));
    } else {
      print('ERRRRRRRRROR: ${json.decode(response.body)}');
      _compOffResponse = json.decode(response.body);

      // _compOffResponse = {};
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: 'Error',
      //         subtitle: response.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: _compOffResponse['data'],
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> compOffManagerReject(
      BuildContext context, int id, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse('${AppUrl.compOffReject}$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode == 200) {
      _compOffResponse = json.decode(response.body);

      _rejectedCompOffData.add(data);
      _pendingCompOffLeaveData
          .removeWhere((element) => element['compoff_id'] == id);

      print('REJECT COMP OFF: $_compOffResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Comp Off Rejected',
        message: _compOffResponse['data'],
        barBlur: 20,
      ).show(context);
    } else {
      _compOffResponse = json.decode(response.body);

      print('ERRRRRRRRROR: ${json.decode(response.body)}');

      // _compOffResponse = {};
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: 'Error',
      //         subtitle: response.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: 'Error',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> approveCompOff(
      BuildContext context, dynamic data, dynamic payLoadData, int id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.compOffApprove),
        body: json.encode(payLoadData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _compOffResponse = json.decode(response.body);

      _approvedCompOffData.add(data);
      _pendingCompOffData.removeWhere((element) => element['compoff_id'] == id);

      Navigator.of(context).pop();

      print('APPROVE COMP OFF: $_compOffResponse');

      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()));
    } else {
      print('ERRRRRRRRROR: ${json.decode(response.body)}');
      _compOffResponse = json.decode(response.body);

      // _compOffResponse = {};
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: 'Error',
      //         subtitle: response.toString(),
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));
      Navigator.of(context).pop();

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: _compOffResponse['data'],
        barBlur: 20,
      )..show(context);
    }
    notifyListeners();
  }

  Future<void> rejectCompoff(BuildContext context, int id, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse('${AppUrl.compOffReject}$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _compOffResponse = json.decode(response.body);

      _rejectedCompOffData.add(data);
      _pendingCompOffData.removeWhere((element) => element['compoff_id'] == id);

      print('REJECT COMP OFF: $_compOffResponse');

      Navigator.of(context).pop();

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Comp Off Rejected',
        message: _compOffResponse['data'],
        barBlur: 20,
      )..show(context);
    } else {
      _compOffResponse = json.decode(response.body);

      print('ERRRRRRRRROR: ${json.decode(response.body)}');

      Navigator.of(context).pop();

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: 'Error',
        barBlur: 20,
      )..show(context);
    }
    notifyListeners();
  }
}
