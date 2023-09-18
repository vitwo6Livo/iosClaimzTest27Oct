import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../viewModel/regularizationViewModel.dart';
import 'package:provider/provider.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../utils/routes/routeNames.dart';

class RegularisationContainer extends StatefulWidget {
  // const RegularisationContainer({Key? key}) : super(key: key);
  String date;

  @override
  State<RegularisationContainer> createState() =>
      _RegularisationContainerState();

  RegularisationContainer(this.date);
}

class _RegularisationContainerState extends State<RegularisationContainer> {
  int _selection = 0;
  DateTime? _dateTime;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat dateTime = DateFormat('HH:mm:ss');
  TextEditingController _text = TextEditingController();
  TextEditingController selectdate = new TextEditingController();
  TextEditingController _fromtime = new TextEditingController();
  TextEditingController _totime = new TextEditingController();

  var fromTime;
  var toTime;

  TimeOfDay timeFrom = TimeOfDay.now();
  String time_day = '';

  TimeOfDay _timeFrom = TimeOfDay.now();
  String _time_day = '';

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? add;

  List<String> categorys = [
    "Forgot to Sign in",
    "Forgot to Sign out",
  ];

  bool _isFullDay = false;
  bool _isHalfDay = false;
  bool _isCheck = false;
  bool _isCheck1 = false;

  @override
  void initState() {
    // TODO: implement initState
    selectdate.text = dateFormat.format(DateTime.parse(widget.date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    print('HEIGHT: $height');
    print('WIDTH: $width');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: SizeVariables.getHeight(context) * 0.09.h,

            // height: height > 750
            //     ? _isCheck == true || _isCheck1 == true
            //         ? 56.h
            //         : 50.h
            //     : height < 650
            //         ? _isCheck == true || _isCheck1 == true
            //             ? 58.h
            //             : 52.h
            //         : _isCheck == true || _isCheck1 == true
            //             ? 61.h
            //             : 55.h,
            child: Column(
              children: [
                ContainerStyle(
                  height: SizeVariables.getHeight(context) * 0.209,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.02,
                        right: SizeVariables.getWidth(context) * 0.02,
                        top: SizeVariables.getHeight(context) * 0.01,
                        bottom: SizeVariables.getHeight(context) * 0.01,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  'Checked in: ${dateTime.format(DateTime.parse(widget.date))}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                    'You are marked as Abssent/Half Day on ${dateFormat.format(DateTime.parse(widget.date))}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Marked Attendance as:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          activeColor:
                                              Color.fromARGB(88, 43, 41, 41),
                                          // focusColor: Colors.red,
                                          // hoverColor: Colors.blue,
                                          // mouseCursor: Colors.green,
                                          fillColor: (themeProvider.darkTheme)
                                              ? MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.white;
                                                })
                                              : MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.black;
                                                }),
                                          // fillColor: Colors.green,
                                          checkColor: Colors.amber,
                                          value: _isFullDay,
                                          onChanged: _isHalfDay == true ||
                                                  _isCheck == true ||
                                                  _isCheck1 == true
                                              ? (_) {}
                                              : (fullDayCheck) {
                                                  setState(() {
                                                    _isFullDay = fullDayCheck!;
                                                  });
                                                  print(
                                                      'IS FULL DAY: $_isFullDay');
                                                },
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          // => _selectedOption(0),
                                          child: Text(
                                            'Full Day',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getHeight(context) * 0.02,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          activeColor:
                                              Color.fromARGB(88, 43, 41, 41),
                                          // focusColor: Colors.red,
                                          // hoverColor: Colors.blue,
                                          // mouseCursor: Colors.green,
                                          fillColor: (themeProvider.darkTheme)
                                              ? MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.white;
                                                })
                                              : MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.black;
                                                }),
                                          // fillColor: Colors.green,
                                          checkColor: Colors.amber,
                                          value: _isHalfDay,
                                          onChanged: _isFullDay == true ||
                                                  _isCheck == true ||
                                                  _isCheck1 == true
                                              ? (_) {}
                                              : (halfDayCheck) {
                                                  setState(() {
                                                    _isHalfDay = halfDayCheck!;
                                                  });
                                                  print(
                                                      'IS HALF DAY: $_isHalfDay');
                                                },
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          // => _selectedOption(1),
                                          child: Text(
                                            'Half Day',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'OR',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ContainerStyle(
                  height: SizeVariables.getHeight(context) * 0.209,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.02,
                        right: SizeVariables.getWidth(context) * 0.02,
                        top: SizeVariables.getHeight(context) * 0.01,
                        bottom: SizeVariables.getHeight(context) * 0.01,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  'Checked in: ${dateTime.format(DateTime.parse(widget.date))}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'You can request to regularise your in and Out Time',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Mark for which reason:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          activeColor:
                                              Color.fromARGB(88, 43, 41, 41),
                                          // focusColor: Colors.red,
                                          // hoverColor: Colors.blue,
                                          // mouseCursor: Colors.green,
                                          fillColor: (themeProvider.darkTheme)
                                              ? MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.white;
                                                })
                                              : MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.black;
                                                }),
                                          // fillColor: Colors.green,
                                          checkColor: Colors.amber,
                                          value: _isCheck,
                                          onChanged: _isFullDay == true ||
                                                  _isHalfDay == true
                                              ? (_) {}
                                              : (check) {
                                                  setState(() {
                                                    _isCheck = check!;
                                                  });
                                                  print('IS CHECK: $_isCheck');
                                                },
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          // => _selectedOption(0),
                                          child: Text(
                                            'Forgot to Sign in',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          activeColor:
                                              Color.fromARGB(88, 43, 41, 41),
                                          // focusColor: Colors.red,
                                          // hoverColor: Colors.blue,
                                          // mouseCursor: Colors.green,
                                          fillColor: (themeProvider.darkTheme)
                                              ? MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.white;
                                                })
                                              : MaterialStateProperty
                                                  .resolveWith<Color>((states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return Colors.black;
                                                  }
                                                  return Colors.black;
                                                }),
                                          // fillColor: Colors.green,
                                          checkColor: Colors.amber,
                                          value: _isCheck1,
                                          onChanged: _isFullDay == true ||
                                                  _isHalfDay == true
                                              ? (_) {}
                                              : (check1) {
                                                  setState(() {
                                                    _isCheck1 = check1!;
                                                  });
                                                  print(
                                                      'IS CHECK1: $_isCheck1');
                                                },
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          // => _selectedOption(1),
                                          child: Text(
                                            'Forgot to Sign out',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                ContainerStyle(
                  height: SizeVariables.getHeight(context) * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   // color: Colors.red,
                          //   child: Row(
                          //     children: [
                          //       InkWell(
                          //         onTap: () {},
                          //         child: Container(
                          //           child: Icon(
                          //             Icons.calendar_month_outlined,
                          //             color: Theme.of(context).accentColor,
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: SizeVariables.getWidth(context) * 0.02,
                          //       ),
                          //       Container(
                          //         width: SizeVariables.getWidth(context) * 0.3,
                          //         // width: 300,
                          //         // height: 200,
                          //         child: TextFormField(
                          //           controller: selectdate,
                          //           readOnly: true,
                          //           keyboardType: TextInputType.text,
                          //           decoration: InputDecoration(
                          //             enabledBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color: Color.fromARGB(
                          //                       255, 167, 164, 164)),
                          //             ),
                          //             focusedBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color: Color.fromARGB(
                          //                       255, 194, 191, 191)),
                          //             ),
                          //             // border: InputBorder.none,
                          //             labelText: 'Select date',
                          //             // hintText: "From",
                          //             // hintStyle: Theme.of(context)
                          //             //     .textTheme
                          //             //     .bodyText2!
                          //             //     .copyWith(color: Colors.grey),
                          //             labelStyle: Theme.of(context)
                          //                 .textTheme
                          //                 .bodyText1!
                          //                 .copyWith(
                          //                     fontSize: 16,
                          //                     color: Theme.of(context)
                          //                         .accentColor),
                          //           ),
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText2!
                          //               .copyWith(color: Colors.white),
                          //           showCursor: false,
                          //           cursorColor: Colors.white,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            // color: Colors.green,
                            // padding:
                            //     const EdgeInsets.only(left: 25.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment:
                                  _isCheck == true && _isCheck1 == false
                                      ? MainAxisAlignment.start
                                      : _isCheck == false && _isCheck1 == true
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.center,
                              children: [
                                _isCheck == false
                                    ? Container()
                                    : Container(
                                        // color: Colors.red,
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     _isCheck == true && _isCheck1 == false
                                          //         ? MainAxisAlignment.start
                                          //         : MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print(
                                                    'TIME FROMMMMMMMMMMMMMM: $timeFrom');

                                                bool is24HoursFormat =
                                                    MediaQuery.of(context)
                                                        .alwaysUse24HourFormat;

                                                print(
                                                    'is24HoursFormat $is24HoursFormat');

                                                showTimePicker(
                                                  context: context,
                                                  initialTime: timeFrom,
                                                  // builder: (context, child) => MediaQuery(
                                                  //     data: MediaQuery.of(context)
                                                  //         .copyWith(
                                                  //             alwaysUse24HourFormat:
                                                  //                 true),
                                                  //     child: child!),
                                                ).then((value) {
                                                  print(
                                                      'SELECTED FROM TIMEEEEEEEEE: $value');

                                                  print(
                                                      'SELECTED FROM TIMEEEEEEEEE TYPE: ${value.runtimeType}');

                                                  // var fromTime;
                                                  is24HoursFormat == false
                                                      ? setState(() {
                                                          _fromtime.text =
                                                              value!.format(
                                                                  context);

                                                          var df = DateFormat(
                                                              "h:mm a");

                                                          var dt = df.parse(
                                                              value.format(
                                                                  context));

                                                          timeFrom = value;
                                                          // fromTime = timeFrom.format(context);
                                                          fromTime = DateFormat(
                                                                  'HH:mm')
                                                              .format(dt);

                                                          print(
                                                              'POST CONVERSIONNNNNNN: $fromTime');

                                                          // _fromtime.text = fromTime;

                                                          // print('FROM TIMEEEEEEEEEEEEEEE: $fromTime');
                                                          // print('TIME OF DAY FORMAT: ${fromTime.runtimeType}');
                                                          // print('TIME OF DAY IN STRING: ${fromTime.toString()}');
                                                          // print('TIME OF DAY STRING FORMAT: ${fromTime.runtimeType}');

                                                          // var df = DateFormat("hh:mm a");
                                                          // var dt = df
                                                          //     .parse(timeFrom.format(context));
                                                          // var finaltime =
                                                          //     DateFormat('hh:mm').format(dt);
                                                          // print('SELECTED TIME: ${DateFormat('HH:mm').format(DateFormat.jm().parse(_fromtime.text))}');
                                                          // print(
                                                          //     'SELECTED TIME TYPE: ${finaltime.runtimeType}');
                                                        })
                                                      : setState(() {
                                                          timeFrom = value!;
                                                          fromTime = timeFrom
                                                              .format(context);
                                                          _fromtime.text =
                                                              fromTime;
                                                        });
                                                });
                                              },
                                              child: Container(
                                                child: Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Theme.of(context)
                                                        .canvasColor),
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                            Container(
                                              // color: Colors.red,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              // width: 300,
                                              // height: 200,
                                              child: TextFormField(
                                                controller: _fromtime,
                                                readOnly: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Color.fromARGB(
                                                            255,
                                                            167,
                                                            164,
                                                            164)),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Color.fromARGB(
                                                            255,
                                                            194,
                                                            191,
                                                            191)),
                                                  ),
                                                  // border: InputBorder.none,
                                                  labelText: 'From time',
                                                  // hintText: "From",
                                                  // hintStyle: Theme.of(context)
                                                  //     .textTheme
                                                  //     .bodyText2!
                                                  //     .copyWith(color: Colors.grey),
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .canvasColor),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.white),
                                                showCursor: false,
                                                cursorColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.05),
                                _isCheck1 == false
                                    ? Container()
                                    : Container(
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                bool is24HoursFormat =
                                                    MediaQuery.of(context)
                                                        .alwaysUse24HourFormat;

                                                print(
                                                    'is24HoursFormat $is24HoursFormat');

                                                showTimePicker(
                                                  context: context,
                                                  initialTime: timeFrom,
                                                  // builder: (context, child) => MediaQuery(
                                                  //     data: MediaQuery.of(context)
                                                  //         .copyWith(
                                                  //             alwaysUse24HourFormat:
                                                  //                 true),
                                                  //     child: child!),
                                                ).then((value) {
                                                  print(
                                                      'SELECTED FROM TIMEEEEEEEEE: $value');

                                                  print(
                                                      'SELECTED FROM TIMEEEEEEEEE TYPE: ${value.runtimeType}');

                                                  var fromTime;

                                                  is24HoursFormat == false
                                                      ? setState(() {
                                                          // timeFrom = value!;
                                                          // toTime = timeFrom.format(context);
                                                          // _totime.text = toTime;

                                                          _totime.text = value!
                                                              .format(context);

                                                          var df = DateFormat(
                                                              "h:mm a");

                                                          var dt = df.parse(
                                                              value.format(
                                                                  context));

                                                          timeFrom = value;
                                                          // fromTime = timeFrom.format(context);
                                                          toTime = DateFormat(
                                                                  'HH:mm')
                                                              .format(dt);

                                                          print(
                                                              'POST CONVERSIONNNNNNN: $fromTime');

                                                          // print('TO TIMEEEEEEE: $timeFrom');
                                                          // var df = DateFormat("h:mm a");
                                                          // var dt = df
                                                          //     .parse(timeFrom.format(context));
                                                          // var finaltime =
                                                          //     DateFormat('HH:mm').format(dt);
                                                          // _totime.text = finaltime;
                                                          // print('SELECTED TIME: ${_totime.text}');
                                                          // print(
                                                          //     'SELECTED TIME TYPE: ${value.runtimeType}');
                                                        })
                                                      : setState(() {
                                                          timeFrom = value!;
                                                          toTime = timeFrom
                                                              .format(context);
                                                          _totime.text = toTime;
                                                        });
                                                });
                                              },
                                              child: Container(
                                                child: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              // width: 300,
                                              // height: 200,
                                              child: TextFormField(
                                                controller: _totime,
                                                readOnly: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Color.fromARGB(
                                                            255,
                                                            167,
                                                            164,
                                                            164)),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Color.fromARGB(
                                                            255,
                                                            194,
                                                            191,
                                                            191)),
                                                  ),
                                                  // border: InputBorder.none,
                                                  labelText: 'To time',
                                                  // hintText: "To",
                                                  // hintStyle: Theme.of(context)
                                                  //     .textTheme
                                                  //     .bodyText2!
                                                  //     .copyWith(color: Colors.grey),
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .canvasColor),
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.white),
                                                showCursor: true,
                                                cursorColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.description_outlined,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Description',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.0001,
                                ),
                                Form(
                                  key: _key,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        // right: SizeVariables.getWidth(context) * 0.06,
                                        // left: SizeVariables.getWidth(context) * 0.025,
                                        top: 1.h),
                                    child: Container(
                                      decoration: (themeProvider.darkTheme)
                                          ? BoxDecoration()
                                          : BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.amber, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: (themeProvider
                                                      .darkTheme)
                                                  ? []
                                                  : [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 0,
                                                        blurRadius: 7,
                                                        //offset: Offset(0, 3), // changes position of shadow
                                                      ),
                                                    ],
                                            ),
                                      child: ContainerStyle(
                                        // margin: const EdgeInsets.only(right: 25),
                                        // height: SizeVariables.getHeight(context) * 0.1,
                                        height: 15.h,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: TextFormField(
                                            controller: _text,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              // border: OutlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey),
                                              // ),
                                              // fillColor: Colors.grey,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            maxLines: 10,
                                            validator: (value) {
                                              if (value!.isEmpty ||
                                                  value == '') {
                                                return 'Please enter Reason';
                                              } else {
                                                add = value;
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: AnimatedButton(
                                  height: 45,
                                  width: 100,
                                  text: 'Submit',
                                  isReverse: true,
                                  selectedTextColor: Colors.black,
                                  transitionType: TransitionType.LEFT_TO_RIGHT,
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: (themeProvider.darkTheme)
                                          ? Colors.white
                                          : Colors.black),
                                  backgroundColor: (themeProvider.darkTheme)
                                      ? Colors.black
                                      : Colors.amberAccent,
                                  borderColor: (themeProvider.darkTheme)
                                      ? Colors.white
                                      : Colors.amberAccent,
                                  borderRadius: 8,
                                  borderWidth: 2,
                                  onPress: () {
                                    if (_isCheck == false &&
                                        _isCheck1 == false &&
                                        _isFullDay == false &&
                                        _isHalfDay == false) {
                                      Flushbar(
                                              duration:
                                                  const Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.BOTTOM,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              icon: const Icon(Icons.error,
                                                  color: Colors.white),
                                              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                              // title: 'Regularisation Added',
                                              message: 'Please Specify Reason')
                                          .show(context);
                                    } else if (_isCheck == true &&
                                        _fromtime.text == '') {
                                      Flushbar(
                                              duration:
                                                  const Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.BOTTOM,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              icon: const Icon(Icons.error,
                                                  color: Colors.white),
                                              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                              // title: 'Regularisation Added',
                                              message: 'Please Enter From Time')
                                          .show(context);
                                    } else if (_isCheck1 == true &&
                                        _totime.text == '') {
                                      Flushbar(
                                              duration:
                                                  const Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.BOTTOM,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              icon: const Icon(Icons.error,
                                                  color: Colors.white),
                                              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                              // title: 'Regularisation Added',
                                              message: 'Please Enter To Time')
                                          .show(context);
                                    } else if (_isFullDay == false &&
                                        _isHalfDay == false &&
                                        _fromtime.text != '' &&
                                        _totime.text != '' &&
                                        (DateFormat('HH:mm').parse(toTime))
                                                .difference(DateFormat('HH:mm')
                                                    .parse(fromTime)) <
                                            const Duration(hours: 0)) {
                                      Flushbar(
                                              duration:
                                                  const Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.BOTTOM,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              icon: const Icon(Icons.error,
                                                  color: Colors.white),
                                              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                              // title: 'Regularisation Added',
                                              message:
                                                  'To Time cannot be less than From Time')
                                          .show(context);
                                    } else if (_key.currentState!.validate()) {
                                      Map<String, dynamic> data = {
                                        'attendance_date': selectdate.text,
                                        // 'reason':
                                        //     _selection == 0 ? 'Check In' : 'Forgot To Check Out',
                                        'reason': _isFullDay == true
                                            ? 'Full Day'
                                            : _isHalfDay == true
                                                ? 'Half Day'
                                                : _isCheck == true &&
                                                        _isCheck1 == false
                                                    ? 'Check In'
                                                    : _isCheck == true &&
                                                            _isCheck1 == true
                                                        ? 'Check In & Check Out'
                                                        : 'Forgot To Check Out',
                                        'description': _text.text,
                                        'checkin': _isFullDay == true ||
                                                _isHalfDay == true
                                            ? ''
                                            : _fromtime.text,
                                        'checkout': _isFullDay == true
                                            ? ''
                                            : _isHalfDay == true
                                                ? ''
                                                : _totime.text
                                      };
                                      if (kDebugMode) {
                                        print('Regularisation Data: $data');
                                      }
                                      Provider.of<RegularizationViewModel>(
                                              context,
                                              listen: false)
                                          .addRegularization(data, context)
                                          .then((value) {
                                        setState(() {
                                          selectdate.clear();
                                          _fromtime.clear();
                                          _totime.clear();
                                          _text.clear();
                                          _isFullDay = false;
                                          _isHalfDay = false;
                                          _isCheck = false;
                                          _isCheck1 = false;
                                        });
                                      });
                                      print('Add Note: $add');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _selectedOption(int i) {
    setState(() {
      _selection = i;
    });
  }
}
