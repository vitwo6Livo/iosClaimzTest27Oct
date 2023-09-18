import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/appUrl.dart';
import '../views/screens/managerIncidentalScreen/managerIncidental.dart';
import '../views/screens/success_tick_screen.dart';

class ManagerIncidentalViewModel with ChangeNotifier {
  Map<String, dynamic> _incidentalExpense = {};
  List<Map<String, dynamic>> _pending = [];
  List<Map<String, dynamic>> _approved = [];
  List<Map<String, dynamic>> _partialPayment = [];
  List<Map<String, dynamic>> _paid = [];
  List<Map<String, dynamic>> _rejected = [];
  String? fromDatee;
  String? toDatee;

  Map<String, dynamic> get incidentalExpense {
    return {..._incidentalExpense};
  }

  List<Map<String, dynamic>> get pending {
    return [..._pending];
  }

  List<Map<String, dynamic>> get approved {
    return [..._approved];
  }

  List<Map<String, dynamic>> get partialPayment {
    return [..._partialPayment];
  }

  List<Map<String, dynamic>> get paid {
    return [..._paid];
  }

  List<Map<String, dynamic>> get rejected {
    return [..._rejected];
  }

  Future<void> getManagerIncidental(String fromDate, String toDate) async {
    _pending = [];
    _approved = [];
    _rejected = [];

    print('from-date-incidental: $fromDate');

    print('to-date-incidental: $toDate');

    fromDatee = fromDate;
    toDatee = toDatee;

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.getUserIncidental),
        body: json.encode({
          'all': 0,
          'status': localStorage.getString('approval'),
          'from_date': fromDate,
          'to_date': toDate
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    print('APPROVAL TOKENNNNNNN ${localStorage.getString('approval')}');

    if (response.statusCode == 200) {
      _incidentalExpense = json.decode(response.body);
      // for (int i = 0; i < _incidentalExpense['data'].length; i++) {
      //   for (int j = 0;
      //       j < _incidentalExpense['data'][i]['claim_data'].length;
      //       j++) {
      //     if (_incidentalExpense['data'][i]['claim_data'][j]['status'] ==
      //         'Pending') {
      //       _pending.add(_incidentalExpense['data'][i]['claim_data'][j]);
      //     } else if (_incidentalExpense['data'][i]['claim_data'][j]['status'] ==
      //         'Approved') {
      //       _approved.add(_incidentalExpense['data'][i]['claim_data'][j]);
      //     } else {
      //       _rejected.add(_incidentalExpense['data'][i]['claim_data'][j]);
      //     }
      //   }
      // }
      // for (int i = 0; i < _incidentalExpense['data'].length; i++) {
      //   if (_incidentalExpense['data'][i]['data_list']['status'] ==
      //       'Pending for Approval') {
      //     _pending.add(_incidentalExpense['data'][i]);
      //   } else if (_incidentalExpense['data'][i]['data_list']['status'] ==
      //       'Approved') {
      //     _approved.add(_incidentalExpense['data'][i]);
      //   } else {
      //     _rejected.add(_incidentalExpense['data'][i]);
      //   }
      // }
      print('Pending INCIDENTALLLLLLLLLLLLL: $_pending');
    } else {
      // print('ERROR');
      _incidentalExpense = json.decode(response.body);
    }
    if (kDebugMode) {
      print('Manager Incidental Expenses: $_incidentalExpense');
      print('Pending: $_pending');
      print('Approved: $_approved');
      print('Rejected: $_rejected');
    }

    notifyListeners();
  }

  Future<void> editIncidentalExpense(BuildContext context,
      Map<String, dynamic> data, String fromDatee, String toDatee) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // Navigator.of(context, rootNavigator: true).pop();

    var response = await http.post(Uri.parse(AppUrl.incidentalUpdate),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      Flushbar(
        message: responseData['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context).then((value) {
          Provider.of<ManagerIncidentalViewModel>(context, listen: false)
              .getManagerIncidental(fromDatee!, toDatee!);
          Navigator.of(context).pop();
        });
    } else {
      var responseData = json.decode(response.body);

      Flushbar(
        message: responseData['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    }
    notifyListeners();
  }

  Future<dynamic> postActionIncidental(
      int id, BuildContext context, bool action, String reason) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    Map<String, dynamic> request = {
      "claim_no": id,
      "status": action == true ? 1 : 999999,
      'remarks': reason
    };

    final response = await http.post(Uri.parse(AppUrl.claimzIncidentalApprove),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        },
        body: json.encode(request));

    if (response.statusCode >= 200 &&
        response.statusCode <= 300 &&
        action == true) {
      var responseData = json.decode(response.body);

      print(responseData);

      // Provider.of<ManagerIncidentalViewModel>(context, listen: false)
      //     .getManagerIncidental();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ManagerIncidentalExpenseScreen()));
      });

      // Flushbar(
      //   message: 'Claim Approved',
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.blue,
      // )..show(context).then((value) => Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder: (context) => ManagerIncidentalExpenseScreen())));
      // .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
      //       Navigator.of(context).pop();
      //       Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => ManagerIncidentalExpenseScreen()));
      //     }));
      //   print(response.body.toString());
      //   if (selection == "1") {
      //     _approved.add(data);
      //     _pending.removeWhere((element) => element['claim_no'] == id);

      //     Flushbar(
      //       message: "You have approved the claim !",
      //       icon: Icon(
      //         Icons.info_outline,
      //         size: 28.0,
      //         color: Colors.blue,
      //       ),
      //       duration: Duration(seconds: 3),
      //       leftBarIndicatorColor: Colors.blue,
      //     )..show(context);

      //   } else {
      //     _rejected.add(data);
      //     _pending.removeWhere((element) => element['claim_no'] == id);
      //     Flushbar(
      //       message: "You have rejected the claim !",
      //       icon: Icon(
      //         Icons.info_outline,
      //         size: 28.0,
      //         color: Colors.blue,
      //       ),
      //       duration: Duration(seconds: 3),
      //       leftBarIndicatorColor: Colors.blue,
      //     )..show(context);

      //   }
    } else if (response.statusCode >= 200 &&
        response.statusCode <= 300 &&
        action == false) {
      var responseData = json.decode(response.body);

      print(responseData);

      // Provider.of<ManagerIncidentalViewModel>(context, listen: false)
      //     .getManagerIncidental();

      // Flushbar(
      //   message: 'Claim Rejected',
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.blue,
      // )..show(context)
      //     .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
      //           Navigator.of(context).pop();
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ManagerIncidentalExpenseScreen()));
      //         }));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ManagerIncidentalExpenseScreen()));
      });
    } else {
      var responseData = json.decode(response.body);

      Flushbar(
        message: responseData['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
    notifyListeners();
  }

  Future<void> editClaim(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.editIncidentalClaim),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);
      Flushbar(
        message: responseData['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    } else {
      var responseData = json.decode(response.body);
      Flushbar(
        message: responseData['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }
}
