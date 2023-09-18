// import 'package:claimz/res/components/containerStyle.dart';

import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/attendance_report_body_shimmer.dart';
import 'package:claimz/views/screens/attendance_report_header_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../res/components/containerStyle.dart';
import '../../res/components/newAlertDialog.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/attendanceReportViewModel.dart';
import '../widgets/attendancereportWidget/compOff/compOffForm.dart';
import '../widgets/attendancereportWidget/reportWidget.dart';
import '../widgets/attendancereportWidget/reportheaderwidget.dart';
import '../widgets/attendancereportWidget/reporttable.dart';
import 'package:intl/intl.dart';

import 'regularisationScreen.dart';
import 'requestLeaveScreen.dart';
import 'package:provider/provider.dart';

class AttendanceReport extends StatefulWidget {
  // const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  var myYears = DateFormat('yyyy').format(DateTime.now());
  bool isLoading = true;
  DateFormat day = DateFormat('dd');
  DateFormat monthFormat = DateFormat('EEEE');
  DateFormat logInOutTime = DateFormat('HH:mm:ss');
  DateFormat secondMonthFormat = DateFormat('MMM');
  DateFormat yearFormat = DateFormat('yyyy');
  var myMonth = DateFormat('MMMM').format(DateTime.now());
  var selectedValue;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  var selectedDate;

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
    Provider.of<AttendanceReportViewModel>(context, listen: false)
        .getAttendanceReport(
            secondMonthFormat
                .format(DateTime.parse(DateTime.now().toString()).toLocal()),
            DateTime.now().year.toString())
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    // print('MONTH: $newMonth');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider =
        Provider.of<AttendanceReportViewModel>(context, listen: false)
            .attendanceReport;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final absentCount =
        Provider.of<AttendanceReportViewModel>(context, listen: false)
            .absentCount;

    print('DATE STARRRT: $start');
    print('DATE ENDDDDD: $end');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          padding: EdgeInsets.only(
            left: SizeVariables.getWidth(context) * 0.025,
            right: SizeVariables.getWidth(context) * 0.025,
          ),
          child: Column(
            children: [
              ReportHeader(),

              //Dropdowns Here

              Padding(
                padding: EdgeInsets.only(
                  // top: SizeVariables.getHeight(context) * 0.01,
                  left: SizeVariables.getWidth(context) * 0.05,
                  right: SizeVariables.getWidth(context) * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   child: Row(
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
                    //                       left:
                    //                           SizeVariables.getWidth(context) *
                    //                               0.03),
                    //                   child: Text(
                    //                     item,
                    //                     style: TextStyle(
                    //                         color:
                    //                             Theme.of(context).accentColor),
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
                    //             myYears = value!;
                    //             Map<String, dynamic> _data = {
                    //               'month': myMonth,
                    //               'year': myYears.toString()
                    //             };

                    //             Provider.of<AttendanceReportViewModel>(context,
                    //                     listen: false)
                    //                 .getAttendanceReport(myMonth, myYears)
                    //                 .then((_) {
                    //               setState(() {
                    //                 isLoading = false;
                    //               });
                    //             });

                    //             // Provider.of<AttendanceReportViewModel>(context, listen: false).getAttendanceReport(_data);
                    //             // setState(() {});
                    //           },
                    //           value: myYears,
                    //           items: year.map(
                    //             (item1) {
                    //               return DropdownMenuItem(
                    //                 value: item1,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.only(
                    //                       left:
                    //                           SizeVariables.getWidth(context) *
                    //                               0.02),
                    //                   child: Text(
                    //                     item1,
                    //                     style: TextStyle(
                    //                         color:
                    //                             Theme.of(context).accentColor),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ).toList(),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: SizeVariables.getWidth(context) * 0.8,
                      child: DateRangePicker(
                        onPressed: pickDateRange,
                        end: end,
                        start: start,
                        // width: double.infinity,
                      ),
                    ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Container(
                      // color: Colors.red,
                      child: ContainerStyle(
                        // height: SizeVariables.getHeight(context) * 0.15,
                        height: height > 800
                            ? 15.h
                            : height < 650
                                ? 16.h
                                : 18.h,
                        child: isLoading
                            ? AttendanceReportHeaderShimmer()
                            // ? Center(
                            //     child: Text(
                            //       'Select Period For Which To View Report',
                            //       style: Theme.of(context).textTheme.bodyText1,
                            //     ),
                            //   )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.03,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 9,
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            ' ${provider['count'][0]['present']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        18.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Present',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 8.sp),
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 9,
                                                          backgroundColor:
                                                              Colors.blue,
                                                        ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            ' ${provider['count'][0]['leave']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        18.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Leave',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 8.sp),
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 9,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  30,
                                                                  233,
                                                                  233),
                                                        ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            ' ${provider['count'][0]['holiday']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        18.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Holiday',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 8.sp),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.01,
                                      ),
                                      Container(
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18,
                                                          height: 18,
                                                          decoration:
                                                              const BoxDecoration(
                                                            // color: Colors.amber,
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.amber,
                                                            // gradient: LinearGradient(
                                                            //     begin: Alignment
                                                            //         .center,
                                                            //     end: Alignment(0.05, 0.004),
                                                            //     colors: [
                                                            //       Colors
                                                            //           .amber
                                                            //     ])
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            ' ${provider['count'][0]['halfday']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        18.sp),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Half Day',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 8.sp),
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 9,
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            ' ${provider['count'][0]['absent']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize:
                                                                      18.sp,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Absent',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 8.sp,
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          radius: 9,
                                                          backgroundColor:
                                                              Colors.grey,
                                                        ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            ' ${provider['count'][0]['weekend']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize:
                                                                      18.sp,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Weekend',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 8.sp,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.015,
              ),
              Expanded(
                child: Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.01,
                    // top: SizeVariables.getHeight(context) * 0.01,
                    right: SizeVariables.getWidth(context) * 0.01,
                  ),
                  child: isLoading
                      ? AttendanceReportBodyShimmer()
                      : ListView.builder(
                          // reverse: true,
                          itemBuilder: (context, index) => Column(
                            children: [
                              InkWell(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    content: Container(
                                      // height:
                                      //     SizeVariables.getHeight(context) *
                                      //         0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.green,
                                              ),
                                              // Text('Check In Address: ',
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .bodyText2!
                                              //         .copyWith(
                                              //             color:
                                              //                 Colors.black)),
                                              provider['data'][index]
                                                              ['address'] ==
                                                          null ||
                                                      provider['data'][index]
                                                              ['address'] ==
                                                          ''
                                                  ? Text('----',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black))
                                                  : Expanded(
                                                      // fit: BoxFit.contain,
                                                      child: Text(
                                                        provider['data'][index]
                                                            ['address'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.2,
                                              top: SizeVariables.getHeight(
                                                      context) *
                                                  0.006,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer_outlined,
                                                  color: Color(0xffF59F23),
                                                  size: 20,
                                                ),
                                                Text(
                                                  provider['data'][index][
                                                                  'created_at'] ==
                                                              null ||
                                                          provider['data']
                                                                      [index][
                                                                  'created_at'] ==
                                                              "" ||
                                                          provider['data']
                                                                      [index][
                                                                  'created_at'] ==
                                                              ''
                                                      ? '--:--:--'
                                                      : logInOutTime
                                                          .format(DateTime.parse(
                                                                  provider['data']
                                                                          [index]
                                                                      ['created_at'])
                                                              .toLocal())
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Color.fromARGB(
                                                        255, 88, 151, 91),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.red),
                                              provider['data'][index][
                                                              'checkout_address'] ==
                                                          null ||
                                                      provider['data'][index][
                                                              'checkout_address'] ==
                                                          ''
                                                  ? Text('----',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black))
                                                  : Expanded(
                                                      // fit: BoxFit.contain,
                                                      child: Text(
                                                        provider['data'][index][
                                                            'checkout_address'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.2,
                                              top: SizeVariables.getHeight(
                                                      context) *
                                                  0.006,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer_outlined,
                                                  color: Color(0xffF59F23),
                                                  size: 20,
                                                ),
                                                provider['data'][index][
                                                                'checkout_time'] ==
                                                            null ||
                                                        provider['data'][index][
                                                                'checkout_time'] ==
                                                            ""
                                                    ? Text('--:--:--',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.grey,
                                                            ))
                                                    : Text(
                                                        logInOutTime
                                                            .format(DateTime.parse(
                                                                    provider['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'checkout_time'])
                                                                .toLocal())
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              109,
                                                              99),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 11.sp,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Working Time: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                              Container(
                                                // color: Colors
                                                //     .green,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.av_timer,
                                                      color: Colors.black,
                                                      size: 17,
                                                    ),
                                                    SizedBox(
                                                      width: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.002,
                                                    ),
                                                    provider['data'][index][
                                                                    'checkout_time'] ==
                                                                "" ||
                                                            provider['data']
                                                                        [index][
                                                                    'checkout_time'] ==
                                                                null ||
                                                            provider['data']
                                                                        [index][
                                                                    'created_at'] ==
                                                                "" ||
                                                            provider['data']
                                                                        [index][
                                                                    'created_at'] ==
                                                                null
                                                        ? Padding(
                                                            padding: EdgeInsets.only(
                                                                left: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.002),
                                                            child: Text(
                                                              "--:--:--",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding: EdgeInsets.only(
                                                                left: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.002),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Container(
                                                                width: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.14,
                                                                // color: Colors.black,
                                                                child: Row(
                                                                  children: [
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        '${DateTime.parse(provider['data'][index]['checkout_time']).difference(DateTime.parse(provider['data'][index]['created_at'])).inHours}',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(
                                                                                fontSize: 15.sp,
                                                                                color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        'H',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                              color: Colors.black,
                                                                              fontSize: 12,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.015,
                                                                    ),
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        '${DateTime.parse(provider['data'][index]['checkout_time']).difference(DateTime.parse(provider['data'][index]['created_at'])).inMinutes % 60}',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(
                                                                                fontSize: 13.sp,
                                                                                color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        'm',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                                color: Colors.black,
                                                                                fontSize: 12),
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
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); //close Dialog
                                        },
                                        child: Text(
                                          'Close',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.033,
                                    right:
                                        SizeVariables.getWidth(context) * 0.03,
                                  ),
                                  child: Container(
                                    //color: Colors.red,
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
                                      height: SizeVariables.getHeight(context) *
                                          0.1,
                                      child: Container(
                                        height: double.infinity,
                                        // color: Colors.green,
                                        // padding: EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.02),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.02),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // width: SizeVariables.getWidth(context)*0.2,
                                                height: double.infinity,
                                                // color: Colors.pink,
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.02,
                                                    right:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.02),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        provider['data'][index][
                                                                    'attendance_status'] ==
                                                                0
                                                            ? const CircleAvatar(
                                                                radius: 8,
                                                                backgroundColor:
                                                                    Colors.red,
                                                              )
                                                            : provider['data'][index][
                                                                            'attendance_status'] ==
                                                                        1 &&
                                                                    provider['data'][index]
                                                                            [
                                                                            'half_day_status'] ==
                                                                        0
                                                                ?
                                                                // const CircleAvatar(
                                                                //     radius: 8,
                                                                //     backgroundColor:
                                                                //         Colors
                                                                //             .amber,
                                                                //   )
                                                                Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            // color: Colors.amber,
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            gradient:
                                                                                LinearGradient(begin: Alignment.center, end: Alignment(0.05, 0.004), colors: [
                                                                              Colors.amber,
                                                                              Colors.red
                                                                            ])),
                                                                  )
                                                                : provider['data'][index]['attendance_status'] ==
                                                                            1 &&
                                                                        provider['data'][index]['half_day_status'] ==
                                                                            1
                                                                    ? Container(
                                                                        width:
                                                                            16,
                                                                        height:
                                                                            16,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                                // color: Colors.amber,
                                                                                shape: BoxShape
                                                                                    .circle,
                                                                                gradient: LinearGradient(begin: Alignment.center, end: Alignment(0.05, 0.004), colors: [
                                                                                  Colors.amber,
                                                                                  Colors.blue
                                                                                ])),
                                                                      )
                                                                    : provider['data'][index]['attendance_status'] == 2
                                                                        ? const CircleAvatar(
                                                                            radius:
                                                                                8,
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                          )
                                                                        : provider['data'][index]['attendance_status'] == 3
                                                                            ? const CircleAvatar(
                                                                                radius: 8,
                                                                                backgroundColor: Color.fromARGB(255, 30, 233, 233),
                                                                              )
                                                                            : provider['data'][index]['attendance_status'] == 4
                                                                                ? const CircleAvatar(
                                                                                    radius: 8,
                                                                                    backgroundColor: Colors.blue,
                                                                                  )
                                                                                : const CircleAvatar(
                                                                                    radius: 8,
                                                                                    backgroundColor: Colors.grey,
                                                                                  ),
                                                        SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        Container(
                                                          // color: Colors.black,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                day.format(DateTime.parse(provider['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'created_at'])
                                                                    .toLocal()),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            30),
                                                              ),
                                                              // Text(
                                                              //   monthFormat.format(
                                                              //       DateTime.parse(provider['data']
                                                              //                   [
                                                              //                   index]
                                                              //               [
                                                              //               'created_at'])
                                                              //           .toLocal()),
                                                              //   style: Theme.of(
                                                              //           context)
                                                              //       .textTheme
                                                              //       .bodyText1,
                                                              // ),
                                                              Row(
                                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    secondMonthFormat.format(DateTime.parse(provider['data'][index]
                                                                            [
                                                                            'created_at'])
                                                                        .toLocal()),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            fontSize:
                                                                                10),
                                                                  ),
                                                                  SizedBox(
                                                                    width: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.01,
                                                                  ),
                                                                  Text(
                                                                    yearFormat.format(DateTime.parse(provider['data'][index]
                                                                            [
                                                                            'created_at'])
                                                                        .toLocal()),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            fontSize:
                                                                                10),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      // width: SizeVariables
                                                      //         .getWidth(
                                                      //             context) *
                                                      //     0.13,
                                                      child: Text(
                                                        monthFormat.format(DateTime
                                                                .parse(provider[
                                                                            'data']
                                                                        [index][
                                                                    'created_at'])
                                                            .toLocal()),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Container(
                                                  // color: Colors.green,
                                                  height: double.infinity,
                                                  // color: Color.fromARGB(
                                                  //     255, 0, 255, 8),
                                                  // color: Colors.red,
                                                  child: provider['data'][index]
                                                              [
                                                              'attendance_status'] ==
                                                          5
                                                      ? Center(
                                                          child: Row(
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment
                                                            //         .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Text('Weekend',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18)),
                                                              SizedBox(
                                                                  width: 20),
                                                              // Text('data')
                                                            ],
                                                          ),
                                                        )
                                                      : provider['data'][index][
                                                                  'attendance_status'] ==
                                                              0
                                                          ? Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text('Absent',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18)),
                                                                ],
                                                              ),
                                                            )
                                                          : provider['data']
                                                                          [index]
                                                                      ['attendance_status'] ==
                                                                  3
                                                              ? Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: const [
                                                                      Text(
                                                                          'Holiday',
                                                                          style:
                                                                              TextStyle(fontSize: 18)),
                                                                    ],
                                                                  ),
                                                                )
                                                              : provider['data'][index]['attendance_status'] == 4
                                                                  ? Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: const [
                                                                          Text(
                                                                              'Leave',
                                                                              style: TextStyle(fontSize: 18)),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : provider['data'][index]['attendance_status'] == 1 && provider['data'][index]['half_day_status'] == 1
                                                                      ? Center(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: const [
                                                                              Text('Half Day Leave', style: TextStyle(fontSize: 18)),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 1,
                                                                              fit: FlexFit.loose,
                                                                              child: Container(
                                                                                height: double.infinity,
                                                                                // color: Colors.blue,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.timer_outlined,
                                                                                      color: Color(0xffF59F23),
                                                                                      size: 20,
                                                                                    ),
                                                                                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                                                                                    const Icon(
                                                                                      Icons.timer_outlined,
                                                                                      color: Color(0xffF59F23),
                                                                                      size: 20,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 1,
                                                                              fit: FlexFit.tight,
                                                                              child: Container(
                                                                                height: double.infinity,
                                                                                // color: Colors.pink,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    provider['data'][index]['created_at'] == null || provider['data'][index]['created_at'] == ""
                                                                                        ? Text('--:--:--',
                                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                                  fontSize: 12.sp,
                                                                                                  color: Colors.grey,
                                                                                                ))
                                                                                        : Text(
                                                                                            logInOutTime.format(DateTime.parse(provider['data'][index]['created_at']).toLocal()).toString(),
                                                                                            style: TextStyle(
                                                                                              fontStyle: FontStyle.italic,
                                                                                              color: Color.fromARGB(255, 89, 172, 93),
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontSize: 11.sp,
                                                                                            ),
                                                                                          ),
                                                                                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                                                                                    provider['data'][index]['checkout_time'] == null || provider['data'][index]['checkout_time'] == ""
                                                                                        ? Text('--:--:--',
                                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                                  fontSize: 12.sp,
                                                                                                  color: Colors.grey,
                                                                                                ))
                                                                                        : Text(
                                                                                            logInOutTime.format(DateTime.parse(provider['data'][index]['checkout_time']).toLocal()).toString(),
                                                                                            style: TextStyle(
                                                                                              fontStyle: FontStyle.italic,
                                                                                              color: Color.fromARGB(255, 199, 88, 78),
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontSize: 11.sp,
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
                                                  // color: Colors.red,
                                                  height: double.infinity,
                                                  // color: Colors.blue,
                                                  padding: EdgeInsets.only(
                                                      right: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.02),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              // color: Colors.red,
                                                              child: provider['data'][index]['attendance_status'] == 0 ||
                                                                      provider['data'][index][
                                                                              'attendance_status'] ==
                                                                          3 ||
                                                                      provider['data'][index]
                                                                              [
                                                                              'attendance_status'] ==
                                                                          4 ||
                                                                      provider['data'][index]
                                                                              [
                                                                              'attendance_status'] ==
                                                                          5
                                                                  ? Container()
                                                                  : (provider['data'][index]
                                                                              [
                                                                              'compoff_status'] ==
                                                                          0)
                                                                      ? Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.av_timer,
                                                                              color: Colors.amber,
                                                                              size: 17,
                                                                            ),
                                                                            SizedBox(
                                                                              width: SizeVariables.getWidth(context) * 0.002,
                                                                            ),
                                                                            provider['data'][index]['checkout_time'] == "" || provider['data'][index]['checkout_time'] == null || provider['data'][index]['created_at'] == "" || provider['data'][index]['created_at'] == null
                                                                                ? Padding(
                                                                                    padding: EdgeInsets.only(left: SizeVariables.getHeight(context) * 0.002),
                                                                                    child: Text(
                                                                                      "--:--:--",
                                                                                      style: Theme.of(context).textTheme.bodyText1,
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: EdgeInsets.only(left: SizeVariables.getHeight(context) * 0.002),
                                                                                    child: Container(
                                                                                      width: SizeVariables.getWidth(context) * 0.1,
                                                                                      // color: Colors.black,
                                                                                      child: FittedBox(
                                                                                        fit: BoxFit.contain,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                '${DateTime.parse(provider['data'][index]['checkout_time']).difference(DateTime.parse(provider['data'][index]['created_at'])).inHours}',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11.sp),
                                                                                              ),
                                                                                            ),
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                'H',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber, fontSize: 12),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: SizeVariables.getWidth(context) * 0.015,
                                                                                            ),
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                '${DateTime.parse(provider['data'][index]['checkout_time']).difference(DateTime.parse(provider['data'][index]['created_at'])).inMinutes % 60}',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11.sp),
                                                                                              ),
                                                                                            ),
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                'm',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber, fontSize: 12),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        )
                                                                      : Text(
                                                                          'Comp-off'),
                                                            ),
                                                            provider['data']
                                                                                [index]
                                                                            [
                                                                            'attendance_status'] ==
                                                                        3 ||
                                                                    provider['data'][index]
                                                                            [
                                                                            'attendance_status'] ==
                                                                        4 ||
                                                                    provider['data'][index]
                                                                            [
                                                                            'attendance_status'] ==
                                                                        5
                                                                ? InkWell(
                                                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                                                        builder: (context) => CompoffForm(
                                                                            provider['data'][index]['created_at'],
                                                                            secondMonthFormat.format(DateTime.parse(DateTime.now().toString()).toLocal()),
                                                                            DateTime.now().year.toString()))),
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              SizeVariables.getWidth(context) * 0.05),
                                                                      child: Icon(
                                                                          Icons
                                                                              .arrow_forward_ios,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Theme.of(context).canvasColor),
                                                                    ),
                                                                  )
                                                                : InkWell(
                                                                    onTap: () =>
                                                                        print(
                                                                            'THIS IS CLICKED'),
                                                                    child:
                                                                        Container(
                                                                      // color: Colors
                                                                      //     .green,
                                                                      child:
                                                                          PopupMenuButton(
                                                                        icon: Icon(
                                                                            Icons
                                                                                .arrow_forward_ios,
                                                                            color:
                                                                                Theme.of(context).canvasColor),
                                                                        iconSize:
                                                                            15,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .secondary,
                                                                        itemBuilder:
                                                                            (context) =>
                                                                                [
                                                                          PopupMenuItem(
                                                                            value:
                                                                                1,
                                                                            child:
                                                                                Text('Regularise Attendance', style: Theme.of(context).textTheme.bodyText1!),
                                                                          ),
                                                                          PopupMenuItem(
                                                                            value:
                                                                                2,
                                                                            child:
                                                                                Text('Regularise Leave', style: Theme.of(context).textTheme.bodyText1!),
                                                                          )
                                                                        ],
                                                                        onSelected:
                                                                            (value) async {
                                                                          setState(
                                                                              () {
                                                                            selectedValue =
                                                                                value;
                                                                          });
                                                                          if (selectedValue ==
                                                                              1) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegularisationScreen(provider['data'][index]['created_at'])));
                                                                          } else {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestLeave(2, provider['data'][index]['created_at'], '', '', 0)));
                                                                          }
                                                                        },
                                                                        // child: const Icon(
                                                                        //     Icons
                                                                        //         .expand_more,
                                                                        //     color:
                                                                        //         Colors.white,
                                                                        //     size: 15),
                                                                      ),
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
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeVariables.getHeight(context) * 0.02,
                              )
                            ],
                          ),
                          itemCount: provider['data'].length,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      saveText: 'SET',
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xffF59F23),
            surface: Colors.black,
            onSurface: Colors.grey,
          ),
          dialogBackgroundColor: Color.fromARGB(255, 91, 91, 91),
        ),
        child: child!,
      ),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDateRange: dateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      isLoading = true;
    });

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    Provider.of<AttendanceReportViewModel>(context, listen: false)
        .getAttendanceReport(
            secondMonthFormat.format(dateRange.start).toString(),
            yearFormat.format(dateRange.start).toString())
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    print('dateRange: $dateRange');
    return dateRange;
  }
}
