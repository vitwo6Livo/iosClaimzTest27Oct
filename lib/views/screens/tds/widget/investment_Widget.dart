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
import '../animated/animated.dart';
import '../animated/animated1.dart';
import '../animated/card.dart';
import 'package:http/http.dart' as http;

class Investment extends StatefulWidget {
  //const Investment({super.key});
  var status;
  final Function aFunction;
  Investment(this.status, this.aFunction);

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  final _limitation1 = TextEditingController(text: '0');
  final _limitation2 = TextEditingController(text: '0');
  final _limitation3 = TextEditingController(text: '0');
  final _limitation4 = TextEditingController(text: '0');
  final _limitation5 = TextEditingController(text: '0');
  bool isStrechedDropDown = false;
  bool isStrechedDropDown1 = false;
  bool isStrechedDropDown2 = false;
  String limit1 = '';
  String limit2 = '';
  double limit3 = 0.0;
  var docNumber = '';
  var id1 = '';
  var id2 = '';
  var id3 = '';
  var id4 = '';
  var id5 = '';
  var _isLoading = false;
  var total = 0.0;

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
          print('${resp['data'][i]['declare_submit_id']}');
          if (resp['data'][i]['sub_type_id'] == "1") {
            id1 = resp['data'][i]['declare_submit_id'].toString();
            _limitation1.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '2') {
            id2 = resp['data'][i]['declare_submit_id'].toString();
            _limitation2.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '3') {
            id3 = resp['data'][i]['declare_submit_id'].toString();
            _limitation3.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '4') {
            id4 = resp['data'][i]['declare_submit_id'].toString();
            _limitation4.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '5') {
            id5 = resp['data'][i]['declare_submit_id'].toString();
            _limitation5.text = resp['data'][i]['amount'];
          }
        }
      }
      //print('ids---------------${[id1, id2, id3, id4]}');
    } catch (e) {
      print('error is coming.......');
    }
  }

  settingData() {
    var data = [
      {
        'doc_no': docNumber,
        'group_id': '1',
        'type_id': '1',
        'sub_type_id': '1',
        'amount': _limitation1.text,
        'id': id1
      },
      {
        'doc_no': docNumber,
        'group_id': '1',
        'type_id': '1',
        'sub_type_id': '2',
        'amount': _limitation2.text,
        'id': id2
      },
      {
        'doc_no': docNumber,
        'group_id': '1',
        'type_id': '1',
        'sub_type_id': '3',
        'amount': _limitation3.text,
        'id': id3
      },
      {
        'doc_no': docNumber,
        'group_id': '1',
        'type_id': '2',
        'sub_type_id': '4',
        'amount': _limitation4.text,
        'id': id4
      },
      {
        'doc_no': docNumber,
        'group_id': '1',
        'type_id': '3',
        'sub_type_id': '5',
        'amount': _limitation5.text,
        'id': id5
      }
    ];
    var encodedData = jsonEncode(data);
    return encodedData;
  }

  Future<void> _save() async {
    setState(() {
      _isLoading = true;
    });
    // await _fetchUserDeclaration();
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

  Future<void> _fetchInvestmentLimit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.allDeclarationRule);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['type_id'] = '1';
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

    var response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      var response2 = await http.Response.fromStream(response);
      var responseDecoded = json.decode(response2.body);
      print('responseDecoded: $responseDecoded');
      limit1 = responseDecoded['limit'];
      print('limit: $limit1');
    } else {
      print('response.statuscode: ${response.statusCode}');
      print('error');
      throw Exception('something went wrong');
    }
  }

  Future<void> _fetchAtalPensionLimit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.allDeclarationRule);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['type_id'] = '2';
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

    var response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      var response2 = await http.Response.fromStream(response);
      var responseDecoded = json.decode(response2.body);
      print('responseDecoded: $responseDecoded');
      limit2 = responseDecoded['limit'];
      print('limit: $limit2');
    } else {
      print('response.statuscode: ${response.statusCode}');
      print('error');
      throw Exception('something went wrong');
    }
  }

  Future<void> _fetchPensionLimit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.allDeclarationRule);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['type_id'] = '3';
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});

    var response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      var response2 = await http.Response.fromStream(response);
      var responseDecoded = json.decode(response2.body);
      print('responseDecoded: $responseDecoded');
      limit3 = responseDecoded['limit'];
      print('limit: $limit3');
    } else {
      print('response.statuscode: ${response.statusCode}');
      print('error');
      throw Exception('something went wrong');
    }
  }

  @override
  void initState() {
    _fetchUserDeclaration().then((value) => _fetchInvestmentLimit()
        .then((value) => _fetchAtalPensionLimit())
        .then((value) => _fetchPensionLimit()));
    // _fetchInvestmentLimit()
    //     .then((value) => _fetchAtalPensionLimit())
    //     .then((value) => _fetchPensionLimit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Investment',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Investment limit:',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                      ),
                      Text(
                        '₹ 1,50,000',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            children: [
                              Text(
                                'Remain: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              Text(
                                '₹50,000',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
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
                ExpandedSectionTds(
                  expand: isStrechedDropDown,
                  height: 500,
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
                                        'Popular invest:',
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.04,
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          controller: _limitation1,
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
                                            hintText: 'Add innvest',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    'Investing into very common and popular investment options like LIC, PPF, Sukanya Samriddhi Account, Mutual Funds, FD, child tuition fee, ULIP, etc',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01,
                          ),
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
                                        'Pension funds:',
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.04,
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          controller: _limitation2,
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
                                            hintText: 'Add innvest',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    'Investment in Pension Funds',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01,
                          ),
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
                                        'Atal pension:',
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.04,
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          controller: _limitation3,
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
                                            hintText: 'Add innvest',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    'Atal Pension Yojana and National Pension Scheme Contribution',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
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
                              print(_limitation1.text);
                              print(_limitation2.text);
                              print(_limitation3.text);
                              var sum = double.parse(_limitation1.text) +
                                  double.parse(_limitation2.text) +
                                  double.parse(_limitation3.text);
                              print('sum: $sum');

                              if (sum > double.parse(limit1)) {
                                print('uncked');
                                Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                  // title: 'Login Successful',
                                  message: 'limit is $limit1',
                                  barBlur: 20,
                                ).show(context);
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
                      isStrechedDropDown1 = !isStrechedDropDown1;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Atal pension yojana limit: ',
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
                                        'Atal pension yojana: ',
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.04,
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          controller: _limitation4,
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
                                            hintText: 'Add innvest',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    'Atal Pension Yojana and National Pension SchemeContribution (additional deduction)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
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
                              if (_limitation4.text == '0') {
                                Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                  // title: 'Login Successful',
                                  message: 'Amount is required',
                                  barBlur: 20,
                                ).show(context);
                              } else if (double.parse(_limitation4.text) <=
                                  double.parse(limit2)) {
                                print('checked');
                              } else {
                                Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                  // title: 'Login Successful',
                                  message: 'limit is $limit2',
                                  barBlur: 20,
                                ).show(context);
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
                      isStrechedDropDown2 = !isStrechedDropDown2;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        ' Pension Scheme limit: ',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                      ),
                      Text(
                        '1 0% of basic',
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
                                        'Pension Scheme: ',
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.04,
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          controller: _limitation5,
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
                                            hintText: 'Add innvest',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Text(
                                    'National Pension SchemeContribution by Employer',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
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
                              if (_limitation5.text == '0') {
                                Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                  // title: 'Login Successful',
                                  message: 'Amount cannot be empty',
                                  barBlur: 20,
                                ).show(context);
                              } else if (double.parse(_limitation5.text) <=
                                  limit3) {
                                print('checked');
                              } else {
                                Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                  // title: 'Login Successful',
                                  message: 'limit is $limit3',
                                  barBlur: 20,
                                ).show(context);
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
                          total = double.parse(_limitation1.text) +
                              double.parse(_limitation2.text) +
                              double.parse(_limitation3.text) +
                              double.parse(_limitation4.text) +
                              double.parse(_limitation5.text);
                          widget.aFunction(total);
                          _save();
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
