import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/viewModel/reportingTreeViewModel.dart';
import 'package:claimz/views/screens/employee_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/routes/routeNames.dart';
import '../../../../viewModel/claimsStatusViewModel.dart';
import '../../../config/mediaQuery.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../res/components/buttonStyle.dart';
import '../../../../viewModel/attendanceViewModel.dart';
import '../../../../res/appUrl.dart';
import '../../../screens/hierarchy/atWorkListScreen.dart';
import '../../../screens/hierarchy/managersAtWorkListScreen.dart';
import './atWorkPieChart.dart';
import '../../../../models/dashboardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './atWorkManagerPieChart.dart';

class AtWork extends StatefulWidget {
  // final List<Attendance> attendaceViewModel;

  AtWorkState createState() => AtWorkState();
  // AtWork(this.attendaceViewModel);
}

class AtWorkState extends State<AtWork> {
  bool isLoading = true;
  int? role;
  int? id;

  @override
  void initState() {
    // TODO: implement initState
    checkRole().then((value) {
      if (role == 1) {
        print('Is A Manager');
        Provider.of<ReportingTreeViewModel>(context, listen: false)
            .getReportingTree(context, id!)
            .then((value) {
          setState(() {
            isLoading = false;
          });
        });
      } else {
        print('Is An Employee');

        Provider.of<ClaimzStatusViewModel>(context, listen: false)
            .getClaimzStatuss()
            .then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    });

    // Provider.of<ReportingTreeViewModel>(context, listen: false)
    //     .getReportingTree(context, 921)
    //     .then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    super.initState();
  }

  Future<void> checkRole() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    role = localStorage.getInt('role');
    id = localStorage.getInt('userId');
    print('Role: $role');
    print('UserIdddddddddddd: $id');
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;
    final listOfPresent = role == 1
        ? Provider.of<ReportingTreeViewModel>(context).present
        : Provider.of<ClaimzStatusViewModel>(context).presentEmployees;

    final listOfAbsent = role == 1
        ? Provider.of<ReportingTreeViewModel>(context).absent
        : Provider.of<ClaimzStatusViewModel>(context).absentEmployees;

    final listOfEmployessOnleave = role == 1
        ? Provider.of<ReportingTreeViewModel>(context).leave
        : Provider.of<ClaimzStatusViewModel>(context).onLeaveEmployees;

    final listOfCheckout = role == 1
        ? Provider.of<ReportingTreeViewModel>(context).checkedOut
        : Provider.of<ClaimzStatusViewModel>(context).checkedOutEmployees;

    final listOfEmployessOnWeekend = role == 1
        ? Provider.of<ReportingTreeViewModel>(context).weekEnd
        : Provider.of<ClaimzStatusViewModel>(context).weekendEmployees;

    final allEmployees =
        Provider.of<ClaimzStatusViewModel>(context).allEmployees;

    final managerEmployees = Provider.of<ReportingTreeViewModel>(context).all;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return ClipRRect(
        borderRadius:
            BorderRadius.circular(SizeVariables.getWidth(context) * 0.02),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            // color: Colors.red,
            height: height > 750
                ? 50.h
                : height < 650
                    ? 63.h
                    : 60.h,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: const Border(
                  bottom: BorderSide(width: 0.06),
                  top: BorderSide(width: 0.06),
                  right: BorderSide(width: 0.06),
                  left: BorderSide(width: 0.06)),
              // boxShadow: [
              //   BoxShadow(
              //       color: Color.fromARGB(255, 57, 57, 57),
              //       blurRadius: 15,
              //       spreadRadius: 1,
              //       offset: Offset(1, 2))
              // ]
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //color: Colors.red,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Who\'s at work today?',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height > 750
                      ? 0.005.h
                      : height < 650
                          ? 5.h
                          : 5.h,
                ),
                Container(
                  width: double.infinity,
                  height: height > 750
                      ? 41.h
                      : height < 650
                          ? 46.h
                          : 44.h,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      role == 1
                          ? InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ManagerAtWorkListScreen()));
                              },
                              child: Container(
                                  height: height > 750
                                      ? 35.h
                                      : height < 650
                                          ? 42.h
                                          : 32.h,
                                  width: double.infinity,
                                  // color: Colors.yellow,
                                  child: AtWorkManagerPie(
                                      // provider['data']['dashboard_data']['attendance']
                                      managerEmployees,
                                      isLoading)),
                            )
                          : Container(
                              height: height > 750
                                  ? 35.h
                                  : height < 650
                                      ? 42.h
                                      : 32.h,
                              width: double.infinity,
                              // color: Colors.yellow,
                              child: InkWell(
                                onTap: () {
                                  // print("Attendance.....");
                                  role == 1
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ManagerAtWorkListScreen()))
                                      : Navigator.pushNamed(
                                          context, RouteNames.atWorkList);
                                },
                                child: AtWorkPieChart(
                                    // provider['data']['dashboard_data']['attendance']
                                    allEmployees,
                                    isLoading),
                              ),
                            ),
                      Expanded(
                        child: Container(
                          // height: 400,
                          // width: double.infinity,
                          // color: Colors.pink,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EmployeeList(listOfPresent, role!)),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.green,
                                          size:
                                              SizeVariables.getWidth(context) *
                                                  0.06),
                                      SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.01),
                                      Text(
                                        'Present',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.04),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeList(
                                            listOfEmployessOnleave, role!)),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.blue,
                                          size:
                                              SizeVariables.getWidth(context) *
                                                  0.06),
                                      SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.01),
                                      Text(
                                        'On Leave',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.04),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeList(
                                            listOfCheckout, role!)),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.amber,
                                          size:
                                              SizeVariables.getWidth(context) *
                                                  0.06),
                                      SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.01),
                                      Text(
                                        'Checked Out',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.04),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EmployeeList(listOfAbsent, role!)),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.red,
                                          size:
                                              SizeVariables.getWidth(context) *
                                                  0.06),
                                      SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.01),
                                      Text(
                                        'Absent',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.04),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeList(
                                            listOfEmployessOnWeekend, role!)),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.circle,
                                          color: Colors.grey,
                                          size:
                                              SizeVariables.getWidth(context) *
                                                  0.06),
                                      SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.01),
                                      Text(
                                        'Weekend',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // SizedBox(
                              //     height: SizeVariables.getHeight(context) *
                              //         0.01),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
