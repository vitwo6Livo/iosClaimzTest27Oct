import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../../../provider/theme_provider.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/compOffViewModel.dart';
import '../../../config/mediaQuery.dart';

class CompoffForm extends StatefulWidget {
  // const CompoffScreen({Key? key}) : super(key: key);
  final String date;
  final String fromDate;
  final String toDate;

  @override
  State<CompoffForm> createState() => _CompoffFormState();

  CompoffForm(this.date, this.fromDate, this.toDate);
}

class _CompoffFormState extends State<CompoffForm> {
  TextEditingController _textcompoff = TextEditingController();
  var myYears = "2022-08-09";
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  DateTime? _dateTime;
  TimeOfDay timeFrom = TimeOfDay.now();
  String time_day = '';

  TimeOfDay _timeFrom = TimeOfDay.now();
  String _time_day = '';
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? add;

  // final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.025,
                  top: SizeVariables.getHeight(context) * 0.05),
              child: Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                    SizedBox(
                      width: SizeVariables.getWidth(context) * 0.02,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Comp-Offf Add',
                        style: Theme.of(context).textTheme.caption,
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
          Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: Column(
              children: [
                ContainerStyle(
                  height: height > 750
                      ? 48.h
                      : height < 650
                          ? 50.h
                          : 53.h,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.05,
                      right: SizeVariables.getWidth(context) * 0.05,
                      top: SizeVariables.getHeight(context) * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  dateFormat
                                      .format(DateTime.parse(widget.date)),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        Container(
                          height: 50,
                          // color: Colors.amber,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: double.infinity,
                                // color: Colors.green,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'From Time',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showTimePicker(
                                          builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                primary: Color(0xffF59F23),
                                                surface: Colors.black,
                                                onSurface: Colors.white,
                                              ),
                                              dialogBackgroundColor:
                                                  Color.fromARGB(
                                                      255, 91, 91, 91),
                                            ),
                                            child: child!,
                                          ),
                                          context: context,
                                          initialTime: timeFrom,
                                        ).then((value) {
                                          setState(() {
                                            timeFrom = value!;
                                            time_day = timeFrom.format(context);
                                            print(time_day);
                                          });
                                        });
                                      },
                                      child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        // color: Colors.red,
                                        child: Center(
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showTimePicker(
                                                    builder: (context, child) =>
                                                        Theme(
                                                      data:
                                                          ThemeData().copyWith(
                                                        colorScheme:
                                                            const ColorScheme
                                                                .dark(
                                                          primary:
                                                              Color(0xffF59F23),
                                                          surface: Colors.black,
                                                          onSurface:
                                                              Colors.white,
                                                        ),
                                                        dialogBackgroundColor:
                                                            Color.fromARGB(255,
                                                                91, 91, 91),
                                                      ),
                                                      child: child!,
                                                    ),
                                                    context: context,
                                                    initialTime: timeFrom,
                                                  ).then((value) {
                                                    setState(() {
                                                      timeFrom = value!;
                                                      time_day = timeFrom
                                                          .format(context);
                                                      print(time_day);
                                                    });
                                                  });
                                                },
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    time_day == ''
                                                        ? 'From Time '
                                                        : ' $time_day',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                // color: Colors.blue,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showTimePicker(
                                          builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                primary: Color(0xffF59F23),
                                                surface: Colors.black,
                                                onSurface: Colors.white,
                                              ),
                                              dialogBackgroundColor:
                                                  Color.fromARGB(
                                                      255, 91, 91, 91),
                                            ),
                                            child: child!,
                                          ),
                                          context: context,
                                          initialTime: _timeFrom,
                                        ).then((value) {
                                          setState(() {
                                            _timeFrom = value!;
                                            _time_day =
                                                _timeFrom.format(context);
                                            print(_time_day);
                                          });
                                        });
                                      },
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'To Time',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showTimePicker(
                                          builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                primary: Color(0xffF59F23),
                                                surface: Colors.black,
                                                onSurface: Colors.white,
                                              ),
                                              dialogBackgroundColor:
                                                  Color.fromARGB(
                                                      255, 91, 91, 91),
                                            ),
                                            child: child!,
                                          ),
                                          context: context,
                                          initialTime: _timeFrom,
                                        ).then((value) {
                                          setState(() {
                                            _timeFrom = value!;
                                            _time_day =
                                                _timeFrom.format(context);
                                            print(_time_day);
                                          });
                                        });
                                      },
                                      child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        child: Center(
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  _time_day == ''
                                                      ? 'To Time '
                                                      : ' $_time_day',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02),
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
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
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
                                            boxShadow: (themeProvider.darkTheme)
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
                                      height: 18.h,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller: _textcompoff,
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
                                          maxLines: 5,
                                          validator: (value) {
                                            if (value!.isEmpty || value == '') {
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
                        Center(
                          child: Container(
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
                                if (kDebugMode) {
                                  print(myYears);
                                }
                                Map<String, dynamic> data = {
                                  'compoff_date': dateFormat
                                      .format(DateTime.parse(widget.date)),
                                  'from_time': time_day.toString(),
                                  'to_time': _time_day.toString()
                                };
                                Provider.of<CompOffViewModel>(context,
                                        listen: false)
                                    .postCompOff(data, context, widget.fromDate,
                                        widget.toDate)
                                    .then((value) {
                                  setState(() {
                                    _dateTime = null;
                                    time_day = '';
                                    _time_day = '';
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height > 750
                      ? 20.h
                      : height < 650
                          ? 15.h
                          : 13.h,
                ),
                Container(
                  width: double.infinity,
                  height: SizeVariables.getHeight(context) * 0.2,
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                          child: Center(
                        child: Text(
                          'Comp Off to be applied in lieu of Leave/Holiday/Weekend that you have worked on. Please ensure that you have entered the time along with the reason.',
                          textAlign: TextAlign.center,
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
