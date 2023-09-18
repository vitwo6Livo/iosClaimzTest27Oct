import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../res/components/ExpandedListAnimationWidget.dart';
import '../../res/components/containerStyle.dart';
import '../../viewModel/attendanceReportViewModel.dart';
import '../config/mediaQuery.dart';

class AllEmployeeLeave extends StatefulWidget {
  AllEmployeeLeaveState createState() => AllEmployeeLeaveState();
}

class AllEmployeeLeaveState extends State<AllEmployeeLeave> {
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
        .getAllLeaveReport()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final start = dateRange.start;
    // final end = dateRange.end;
    final allLeaveProvider =
        Provider.of<AttendanceReportViewModel>(context).allLeaveReport;

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
                          'Leave Report',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   // color: Colors.amber,
              //   width: SizeVariables.getWidth(context) * 0.3,
              //   height: SizeVariables.getHeight(context) * 0.05,
              //   child: FittedBox(
              //     fit: BoxFit.contain,
              //     child: DateRangePicker(
              //       onPressed: pickDateRange,
              //       end: end,
              //       start: start,
              //       // width: double.infinity,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allLeaveProvider['data'].length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            allLeaveProvider['data'][index]['expanded'] =
                                !allLeaveProvider['data'][index]['expanded'];
                          });
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
                                      CircleAvatar(
                                        radius:
                                            SizeVariables.getHeight(context) *
                                                0.025,
                                        backgroundImage: const AssetImage(
                                          'assets/img/profilePic.jpg',
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Text(
                                        allLeaveProvider['data'][index]['name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: SizeVariables.getHeight(context) *
                                        0.0144,
                                    backgroundColor: Colors.green.shade400,
                                    child: Center(
                                      child: Text(
                                        allLeaveProvider['data'][index]['total']
                                            .toString(),
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
                      ),
                      ExpandedSection(
                        expand: allLeaveProvider['data'][index]['expanded'],
                        height: 110,
                        child: Container(
                          height: SizeVariables.getHeight(context) * 0.181,
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.02,
                            right: SizeVariables.getWidth(context) * 0.02,
                            top: SizeVariables.getHeight(context) * 0.02,
                          ),
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              crossAxisCount: 2,
                              childAspectRatio: 2.9,
                            ),
                            children: [
                              for (int i = 0;
                                  i <
                                      allLeaveProvider['data'][index]['leave']
                                          .length;
                                  i++)
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.068,
                                  width: SizeVariables.getWidth(context) * 0.4,
                                  decoration: BoxDecoration(
                                    color: Color(0xfffD9D9D9).withAlpha(30),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 160, 115, 52),
                                      width: 0.3,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xfffF59F23),
                                        radius:
                                            SizeVariables.getHeight(context) *
                                                0.018,
                                        child: Text(
                                          allLeaveProvider['data'][index]
                                                  ['leave'][i]['leave_balance']
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02,
                                      ),
                                      Text(
                                        allLeaveProvider['data'][index]['leave']
                                            [i]['leave_types'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 14,
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
        .getAllLeaveReport()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    print('dateRange: $dateRange');
    return dateRange;
  }
}
