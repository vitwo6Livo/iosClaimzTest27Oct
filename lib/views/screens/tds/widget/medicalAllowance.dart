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

class MedicalAllowance extends StatefulWidget {
  //const MedicalAllowance({super.key});
  final String status;
  final Function aFunction;
  MedicalAllowance(this.status, this.aFunction);

  @override
  State<MedicalAllowance> createState() => _MedicalAllowanceState();
}

class _MedicalAllowanceState extends State<MedicalAllowance> {
  final _mLimitation1 = TextEditingController(text: '0');
  final _mLimitation2 = TextEditingController(text: '0');
  final _mLimitation3 = TextEditingController(text: '0');
  final _selfage = TextEditingController();
  final _parentsage = TextEditingController();
  // final _selfDate = TextEditingController();
  // final _parentsDate = TextEditingController();
  final _rate = TextEditingController();
  final _age = TextEditingController();
  bool isStrechedDropDown = false;
  bool isStrechedDropDown1 = false;
  bool isStrechedDropDown2 = false;
  String _limit1 = '';
  String _limit2 = '';
  var docNumber = '';
  var id1 = '';
  var id2 = '';
  var id3 = '';
  var _isLoading = false;
  var total = 0.0;

  Future<void> _fetchInvestmentLimit(String selfage, String parentsage) async {
    // print('selfDate: $selfDate');
    // print('parentsDate: $parentsDate');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.allDeclarationRule);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['type_id'] = '4';
    if (selfage == '' && parentsage == '') {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'enter age',
        barBlur: 20,
      ).show(context);
    } else if ((parentsage == '' || parentsage.isEmpty) && selfage != '') {
      request.fields['self'] = selfage;
    } else if ((selfage == '' || selfage.isEmpty) && parentsage != '') {
      request.fields['parents'] = parentsage;
    } else {
      request.fields['self'] = selfage;
      request.fields['parents'] = parentsage;
    }

    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

    var response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      var response2 = await http.Response.fromStream(response);
      var responseDecoded = json.decode(response2.body);
      print('responseDecoded: $responseDecoded');
      _limit1 = responseDecoded['limit'].toString();
      print('limit: $_limit1');
      if (double.parse(_mLimitation1.text) > double.parse(_limit1)) {
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
      var response2 = await http.Response.fromStream(response);
      var responseDecoded = json.decode(response2.body);
      print('responseDecoded: $responseDecoded');
      throw Exception('something went wrong');
    }
  }

  Future<void> _fetchTreatmentLimit(String rate) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.allDeclarationRule);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['type_id'] = '5';
    if (rate == '' || rate.isEmpty || _mLimitation2.text == '0') {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'rate and teatment amount is required',
        barBlur: 20,
      ).show(context);
    } else {
      request.fields['rate'] = rate;
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
        if (_limit2.contains('Percentage is outside the valid range.')) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: '$_limit2',
            barBlur: 20,
          ).show(context);
        } else if (double.parse(_mLimitation2.text) > double.parse(_limit2)) {
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
        throw Exception('ssomething went wrong');
      }
    }
  }

  Future<void> _fetchSpecifiedLimit(String age) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.allDeclarationRule);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['type_id'] = '6';
    if (age == '' || age.isEmpty || _mLimitation3.text == '0') {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'age and amount is required',
        barBlur: 20,
      ).show(context);
    } else {
      request.fields['age'] = age;
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
        if (_limit2.contains('Percentage is outside the valid range.')) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: '$_limit2',
            barBlur: 20,
          ).show(context);
        } else if (double.parse(_mLimitation3.text) > double.parse(_limit2)) {
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
        throw Exception('ssomething went wrong');
      }
    }
  }

  settingData() {
    var data = [
      {
        'doc_no': docNumber,
        'group_id': '2',
        'type_id': '4',
        'sub_type_id': '6',
        'amount': _mLimitation1.text,
        'id': id1
      },
      {
        'doc_no': docNumber,
        'group_id': '2',
        'type_id': '5',
        'sub_type_id': '7',
        'amount': _mLimitation2.text,
        'id': id2
      },
      {
        'doc_no': docNumber,
        'group_id': '2',
        'type_id': '6',
        'sub_type_id': '8',
        'amount': _mLimitation3.text,
        'id': id3
      },
    ];
    var encodedData = jsonEncode(data);
    return encodedData;
  }

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
        //print('${resp['data'][0]['sub_type_id']}');
        for (var i = 0; i < resp['data'].length; i++) {
          //print('${resp['data'][i]['declare_submit_id']}');
          if (resp['data'][i]['sub_type_id'] == "6") {
            id1 = resp['data'][i]['declare_submit_id'].toString();
            _mLimitation1.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '7') {
            id2 = resp['data'][i]['declare_submit_id'].toString();
            _mLimitation2.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '8') {
            id3 = resp['data'][i]['declare_submit_id'].toString();
            _mLimitation3.text = resp['data'][i]['amount'];
          }
        }
      }
      //print('ids---------------${[id1, id2, id3, id4]}');
    } catch (e) {
      print('error is coming.......');
    }
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
    print('data------: $data');
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
                'Medical Allowance',
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
                    isStrechedDropDown2 = !isStrechedDropDown2;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Medical insurance limit: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '₹1,00,000',
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
                                      'Medical insurance: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      // height: SizeVariables.getHeight(context) *
                                      //     0.04,
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
                                        controller: _mLimitation1,
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
                                          hintText: 'Add medical',
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
                                  'Medical Insurance Premium, preventive health checkup and Medical Expenditure',
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'My age: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Container(
                                // height: SizeVariables.getHeight(context) * 0.04,
                                width: SizeVariables.getWidth(context) * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _selfage,
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(6),
                                  // ],
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
                                    //prefixText: ' ₹ ',
                                    prefixStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                    hintText: '   age',
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
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Parents age: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Container(
                                // height: SizeVariables.getHeight(context) * 0.04,
                                width: SizeVariables.getWidth(context) * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _parentsage,
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(6),
                                  // ],
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
                                    //prefixText: ' ₹ ',
                                    prefixStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                    hintText: '  age',
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
                            if (_mLimitation1.text == '' ||
                                _mLimitation1.text == '0' ||
                                (_selfage.text == '' &&
                                    _parentsage.text == '')) {
                              Flushbar(
                                duration: const Duration(seconds: 4),
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(Icons.error,
                                    color: Colors.white),
                                // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                // title: 'Login Successful',
                                message:
                                    'insurance and date fields cannot be empty',
                                barBlur: 20,
                              ).show(context);
                            } else {
                              _fetchInvestmentLimit(
                                  _selfage.text, _parentsage.text);
                            }
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
                    isStrechedDropDown = !isStrechedDropDown;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Treatment limit: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '₹ 75,000 & 1,25,000',
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
                                      'Medical treatment: ',
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
                                        controller: _mLimitation2,
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
                                          hintText: 'Add medical',
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
                                      'Medical Treatment of a Dependent with Disability.',
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
                                              .bodyText2!
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                        Text(
                                          'Normal - 75,000 & Disability - 1,25,000',
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rate: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Container(
                                // height: SizeVariables.getHeight(context) * 0.04,
                                width: SizeVariables.getWidth(context) * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _rate,
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(6),
                                  // ],
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
                                    //prefixText: ' ₹ ',
                                    prefixStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                    hintText: '  percentage',
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
                            _fetchTreatmentLimit(_rate.text);
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
                    isStrechedDropDown1 = !isStrechedDropDown1;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Specified: ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      '₹ 1,00,000 & 40,000',
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
                                      'Medical specified: ',
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
                                        controller: _mLimitation3,
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
                                          hintText: 'Add medical',
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
                                      'Medical expenditure for treatment of Specified Diseases',
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
                                              .bodyText2!
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                        ),
                                        Text(
                                          'Senior - 1,00,000 & Others - 40,000',
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'age: ',
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
                                height: SizeVariables.getHeight(context) * 0.04,
                                width: SizeVariables.getWidth(context) * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _age,
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
                                    //prefixText: ' ₹ ',
                                    prefixStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                    hintText: '  age',
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
                        AnimatedButton(
                          height: 55,
                          width: 100,
                          text: 'Check',
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
                          backgroundColor: (themeProvider.darkTheme)
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
                                  _fetchSpecifiedLimit(_age.text);
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
                text: 'Sumit',
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
                        total = double.parse(_mLimitation1.text) +
                            double.parse(_mLimitation2.text) +
                            double.parse(_mLimitation3.text);
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
