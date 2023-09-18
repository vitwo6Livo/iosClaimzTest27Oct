import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../res/components/buttonStyle.dart';
import '../../res/components/containerStyle.dart';
import '../../res/components/date_range_picker.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/compOffRequestViewModel.dart';
import '../config/mediaQuery.dart';
import '../../viewModel/compOffViewModel.dart';
import 'package:provider/provider.dart';

import 'attendance_report_body_shimmer.dart';
import 'comoffAdd.dart';

class CompoffScreen extends StatefulWidget {
  // const CompoffScreen({Key? key}) : super(key: key);

  @override
  State<CompoffScreen> createState() => _CompoffScreenState();
}

class _CompoffScreenState extends State<CompoffScreen> {
  // var myYears = "2022-08-09";
  // DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  DateTime? _dateTime;
  TimeOfDay timeFrom = TimeOfDay.now();
  String time_day = '';

  TimeOfDay _timeFrom = TimeOfDay.now();
  String _time_day = '';

  // final TextEditingController _textController = TextEditingController();

  var myYears1 = DateFormat('yyyy').format(DateTime.now());
  bool isLoading = true;
  DateFormat day = DateFormat('dd');
  DateFormat monthFormat = DateFormat('EEE');
  DateFormat logInOutTime = DateFormat('hh:mm:ss');
  DateFormat secondMonthFormat = DateFormat('MMMM');
  var myMonth = DateFormat('MMMM').format(DateTime.now());
  var selectedValue;

  // var myMonth = DateFormat('MMMM').format(DateTime.now());

  var myYears = DateFormat('yyyy').format(DateTime.now());

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, 4, 1),
    end: DateTime(DateTime.now().year + 1, 3, 31),
  );

  // var newMonth = DateFormat('MMMM').format(DateTime.now());

  List<String> month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> month_num = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

  List<String> year = ["2022", "2021", "2020", "2019", "2018"];

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CompOffManagerViewModel>(context, listen: false)
        .getCompOffRequests(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final provider = Provider.of<CompOffManagerViewModel>(context).userCompOff;
    final width = MediaQuery.of(context).size.width * 1;
    final start = dateRange.start;
    final end = dateRange.end;

    return Stack(
      children: [
        // Image.asset(
        //   "assets/img/bg.png",
        //   height: MediaQuery.of(context).size.height * 1,
        //   width: MediaQuery.of(context).size.width * 1,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: RippleAnimation(
            repeat: true,
            color: (themeProvider.darkTheme)
                ? Colors.grey
                : Theme.of(context).colorScheme.onPrimary,
            minRadius: 33,
            ripplesCount: 2,
            child: FloatingActionButton(
              child: Icon(Icons.add,
                  color:
                      (themeProvider.darkTheme) ? Colors.white : Colors.black),
              backgroundColor: (themeProvider.darkTheme)
                  ? Colors.grey
                  : Theme.of(context).colorScheme.onPrimary,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CompoffAdd(
                      dateFormat.format(dateRange.start),
                      dateFormat.format(DateTime.now())))),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                      top: SizeVariables.getHeight(context) * 0.01),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                              const FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Comp-Off List',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.amber,
                          width: SizeVariables.getWidth(context) * 0.3,
                          height: SizeVariables.getHeight(context) * 0.05,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: DateRangePicker(
                              onPressed: pickDateRange,
                              end: end,
                              start: start,
                              // width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // EdittaskHeader(),
                // SizedBox(
                //   height: SizeVariables.getHeight(context) * 0.03,
                // ),
                // // EdittaskContainer(),
                // Container(
                //   width: double.infinity,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Container(
                //         height: SizeVariables.getHeight(context) * 0.045,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(
                //             color: Colors.grey,
                //             width: 3,
                //           ),
                //         ),
                //         child: DropdownButton<String>(
                //           underline: Container(),
                //           iconSize: 30,
                //           icon: Icon(
                //             Icons.expand_more,
                //             color: Theme.of(context).accentColor,
                //           ),
                //           dropdownColor:
                //               Theme.of(context).colorScheme.secondary,
                //           onChanged: (value) {
                //             myMonth = value!;
                //             print(value);

                //             setState(() {});
                //           },
                //           value: myMonth,
                //           items: month.map((item) {
                //             return DropdownMenuItem(
                //                 value: item,
                //                 child: Padding(
                //                   padding: EdgeInsets.only(
                //                       left: SizeVariables.getWidth(context) *
                //                           0.03),
                //                   child: Text(
                //                     item,
                //                     style: TextStyle(
                //                         color: Theme.of(context).accentColor),
                //                   ),
                //                 ));
                //           }).toList(),
                //         ),
                //       ),
                //       SizedBox(
                //         width: SizeVariables.getWidth(context) * 0.14,
                //       ),
                //       Container(
                //         height: SizeVariables.getHeight(context) * 0.045,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(
                //             color: Colors.grey,
                //             width: 3,
                //           ),
                //         ),
                //         child: DropdownButton<String>(
                //           underline: Container(),
                //           iconSize: 30,
                //           icon: Icon(
                //             Icons.expand_more,
                //             color: Theme.of(context).accentColor,
                //           ),
                //           dropdownColor:
                //               Theme.of(context).colorScheme.secondary,
                //           onChanged: (value) {
                //             print(value);
                //             myYears1 = value!;
                //             Map<String, dynamic> _data = {
                //               'month': myMonth,
                //               'year': myYears1.toString()
                //             };

                //             // Provider.of<AttendanceReportViewModel>(context, listen: false).getAttendanceReport(_data);
                //             setState(() {});
                //           },
                //           value: myYears1,
                //           items: year.map((item1) {
                //             return DropdownMenuItem(
                //                 value: item1,
                //                 child: Padding(
                //                   padding: EdgeInsets.only(
                //                       left: SizeVariables.getWidth(context) *
                //                           0.02),
                //                   child: Text(
                //                     item1,
                //                     style: TextStyle(
                //                         color: Theme.of(context).accentColor),
                //                   ),
                //                 ));
                //           }).toList(),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.01),
                    child: Container(
                      height: SizeVariables.getHeight(context) * 0.8,
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.01,
                          top: SizeVariables.getHeight(context) * 0.01,
                          right: SizeVariables.getWidth(context) * 0.01),
                      child: isLoading
                          ? AttendanceReportBodyShimmer()
                          : ListView.builder(
                              itemBuilder: (context, index) => Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.033,
                                          right:
                                              SizeVariables.getWidth(context) *
                                                  0.03),
                                      child: Container(
                                        decoration: BoxDecoration(
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
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.1,
                                            child: Container(
                                              height: double.infinity,
                                              // color: Colors.green,
                                              // padding: EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.02),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.02),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: double.infinity,
                                                      // color: Colors.pink,
                                                      padding: EdgeInsets.only(
                                                          left: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.02,
                                                          right: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.02),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircleAvatar(
                                                              radius: 8,
                                                              backgroundColor:
                                                                  Colors.green),
                                                          SizedBox(
                                                              width: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.01),
                                                          Container(
                                                            // color: Colors.black,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(provider[
                                                                            'data']
                                                                        [index][
                                                                    'compoff_date'])
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        height: double.infinity,
                                                        // color: Color.fromARGB(
                                                        //     255, 0, 255, 8),
                                                        // color: Colors.red,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.loose,
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                // color: Colors.blue,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .timer_outlined,
                                                                      color: Color(
                                                                          0xffF59F23),
                                                                      size: 20,
                                                                    ),
                                                                    SizedBox(
                                                                        height: SizeVariables.getHeight(context) *
                                                                            0.02),
                                                                    const Icon(
                                                                      Icons
                                                                          .timer_outlined,
                                                                      color: Color(
                                                                          0xffF59F23),
                                                                      size: 20,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                // color: Colors.pink,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      provider['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'from_time'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            41,
                                                                            77,
                                                                            43),
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height: SizeVariables.getHeight(context) *
                                                                            0.02),
                                                                    Text(
                                                                      provider['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'to_time'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            96,
                                                                            38,
                                                                            33),
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            15,
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
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                          height:
                                                              double.infinity,
                                                          // color: Colors.blue,
                                                          padding: EdgeInsets.only(
                                                              right: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.02),
                                                          child: Center(
                                                            child: Text(
                                                                provider['data']
                                                                        [index]
                                                                    ['status'],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color: provider['data'][index]['status'] == 'Approved of Working Day' ||
                                                                                provider['data'][index]['status'] == 'Approved of Compoff Leaves'
                                                                            ? Colors.greenAccent
                                                                            : provider['data'][index]['status'] == 'Pending for Approval of Working Day' || provider['data'][index]['status'] == 'Pending for Approval of Compoff Leaves'
                                                                                ? Colors.amberAccent
                                                                                : Colors.redAccent)),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        SizeVariables.getHeight(context) * 0.02,
                                  )
                                ],
                              ),
                              itemCount: provider['data'].length,
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

    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Column(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(
    //             left: SizeVariables.getWidth(context) * 0.025,
    //             top: SizeVariables.getHeight(context) * 0.05),
    //         child: Container(
    //           child: Row(
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: SvgPicture.asset(
    //                   "assets/icons/back button.svg",
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: SizeVariables.getWidth(context)*0.02,
    //               ),
    //               FittedBox(
    //                 fit: BoxFit.contain,
    //                 child: Text(
    //                   'Comp-Off',
    //                   style: Theme.of(context).textTheme.caption,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Container(
    //         height: 600,
    //         child: AlertDialog(
    //           backgroundColor: Colors.black,
    //           content: ContainerStyle(
    //             height: SizeVariables.getHeight(context) * 0.25,
    //             child: Container(
    //               padding: EdgeInsets.only(
    //                   top: SizeVariables.getHeight(context) * 0.044),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   InkWell(
    //                     onTap: () {
    //                       showDatePicker(
    //                               context: context,
    //                               initialDate: DateTime.now(),
    //                               firstDate: DateTime(2010),
    //                               lastDate: DateTime.now()
    //                                   .add(const Duration(days: 365)))
    //                           .then((date) {
    //                         setState(() {
    //                           _dateTime = date;
    //                         });
    //                         print(
    //                             'Date Time: ${dateFormat.format(_dateTime!)}');
    //                       });
    //                     },
    //                     child: FittedBox(
    //                       fit: BoxFit.contain,
    //                       child: Text(
    //                         'Select Date',
    //                         style: Theme.of(context).textTheme.caption,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: SizeVariables.getHeight(context) * 0.003,
    //                   ),
    //                   InkWell(
    //                     onTap: () {
    //                       showDatePicker(
    //                               context: context,
    //                               initialDate: DateTime.now(),
    //                               firstDate: DateTime(2010),
    //                               lastDate: DateTime.now()
    //                                   .add(const Duration(days: 365)))
    //                           .then((date) {
    //                         setState(() {
    //                           _dateTime = date;
    //                         });
    //                         print(
    //                             'Date Time: ${dateFormat.format(_dateTime!)}');
    //                       });
    //                     },
    //                     child: FittedBox(
    //                       fit: BoxFit.contain,
    //                       child: Text(
    //                         _dateTime == null
    //                             ? 'Select Date'
    //                             : '${dateFormat.format(_dateTime!)}',
    //                         style: Theme.of(context).textTheme.bodyText1,
    //                       ),
    //                     ),
    //                   ),
    //                   Expanded(
    //                       child: Container(
    //                     width: double.infinity,
    //                     child: Row(
    //                       children: [
    //                         Flexible(
    //                           flex: 1,
    //                           fit: FlexFit.tight,
    //                           child: Container(
    //                             height: double.infinity,
    //                             // color: Colors.green,
    //                             child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    //                                 FittedBox(
    //                                   fit: BoxFit.contain,
    //                                   child: Text(
    //                                     'From Time',
    //                                     style: Theme.of(context)
    //                                         .textTheme
    //                                         .bodyText2,
    //                                   ),
    //                                 ),
    //                                 InkWell(
    //                                   onTap: () {
    //                                     showTimePicker(
    //                                       context: context,
    //                                       initialTime: timeFrom,
    //                                     ).then((value) {
    //                                       setState(() {
    //                                         timeFrom = value!;
    //                                         time_day = timeFrom.format(context);
    //                                         print(time_day);
    //                                       });
    //                                     });
    //                                   },
    //                                   child: Container(
    //                                     width: SizeVariables.getWidth(context) *
    //                                         0.3,
    //                                     // color: Colors.red,
    //                                     child: Center(
    //                                       child: Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         children: [
    //                                           InkWell(
    //                                             onTap: () {
    //                                               showTimePicker(
    //                                                 context: context,
    //                                                 initialTime: timeFrom,
    //                                               ).then((value) {
    //                                                 setState(() {
    //                                                   timeFrom = value!;
    //                                                   time_day = timeFrom
    //                                                       .format(context);
    //                                                   print(time_day);
    //                                                 });
    //                                               });
    //                                             },
    //                                             child: FittedBox(
    //                                               fit: BoxFit.contain,
    //                                               child: Text(
    //                                                 time_day == ''
    //                                                     ? 'From Time '
    //                                                     : ' $time_day',
    //                                                 style: Theme.of(context)
    //                                                     .textTheme
    //                                                     .bodyText1,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                         Flexible(
    //                           flex: 1,
    //                           fit: FlexFit.tight,
    //                           child: Container(
    //                             height: double.infinity,
    //                             // color: Colors.blue,
    //                             child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    //                                 InkWell(
    //                                   onTap: () {
    //                                     showTimePicker(
    //                                       context: context,
    //                                       initialTime: _timeFrom,
    //                                     ).then((value) {
    //                                       setState(() {
    //                                         _timeFrom = value!;
    //                                         _time_day =
    //                                             _timeFrom.format(context);
    //                                         print(_time_day);
    //                                       });
    //                                     });
    //                                   },
    //                                   child: FittedBox(
    //                                     fit: BoxFit.contain,
    //                                     child: Text(
    //                                       'To Time',
    //                                       style: Theme.of(context)
    //                                           .textTheme
    //                                           .bodyText2,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 InkWell(
    //                                   onTap: () {
    //                                     showTimePicker(
    //                                       context: context,
    //                                       initialTime: _timeFrom,
    //                                     ).then((value) {
    //                                       setState(() {
    //                                         _timeFrom = value!;
    //                                         _time_day =
    //                                             _timeFrom.format(context);
    //                                         print(_time_day);
    //                                       });
    //                                     });
    //                                   },
    //                                   child: Container(
    //                                     width: SizeVariables.getWidth(context) *
    //                                         0.3,
    //                                     child: Center(
    //                                       child: Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         children: [
    //                                           FittedBox(
    //                                             fit: BoxFit.contain,
    //                                             child: Text(
    //                                               _time_day == ''
    //                                                   ? 'To Time '
    //                                                   : ' $_time_day',
    //                                               style: Theme.of(context)
    //                                                   .textTheme
    //                                                   .bodyText1,
    //                                             ),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ))
    //                 ],
    //               ),
    //             ),
    //           ),
    //           actions: <Widget>[
    //             Center(
    //               child: Container(
    //                 height: SizeVariables.getHeight(context) * 0.044,
    //                 width: SizeVariables.getWidth(context) * 0.25,
    //                 child: AppButtonStyle(
    //                   label: 'Submit',
    //                   onPressed: () {
    //                     // Navigator.pushNamed(context, RouteNames.navbar);
    //                     if (kDebugMode) {
    //                       print(myYearsJoy);
    //                     }
    //                     Map<String, dynamic> data = {
    //                       'compoff_date': dateFormat.format(_dateTime!),
    //                       'from_time': time_day.toString(),
    //                       'to_time': _time_day.toString()
    //                     };
    //                     Provider.of<CompOffViewModel>(context, listen: false)
    //                         .postCompOff(data, context)
    //                         .then((value) {
    //                       setState(() {
    //                         _dateTime = null;
    //                         time_day = '';
    //                         _time_day = '';
    //                       });
    //                     });
    //                     // print(data);
    //                   },
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        saveText: "SET",
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xffF59F23),
                  surface: Colors.black,
                  onSurface: Colors.grey,
                ),
                dialogBackgroundColor: const Color.fromARGB(255, 91, 91, 91),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
    });

    var fromDate = dateFormat.format(dateRange.start);
    var toDate = dateFormat.format(dateRange.end);

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};
    Provider.of<CompOffManagerViewModel>(context, listen: false)
        .getCompOffRequests(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    print('dateRange re-selected: $dateRange');
    return dateRange;
  }
}
