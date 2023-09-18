import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../res/components/ExpandedListAnimationWidget.dart';
import '../../res/components/containerStyle.dart';
import '../../res/components/date_range_picker.dart';
import '../../viewModel/attendanceReportViewModel.dart';
import '../../viewModel/reportingTreeViewModel.dart';
import '../config/mediaQuery.dart';

class AllEmployeeAttendance extends StatefulWidget {
  AllEmployeeAttendanceState createState() => AllEmployeeAttendanceState();
}

class AllEmployeeAttendanceState extends State<AllEmployeeAttendance> {
  bool isLoading = true;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  DateFormat secondMonthFormat = DateFormat('MMM');
  DateFormat yearFormat = DateFormat('yyyy');

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AttendanceReportViewModel>(context, listen: false)
        .getAllAttendanceReport(
            secondMonthFormat
                .format(DateTime.parse(DateTime.now().toString()).toLocal()),
            DateTime.now().year.toString())
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool isStrechedDropDown = false;
    final start = dateRange.start;
    final end = dateRange.end;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final allAttendanceProvider =
        Provider.of<AttendanceReportViewModel>(context).allAttendanceReport;
    final provider = Provider.of<ReportingTreeViewModel>(context).report;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Container(
          // height: 400,
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                    SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                    Container(
                      width: SizeVariables.getWidth(context) * 0.4,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Attendance Report',
                          style: Theme.of(context).textTheme.caption,
                        ),
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
      // body: ,
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allAttendanceProvider['data'].length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            allAttendanceProvider['data'][index]['expanded'] =
                                !allAttendanceProvider['data'][index]
                                    ['expanded'];
                          });
                          // print(isStrechedDropDown);
                        },
                        child: ContainerStyle(
                          height: SizeVariables.getHeight(context) * 0.08,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.025,
                                right: SizeVariables.getWidth(context) * 0.025,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      allAttendanceProvider['data'][index]
                                                  ['user']['profile_photo'] ==
                                              null
                                          ? CircleAvatar(
                                              radius: SizeVariables.getWidth(
                                                      context) *
                                                  0.06,
                                              backgroundColor: Colors.green,
                                              backgroundImage: const AssetImage(
                                                  'assets/img/profilePic.jpg'),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  '${allAttendanceProvider['data'][index]['user']!['profile_photo']}',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: SizeVariables.getWidth(
                                                        context) *
                                                    0.06,
                                                backgroundColor: Colors.green,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor:
                                                    const Color.fromARGB(
                                                        255, 120, 120, 120),
                                                child: CircleAvatar(
                                                    radius:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.06),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                radius: SizeVariables.getWidth(
                                                        context) *
                                                    0.06,
                                                backgroundColor: Colors.green,
                                                backgroundImage: const AssetImage(
                                                    'assets/img/profilePic.jpg'),
                                              ),
                                            ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Text(
                                        allAttendanceProvider['data'][index]
                                            ['user']['emp_name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                    ],
                                  ),
                                  // CircleAvatar(
                                  //   backgroundColor: Colors.green,
                                  //   radius: SizeVariables.getHeight(context) *
                                  //       0.008,
                                  // ),

                                  // allAttendanceProvider['data'][index]
                                  //             ['attendance_status'] ==
                                  //         0
                                  //     ? const CircleAvatar(
                                  //         radius: 8,
                                  //         backgroundColor: Colors.red,
                                  //       )
                                  //     : allAttendanceProvider['data'][index]
                                  //                     ['attendance_status'] ==
                                  //                 1 &&
                                  //             allAttendanceProvider['data']
                                  //                         [index]
                                  //                     ['half_day_status'] ==
                                  //                 0
                                  //         ? Container(
                                  //             width: 16,
                                  //             height: 16,
                                  //             decoration: const BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               gradient: LinearGradient(
                                  //                 begin: Alignment.center,
                                  //                 end: Alignment(
                                  //                   0.05,
                                  //                   0.004,
                                  //                 ),
                                  //                 colors: [
                                  //                   Colors.amber,
                                  //                   Colors.red,
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           )
                                  //         : allAttendanceProvider['data'][index]['attendance_status'] ==
                                  //                     1 &&
                                  //                 allAttendanceProvider['data']
                                  //                             [index]
                                  //                         ['half_day_status'] ==
                                  //                     1
                                  //             ? Container(
                                  //                 width: 16,
                                  //                 height: 16,
                                  //                 decoration:
                                  //                     const BoxDecoration(
                                  //                   shape: BoxShape.circle,
                                  //                   gradient: LinearGradient(
                                  //                     begin: Alignment.center,
                                  //                     end: Alignment(
                                  //                       0.05,
                                  //                       0.004,
                                  //                     ),
                                  //                     colors: [
                                  //                       Colors.amber,
                                  //                       Colors.blue,
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             : allAttendanceProvider['data']
                                  //                             [index]
                                  //                         ['attendance_status'] ==
                                  //                     2
                                  //                 ? const CircleAvatar(
                                  //                     radius: 8,
                                  //                     backgroundColor:
                                  //                         Colors.green,
                                  //                   )
                                  //                 : allAttendanceProvider['data'][index]['attendance_status'] == 3
                                  //                     ? const CircleAvatar(
                                  //                         radius: 8,
                                  //                         backgroundColor:
                                  //                             Color.fromARGB(
                                  //                           255,
                                  //                           30,
                                  //                           233,
                                  //                           233,
                                  //                         ),
                                  //                       )
                                  //                     : allAttendanceProvider['data'][index]['attendance_status'] == 4
                                  //                         ? const CircleAvatar(
                                  //                             radius: 8,
                                  //                             backgroundColor:
                                  //                                 Colors.blue,
                                  //                           )
                                  //                         : const CircleAvatar(
                                  //                             radius: 8,
                                  //                             backgroundColor:
                                  //                                 Colors.grey,
                                  //                           ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ExpandedSection(
                        expand: allAttendanceProvider['data'][index]
                            ['expanded'],
                        height: 110,
                        child: Container(
                          height: SizeVariables.getHeight(context) * 0.14,
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.02,
                            top: SizeVariables.getHeight(context) * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: InkWell(
                                      // onTap: () {
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           EmployeeAttendanceReport(
                                      //               provider),
                                      //     ),
                                      //   );
                                      // },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeVariables.getHeight(
                                                    context) *
                                                0.017,
                                            backgroundColor: Colors.green,
                                            child: Center(
                                              child: Text(
                                                allAttendanceProvider['data']
                                                        [index]['present']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Present',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: InkWell(
                                      // onTap: () {
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           EmployeeAttendanceReport(
                                      //               provider),
                                      //     ),
                                      //   );
                                      // },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeVariables.getHeight(
                                                    context) *
                                                0.017,
                                            backgroundColor: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                allAttendanceProvider['data']
                                                        [index]['leaves']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Leave',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: InkWell(
                                      // onTap: () {
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           EmployeeAttendanceReport(
                                      //               provider),
                                      //     ),
                                      //   );
                                      // },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeVariables.getHeight(
                                                    context) *
                                                0.017,
                                            backgroundColor:
                                                const Color.fromARGB(
                                              255,
                                              30,
                                              233,
                                              233,
                                            ),
                                            child: Center(
                                              child: Text(
                                                allAttendanceProvider['data']
                                                        [index]['holidays']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Holiday',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeVariables.getHeight(context) * 0.02,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: InkWell(
                                      // onTap: () {
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           EmployeeAttendanceReport(
                                      //               provider),
                                      //     ),
                                      //   );
                                      // },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeVariables.getHeight(
                                                    context) *
                                                0.017,
                                            backgroundColor: Colors.amber,
                                            child: Center(
                                              child: Text(
                                                '0',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Half Day',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: InkWell(
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeVariables.getHeight(
                                                    context) *
                                                0.017,
                                            backgroundColor: Colors.red,
                                            child: Center(
                                              child: Text(
                                                allAttendanceProvider['data']
                                                        [index]['absent']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Absent',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: InkWell(
                                      // onTap: () {
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           EmployeeAttendanceReport(
                                      //               provider),
                                      //     ),
                                      //   );
                                      // },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeVariables.getHeight(
                                                    context) *
                                                0.017,
                                            backgroundColor: Colors.grey,
                                            child: Center(
                                              child: Text(
                                                allAttendanceProvider['data']
                                                        [index]['weekoff']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Weekend',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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

    // ignore: use_build_context_synchronously
    Provider.of<AttendanceReportViewModel>(context, listen: false)
        .getAllAttendanceReport(
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
