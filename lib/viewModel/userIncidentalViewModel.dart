import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../res/appUrl.dart';

class UserIncidentalViewModel with ChangeNotifier {
  Map<String, dynamic> _incidentalExpense = {};
  List<Map<String, dynamic>> _pending = [];
  List<Map<String, dynamic>> _approved = [];
  List<Map<String, dynamic>> _rejected = [];
  List<Map<String, dynamic>> _all = [];

  Map<String, dynamic> get incidentalExpense {
    return {..._incidentalExpense};
  }

  List<Map<String, dynamic>> get pending {
    return [..._pending];
  }

  List<Map<String, dynamic>> get approved {
    return [..._approved];
  }

  List<Map<String, dynamic>> get rejected {
    return [..._rejected];
  }

  List<Map<String, dynamic>> get all {
    return [..._all];
  }

  Future<void> getUserIncidental() async {
    _pending = [];
    _approved = [];
    _rejected = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.getUserIncidental),
        body: json.encode({'all': 1}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    print(localStorage.getString('token'));

    if (response.statusCode >= 200 && response.statusCode <= 300) {
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
    } else {
      // print('ERROR');
      _incidentalExpense = json.decode(response.body);
    }
    if (kDebugMode) {
      print('Incidental Expenses: $_incidentalExpense');
      // print('Pending: $_pending');
      // print('Approved: $_approved');
      // print('Rejected: $_rejected');
    }

    notifyListeners();
  }
}
