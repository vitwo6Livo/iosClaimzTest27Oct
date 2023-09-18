// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../res/appUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PaySlipViewModel with ChangeNotifier {
  Map<String, dynamic> _paySlipDetails = {};
  Map<String, dynamic> _paySlipAllDetails = {};

  double _salary = 0.0;
  double _earnings = 0.0;
  double _deductions = 0.0;
  double _monthlyCtc = 0.0;
  double _basic = 0.0;
  double _hra = 0.0;
  double _epf = 0.0;
  double _earningsTotal = 0.0;
  double _ytdEarningTotal = 0.0;
  double _deductionTotal = 0.0;
  double _ytdDeduuctionTotal = 0.0;
  double _netPay = 0.0;

  Map<String, dynamic> get paySlipDetails {
    return {..._paySlipDetails};
  }

  Map<String, dynamic> get paySlipAllDetails {
    return {..._paySlipAllDetails};
  }

  double get salary {
    return _salary;
  }

  double get netPay {
    return _netPay;
  }

  double get monthlyCtc {
    return _monthlyCtc;
  }

  double get basic {
    return _basic;
  }

  double get hra {
    return _hra;
  }

  double get epf {
    return _epf;
  }

  double get earnings {
    return _earnings;
  }

  double get deductions {
    return _deductions;
  }

  double get earningsTotal {
    return _earningsTotal;
  }

  double get ytdEarningTotal {
    return _ytdEarningTotal;
  }

  double get deductionTotal {
    return _deductionTotal;
  }

  double get ytdDeduuctionTotal {
    return _ytdDeduuctionTotal;
  }

  Future<dynamic> getPaySlipEarning(Map<String, dynamic> data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String url = AppUrl.payslipDetails;

    _earningsTotal = 0.0;
    _ytdEarningTotal = 0.0;
    _deductionTotal = 0.0;
    _ytdDeduuctionTotal = 0.0;
    _netPay = 0.0;

    print('DATA: $data');

    print('URL: $url');

    final response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      _paySlipAllDetails = json.decode(response.body);
      print('paySlip earningggggggggggggggg: $_paySlipAllDetails');

      // var jsonResponse = json.decode(response.body);
      for (int i = 0; i < _paySlipAllDetails['earning'].length; i++) {
        _earningsTotal +=
            double.parse(_paySlipAllDetails['earning'][i]['component_amount']);
      }
      for (int i = 0; i < _paySlipAllDetails['earning'].length; i++) {
        _ytdEarningTotal +=
            double.parse(_paySlipAllDetails['earning'][i]['ytd']);
      }

      ///////////////////////// deduction //////////////////////

      for (int i = 0; i < _paySlipAllDetails['deduction'].length; i++) {
        _deductionTotal += double.parse(
            _paySlipAllDetails['deduction'][i]['component_amount']);
      }
      for (int i = 0; i < _paySlipAllDetails['deduction'].length; i++) {
        _ytdDeduuctionTotal +=
            double.parse(_paySlipAllDetails['deduction'][i]['ytd']);
      }

      print('total earninggggggggggggggggggg:  $_earningsTotal');
      print('total earninggggggggggggggggggg:  $_ytdEarningTotal');

      // print('Earning: $jsonResponse');
    } else {
      _paySlipAllDetails = {};

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      );
    }
    _netPay = _earningsTotal - _deductionTotal;
    notifyListeners();
  }

  Future<dynamic> getPaySlipDetails(Map<String, dynamic> data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String url = AppUrl.payslipDetails;

    print('DATA: $data');

    print('URL: $url');

    _monthlyCtc = 0.0;
    _basic = 0.0;
    _hra = 0.0;
    _epf = 0.0;
    _earnings = 0;
    _deductions = 0;

    final response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json',
    });

    if (response.statusCode != 200) {
      _paySlipDetails = {};
    } else {
      _paySlipDetails = json.decode(response.body);
      for (int i = 0; i < _paySlipDetails['data'].length; i++) {
        // if (_paySlipDetails['data'][i]['salary_component'] == 'Monthly CTC') {
        //   _monthlyCtc = double.parse(
        //       _paySlipDetails['data'][i]['component_amount'].toString());
        // } else if (_paySlipDetails['data'][i]['salary_component'] == 'Basic') {
        //   _basic = double.parse(
        //       _paySlipDetails['data'][i]['component_amount'].toString());
        // } else if (_paySlipDetails['data'][i]['salary_component'] == 'HRA') {
        //   _hra = double.parse(
        //       _paySlipDetails['data'][i]['component_amount'].toString());
        // } else {
        //   _epf = double.parse(
        //       _paySlipDetails['data'][i]['component_amount'].toString());
        // }
        if (_paySlipDetails['data'][i]['type'] == 'earning') {
          _earnings +=
              double.parse(_paySlipDetails['data'][i]['component_amount']);
        }
        if (_paySlipDetails['data'][i]['type'] == 'deduction') {
          _deductions += double.parse(
              _paySlipDetails['data'][i]['component_amount'] == ''
                  ? '0'
                  : _paySlipDetails['data'][i]['component_amount']);
        }
      }
      // _earnings = _monthlyCtc + _basic + _hra;
      // _deductions = _epf;
      _salary = _earnings - _deductions;
    }

    print('Payslip Details: $_paySlipDetails');
    print('Payslip Earnings: $_earnings');
    print('Payslip Deductions: $_deductions');
    print('Salary: $_salary');

    notifyListeners();
    return _paySlipDetails;
  }
}
