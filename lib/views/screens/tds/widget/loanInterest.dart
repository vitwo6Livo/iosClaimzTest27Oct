import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../provider/theme_provider.dart';
import '../../../config/mediaQuery.dart';
import '../animated/animated1.dart';
import '../animated/card.dart';
import 'package:http/http.dart' as http;

class LoanInterest extends StatefulWidget {
  //const LoanInterest({super.key});
  final String status;
  final Function aFunction;
  LoanInterest(this.status, this.aFunction);

  @override
  State<LoanInterest> createState() => _LoanInterestState();
}

class _LoanInterestState extends State<LoanInterest> {
  final _hEducation = TextEditingController(text: '0');
  final _housingLoan1 = TextEditingController(text: '0');
  final _housingLoan2 = TextEditingController(text: '0');
  final _vehicleloan = TextEditingController(text: '0');
  bool isStrechedDropDown = false;
  bool isStrechedDropDown1 = false;
  bool isStrechedDropDown2 = false;
  bool isStrechedDropDown3 = false;
  String _limit1 = '';
  String _limit2 = '';
  String _limit3 = '';
  var docNumber = '';
  var id1 = '';
  var id2 = '';
  var id3 = '';
  var id4 = '';
  var _isLoading = false;

  Future<void> _fetchUserDeclaration() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
    };
    try {
      var response =
          await http.get(Uri.parse(AppUrl.userDeclaration), headers: headers);
      print('response: ${response.body}');
      var resp = json.decode(response.body);
      print('resp: $resp');
      if (resp['data'].length > 0) {
        docNumber = resp['data'][0]['doc_no'];
        for (var i = 0; i < resp['data'].length; i++) {
          if (resp['data'][i]['sub_type_id'] == '9') {
            id1 = resp['data'][i]['declare_submit_id'].toString();
            _hEducation.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '10') {
            id2 = resp['data'][i]['declare_submit_id'].toString();
            _housingLoan1.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '11') {
            id3 = resp['data'][i]['declare_submit_id'].toString();
            _housingLoan2.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '12') {
            id4 = resp['data'][i]['declare_submit_id'].toString();
            _vehicleloan.text = resp['data'][i]['amount'];
          }
        }
      }
    } catch (e) {
      print('error');
    }
  }

  settingData() {
    var data = [
      {
        'doc_no': docNumber,
        'group_id': '3',
        'type_id': '7',
        'sub_type_id': '9',
        'amount': _hEducation.text,
        'id': id1
      },
      {
        'doc_no': docNumber,
        'group_id': '3',
        'type_id': '8',
        'sub_type_id': '10',
        'amount': _housingLoan1.text,
        'id': id2
      },
      {
        'doc_no': docNumber,
        'group_id': '3',
        'type_id': '9',
        'sub_type_id': '11',
        'amount': _housingLoan2.text,
        'id': id3
      },
      {
        'doc_no': docNumber,
        'group_id': '3',
        'type_id': '10',
        'sub_type_id': '12',
        'amount': _vehicleloan.text,
        'id': id4
      },
    ];
    var encodedData = jsonEncode(data);
    return encodedData;
  }

  Future<void> _save() async {
    setState(() {
      _isLoading = true;
    });
    //await _fetchUserDeclaration();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.save);
    var request = new http.MultipartRequest('POST', uri);
    var data = settingData();
    print('data: $data');
    request.fields['data'] = data;
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      print('success');
      Flushbar(
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.check, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'Saved successfully',
        barBlur: 20,
      ).show(context);
    } else {
      print('status code: ${response.statusCode}');
      print('error');
      Flushbar(
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'Something went wrong',
        barBlur: 20,
      ).show(context);
    }
  }

  Future<void> _fetchHousingLoanLimit(String housingLoan) async {
    if (housingLoan == '' || housingLoan.isEmpty) {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'loan amount cannot be empty',
        barBlur: 20,
      ).show(context);
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var uri = Uri.parse(AppUrl.allDeclarationRule);
      var request = new http.MultipartRequest('POST', uri);
      request.fields['type_id'] = '8';
      request.headers.addAll(
          {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

      var response = await request.send();
      if (response.statusCode == 200) {
        print('success');
        var response2 = await http.Response.fromStream(response);
        var responseDecoded = json.decode(response2.body);
        print('responseDecoded: $responseDecoded');
        _limit1 = responseDecoded['limit'];
        print('limit: $_limit1');
        if (double.parse(housingLoan) > double.parse(_limit1)) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'limit is $_limit1',
            barBlur: 20,
          ).show(context);
        }
      } else {
        print('error');
        throw Exception('something went wrong');
      }
    }
  }

  Future<void> _fetchHousingLoanLimit2(String housingLoan) async {
    if (housingLoan == '' || housingLoan.isEmpty) {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'loan amount cannot be empty',
        barBlur: 20,
      ).show(context);
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var uri = Uri.parse(AppUrl.allDeclarationRule);
      var request = new http.MultipartRequest('POST', uri);
      request.fields['type_id'] = '9';
      request.headers.addAll(
          {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

      var response = await request.send();
      if (response.statusCode == 200) {
        print('success');
        var response2 = await http.Response.fromStream(response);
        var responseDecoded = json.decode(response2.body);
        print('responseDecoded: $responseDecoded');
        _limit2 = responseDecoded['limit'];
        print('limit: $_limit2');
        if (double.parse(housingLoan) > double.parse(_limit2)) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'limit is $_limit2',
            barBlur: 20,
          ).show(context);
        }
      } else {
        print('error');
        throw Exception('something went wrong');
      }
    }
  }

  Future<void> _fetchHousingLoanLimit3(String housingLoan) async {
    if (housingLoan == '' || housingLoan.isEmpty) {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'loan amount cannot be empty',
        barBlur: 20,
      ).show(context);
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var uri = Uri.parse(AppUrl.allDeclarationRule);
      var request = new http.MultipartRequest('POST', uri);
      request.fields['type_id'] = '10';
      request.headers.addAll(
          {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

      var response = await request.send();
      if (response.statusCode == 200) {
        print('success');
        var response2 = await http.Response.fromStream(response);
        var responseDecoded = json.decode(response2.body);
        print('responseDecoded: $responseDecoded');
        _limit3 = responseDecoded['limit'];
        print('limit: $_limit3');
        if (double.parse(housingLoan) > double.parse(_limit3)) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'limit is $_limit3',
            barBlur: 20,
          ).show(context);
        }
      } else {
        print('error');
        throw Exception('something went wrong');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDeclaration();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loan Interest',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 22,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isStrechedDropDown = !isStrechedDropDown;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Higher education limit: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            // fontSize: 16,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStrechedDropDown = !isStrechedDropDown;
                        });
                      },
                      child: Icon(
                        isStrechedDropDown
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        // color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              ExpandedSectionTds1(
                expand: isStrechedDropDown,
                height: 200,
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      children: [
                        ContainerCard(
                          height: SizeVariables.getHeight(context) * 0.14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Higher education: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.04,
                                      width:
                                          SizeVariables.getWidth(context) * 0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: _hEducation,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        cursorColor: Colors.black,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixText: ' ₹ ',
                                          prefixStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                          hintText: 'Add Loan',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Interest paid on Loan taken for Higher Education',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                        Text(
                                          'Up-To 8 Years',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedButton(
                          height: 55,
                          width: 100,
                          text: 'Check',
                          isReverse: true,
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: (themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.black),
                          backgroundColor: (themeProvider.darkTheme)
                              ? Colors.black
                              : Colors.amberAccent,
                          borderColor: (themeProvider.darkTheme)
                              ? Colors.white
                              : Colors.amberAccent,
                          borderRadius: 10,
                          borderWidth: 2,
                          onPress: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isStrechedDropDown1 = !isStrechedDropDown1;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Housing loan limit: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '₹50,000',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            // fontSize: 16,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStrechedDropDown1 = !isStrechedDropDown1;
                        });
                      },
                      child: Icon(
                        isStrechedDropDown1
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        // color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              ExpandedSectionTds1(
                expand: isStrechedDropDown1,
                height: 200,
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      children: [
                        ContainerCard(
                          height: SizeVariables.getHeight(context) * 0.14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Housing loan: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.04,
                                      width:
                                          SizeVariables.getWidth(context) * 0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: _housingLoan1,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        cursorColor: Colors.black,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixText: ' ₹ ',
                                          prefixStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                          hintText: 'Add Loan',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Interest paid on Housing Loan',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                        Text(
                                          'Apr 2016-March 2019 (Property value 50L, and loan 35L)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedButton(
                          height: 55,
                          width: 100,
                          text: 'Check',
                          isReverse: true,
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: (themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.black),
                          backgroundColor: (themeProvider.darkTheme)
                              ? Colors.black
                              : Colors.amberAccent,
                          borderColor: (themeProvider.darkTheme)
                              ? Colors.white
                              : Colors.amberAccent,
                          borderRadius: 10,
                          borderWidth: 2,
                          onPress: () {
                            _fetchHousingLoanLimit(_housingLoan1.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isStrechedDropDown2 = !isStrechedDropDown2;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Housing loan limit: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '₹50,000',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            // fontSize: 16,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStrechedDropDown2 = !isStrechedDropDown2;
                        });
                      },
                      child: Icon(
                        isStrechedDropDown2
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        // color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              ExpandedSectionTds1(
                expand: isStrechedDropDown2,
                height: 200,
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      children: [
                        ContainerCard(
                          height: SizeVariables.getHeight(context) * 0.14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Housing loan: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.04,
                                      width:
                                          SizeVariables.getWidth(context) * 0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: _housingLoan2,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        cursorColor: Colors.black,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixText: ' ₹ ',
                                          prefixStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                          hintText: 'Add Loan',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Interest Paid on Housing Loan',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.8,
                                          child: Text(
                                            'Apr 2019 - March 2022 (Property Value< 45L [Stamp duty] and no Loan <45L)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedButton(
                          height: 55,
                          width: 100,
                          text: 'Check',
                          isReverse: true,
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: (themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.black),
                          backgroundColor: (themeProvider.darkTheme)
                              ? Colors.black
                              : Colors.amberAccent,
                          borderColor: (themeProvider.darkTheme)
                              ? Colors.white
                              : Colors.amberAccent,
                          borderRadius: 10,
                          borderWidth: 2,
                          onPress: () {
                            _fetchHousingLoanLimit2(_housingLoan2.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isStrechedDropDown3 = !isStrechedDropDown3;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Electric Vehicle limit: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '₹50,000',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            // fontSize: 16,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStrechedDropDown3 = !isStrechedDropDown3;
                        });
                      },
                      child: Icon(
                        isStrechedDropDown3
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        // color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              ExpandedSectionTds1(
                expand: isStrechedDropDown3,
                height: 200,
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      children: [
                        ContainerCard(
                          height: SizeVariables.getHeight(context) * 0.14,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Electric vehicle: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.04,
                                      width:
                                          SizeVariables.getWidth(context) * 0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: _vehicleloan,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        cursorColor: Colors.black,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixText: ' ₹ ',
                                          prefixStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                          hintText: 'Add Loan',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Text(
                                  'Interest paid on Electric Vehicle Loan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedButton(
                          height: 55,
                          width: 100,
                          text: 'Check',
                          isReverse: true,
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: (themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.black),
                          backgroundColor: (themeProvider.darkTheme)
                              ? Colors.black
                              : Colors.amberAccent,
                          borderColor: (themeProvider.darkTheme)
                              ? Colors.white
                              : Colors.amberAccent,
                          borderRadius: 10,
                          borderWidth: 2,
                          onPress: () {
                            _fetchHousingLoanLimit3(_vehicleloan.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                height: 55,
                width: 100,
                text: (_isLoading == true) ? 'Saving...' : 'Submit',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.LEFT_TO_RIGHT,
                textStyle: (widget.status == '1')
                    ? TextStyle(fontSize: 18, color: Colors.white)
                    : TextStyle(
                        fontSize: 18,
                        color: (themeProvider.darkTheme)
                            ? Colors.white
                            : Colors.black),
                backgroundColor: (widget.status == '1')
                    ? Colors.grey
                    : (themeProvider.darkTheme)
                        ? Colors.black
                        : Colors.amberAccent,
                borderColor: (themeProvider.darkTheme)
                    ? Colors.white
                    : Colors.amberAccent,
                borderRadius: 10,
                borderWidth: 2,
                onPress: (widget.status == '1')
                    ? null
                    : () {
                        var total = double.parse(_hEducation.text) +
                            double.parse(_housingLoan1.text) +
                            double.parse(_housingLoan2.text) +
                            double.parse(_vehicleloan.text);
                        widget.aFunction(total);
                        _save();
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
