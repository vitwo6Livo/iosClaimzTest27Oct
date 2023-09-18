import 'package:claimz/views/screens/employeeRecord/attendanceRecord.dart';
import 'package:claimz/views/screens/employeeRecord/regularizationRecord.dart';
import 'package:claimz/views/screens/employee_record_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../res/components/date_range_picker.dart';
import '../../../viewModel/leaveRequestViewModel.dart';
import '../../../viewModel/reportingTreeViewModel.dart';
import '../../config/mediaQuery.dart';
import '../hierarchy/managersAtWorkListScreen.dart';
import '../hierarchy/otherTreeScreen.dart';
import 'leaveRecord.dart';

class EmployeeRecordScreen extends StatefulWidget {
  final bool fromTeamMembers;
  final int id;
  final Map<String, dynamic> employeeRecord;
  final String month;
  final String year;
  final bool fromLeaveScreen;
  final String employeeName;
  final bool fromPendingLeaves;
  // final List<dynamic> leaveRecord;

  EmployeeRecordScreenState createState() => EmployeeRecordScreenState();

  EmployeeRecordScreen(
      this.fromTeamMembers,
      this.id,
      this.employeeRecord,
      this.month,
      this.year,
      this.fromLeaveScreen,
      this.employeeName,
      this.fromPendingLeaves
      // this.leaveRecord
      );
}

class EmployeeRecordScreenState extends State<EmployeeRecordScreen> {
  bool isLoading = true;
  var myMonth = DateFormat('MMMM').format(DateTime.now());
  var myYears = DateFormat('yyyy').format(DateTime.now());
  DateFormat secondMonthFormat = DateFormat('MMMM');
  DateFormat yearFormat = DateFormat('yyyy');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

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

  List<String> year = ["2022", "2021", "2020", "2019", "2018"];
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  @override
  void initState() {
    print('EMPLOYEEEEee ID: ${widget.employeeRecord['user']['id']}');
    print('EMPLOYEE RECORD: ${widget.employeeRecord}');
    print('IDDDDDDDDDDDDDDD: ${widget.id}');

    // TODO: implement initState
    Provider.of<ReportingTreeViewModel>(context, listen: false)
        .getRecords(
            widget.fromLeaveScreen == true && widget.fromTeamMembers == false
                ? widget.id
                : widget.fromTeamMembers == true
                    ? widget.employeeRecord['user']['id']
                    : widget.id,
            // widget.fromTeamMembers == true && widget.fromLeaveScreen == false
            //     ? widget.employeeRecord['user']['id']
            //     : widget.id,
            // ? widget.id
            // : widget.employeeRecord['user']['id'],
            widget.month,
            widget.year,
            context)
        .then((value) {
      Provider.of<LeaveRequestViewModel>(context, listen: false)
          .getLeaveRequest(dateFormat.format(dateRange.start),
              dateFormat.format(DateTime.now()))
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final provider = Provider.of<ReportingTreeViewModel>(context).report;
    final leaveProvider =
        Provider.of<LeaveRequestViewModel>(context).pendingLeaves;

    // TODO: implement build
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: widget.fromPendingLeaves == true ? 2 : 0,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                          onTap: () {
                            // Navigator.of(context).pop();
                            widget.fromPendingLeaves == true
                                ? Navigator.of(context).pop()
                                : widget.fromTeamMembers == true
                                    ? Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HierarchyScreen(widget.id)))
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManagerAtWorkListScreen()));
                          },
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
                              widget.fromLeaveScreen == true &&
                                      widget.fromTeamMembers == false
                                  ? '${widget.employeeName.split(' ')[0]}\'s Records'
                                  : '${widget.employeeRecord['user']['emp_name'].split(' ')[0]}\'s Records',
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
            bottom: const TabBar(
              indicatorColor: Colors.amber,
              tabs: [
                Tab(text: 'Attendance'),
                Tab(text: 'Regularisations'),
                Tab(text: 'Leaves'),
              ],
            ),
          ),
          body: isLoading
              ? Center(
                  //child: CircularProgressIndicator(),
                  child: EmployeeRecordShimmer(),
                )
              : TabBarView(
                  children: [
                    EmployeeAttendanceReport(provider),
                    EmployeeRegularisationReport(),
                    EmployeeLeaveReport(
                        widget.fromLeaveScreen,
                        dateFormat.format(dateRange.start),
                        dateFormat.format(DateTime.now())
                        // widget.leaveRecord
                        )
                  ],
                ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue,
                canvasColor: Colors.blue,
                colorScheme: const ColorScheme.light(primary: Colors.blue),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      isLoading = true;
    });

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    Provider.of<ReportingTreeViewModel>(context, listen: false)
        .getRecords(
            widget.employeeRecord['user']['id'],
            secondMonthFormat.format(dateRange.start).toString(),
            yearFormat.format(dateRange.start).toString(),
            context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    print('dateRange: $dateRange');
    return dateRange;
  }
}
