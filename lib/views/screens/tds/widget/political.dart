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

class Political extends StatefulWidget {
  //const Political({super.key});
  final String status;
  final Function aFunction;
  Political(this.status, this.aFunction);

  @override
  State<Political> createState() => _PoliticalState();
}

class _PoliticalState extends State<Political> {
  final _contribution = TextEditingController(text: '0');
  final _individual = TextEditingController(text: '0');
  bool isStrechedDropDown = false;
  bool isStrechedDropDown1 = false;
  var docNumber = '';
  var id1 = '';
  var id2 = '';
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
          print('${resp['data'][i]['declare_submit_id']}');
          if (resp['data'][i]['sub_type_id'] == "16") {
            id1 = resp['data'][i]['declare_submit_id'].toString();
            _contribution.text = resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '17') {
            id2 = resp['data'][i]['declare_submit_id'].toString();
            _individual.text = resp['data'][i]['amount'];
          }
        }
      }
    } catch (e) {
      print('error');
    }
  }

  @override
  void initState() {
    _fetchUserDeclaration();
    super.initState();
  }

  settingData() {
    var data = [
      {
        'doc_no': docNumber,
        'group_id': '5',
        'type_id': '14',
        'sub_type_id': '16',
        'amount': _contribution.text,
        'id': id1
      },
      {
        'doc_no': docNumber,
        'group_id': '5',
        'type_id': '15',
        'sub_type_id': '17',
        'amount': _individual.text,
        'id': id2
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
                'Political',
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
                      'Political limit: ',
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
                                      'Political: ',
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
                                        controller: _contribution,
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
                                          hintText: 'Add Political',
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
                                  'Contribution to Political Parties',
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
                      'Individuals political limit: ',
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
                                      'Individuals political: ',
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
                                        controller: _individual,
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
                                          hintText: 'Add Political',
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
                                  'Individuals on contribution to Political Parties',
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
            height: SizeVariables.getHeight(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                height: 55,
                width: 100,
                text: (_isLoading) ? 'Saving...' : 'Sumit',
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
                        var total = double.parse(_contribution.text) +
                            double.parse(_individual.text);
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
