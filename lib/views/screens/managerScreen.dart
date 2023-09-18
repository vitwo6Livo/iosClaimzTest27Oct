import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/viewModel/lateCheckinViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/regularisationRequestViewModel.dart';
import 'package:provider/provider.dart';

import '../config/mediaQuery.dart';

class ManagersScreen extends StatefulWidget {
  ManagersScreenState createState() => ManagersScreenState();
}

class ManagersScreenState extends State<ManagersScreen> {
  // final regularisationRequest = RegularisationRequestViewModel();

  List<Map<String, dynamic>> images = [
    // {
    //   "image": "assets/icons/attendance.svg",
    //   "name": "Attendance",
    //   "routes": RouteNames.managerAttendance,
    // },
    {
      "image": "assets/icons/leave request.svg",
      "name": "Leave Request",
      "routes": RouteNames.managerLeaveRequests,
    },
    {
      "image": "assets/icons/regularisation.svg",
      "name": "Regularisation",
      "routes": RouteNames.managerRegularizations,
    },
    {
      "image": "assets/icons/comp off.svg",
      "name": "Comp-off",
      "routes": RouteNames.managerCompOff,
    },
    {
      "image": "assets/icons/comp off.svg",
      "name": "Comp-off Leaves",
      "routes": RouteNames.managerCompOffApplications,
    },
    {
      "image": "assets/icons/workrole.svg",
      "name": "Attendance",
      "routes": RouteNames.atWork,
    },
    {
      "image": "assets/icons/permissions.svg",
      "name": "Permissions",
      "routes": RouteNames.workRole,
    },
    {
      "image": "assets/icons/Attendance-1.svg",
      "name": "Attendance",
      "routes": RouteNames.allEmployeeAttendance,
    },
    {
      "image": "assets/icons/Leave123.svg",
      "name": "Leave",
      "routes": RouteNames.allEmployeeLeave,
    },
    {
      "image": "assets/clamizFrom/flight.svg",
      "name": "Travel Claim",
      "routes": RouteNames.managerTravelClaim,

      // "routes": RouteNames.managerapproveclaims,
    },
    {
      "image": "assets/icons/conveynance.svg",
      "name": "Conveyance Claim",
      // "routes": RouteNames.claimchooseuserscreen,
      "routes": RouteNames.claimmanagerscreen,
    },
    {
      "image": "assets/icons/incidentals.svg",
      "name": "Incidental Expenses",
      "routes": RouteNames.managerIncidentalClaimsScreen,
    },
    {
      "image": "assets/icons/task list.svg",
      "name": "Logs",
      "routes": RouteNames.logsscreen,
    }

    // {
    //   "image": "assets/profilepage_img/tasklist.png",
    //   "name": "History",
    //   "routes": RouteNames.claimzfrom,
    // },
  ];

  List<String> name = [
    // "Attendance",
    "Leave",
    "Attendance",
    "Comp-off",
    'Comp-off Leaves',
    'At Work',
    'Permissions',
    'Attendance',
    'Leave',
    'Travel',
    'Conveyance',
    'Incidental Exp.',
    'Logs'
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   regularisationRequest.getRegularisationRequest();
  //   // lateCheckinViewModel.getLateCheckin(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        // color: Colors.green,
        height: height > 750
            ? 92.h
            : height < 650
                ? 133.h
                : 130.h,

        // color: Colors.redAccent,
        // height: double.infinity,
        child: ListView(
          //scrollDirection: Axis.vertical,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(
            //       top: SizeVariables.getHeight(context) * 0.01),
            //   child: Row(
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           // Navigator.of(context).pushNamed(RouteNames.navbar);
            //           Navigator.of(context).pop();
            //         },
            //         child: SvgPicture.asset(
            //           "assets/icons/back button.svg",
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(
            //           left: SizeVariables.getWidth(context)*0.01,
            //         ),
            //         child: FittedBox(
            //           fit: BoxFit.contain,
            //           child: Text(
            //             'My Menu',
            //             style: Theme.of(context).textTheme.caption,
            //           ),
            //         ),
            //       ),
            //       // ProfilededarWidget(),
            //     ],
            //   ),
            // ),

            SizedBox(height: SizeVariables.getHeight(context) * 0.01),
            Container(
              padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.18,
                right: SizeVariables.getWidth(context) * 0.18,
                bottom: SizeVariables.getHeight(context) * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.025,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Regularisations and Leaves',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // decoration: TextDecoration.underline,
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.004,
                                ),
                                Container(
                                  color: Color.fromARGB(255, 167, 162, 162),
                                  width: double.infinity,
                                  height:
                                      SizeVariables.getHeight(context) * 0.002,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.028,
                        ),
                        Container(
                          // color: Colors.amber,
                          // height: SizeVariables.getHeight(context) * 0.024.h,

                          width: SizeVariables.getWidth(context) * 0.7,
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 50,
                              mainAxisSpacing: 80,
                            ),
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[1]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[1]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[1],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[0]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  // color: Colors.amber,
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[0]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[0],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.007.h,
                  ),
                  Container(
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Comp-Off',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.004,
                            ),
                            Container(
                              color: Color.fromARGB(255, 167, 162, 162),
                              width: double.infinity,
                              height: SizeVariables.getHeight(context) * 0.002,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.026,
                        ),
                        Container(
                          // color: Colors.amber,
                          // height: SizeVariables.getHeight(context) * 0.024.h,
                          width: SizeVariables.getWidth(context) * 0.7,
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 50,
                              mainAxisSpacing: 80,
                            ),
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[2]["routes"]),
                                // onTap: () => Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             RequestLeave(false, ''))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            images[2]["image"],
                                          ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[2],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[3]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[3]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[3],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.008.h,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'My Team',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.004,
                            ),
                            Container(
                              color: Color.fromARGB(255, 167, 162, 162),
                              width: double.infinity,
                              height: SizeVariables.getHeight(context) * 0.002,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.028,
                        ),
                        Container(
                          // height: SizeVariables.getHeight(context) * 0.024.h,
                          width: SizeVariables.getWidth(context) * 0.7,
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 50,
                              mainAxisSpacing: 80,
                            ),
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[4]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[4]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[4],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[5]["routes"]),
                                child: ContainerStyle(
                                  height: SizeVariables.getHeight(context) *
                                      0.024.h,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(images[5]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          name[5],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        )
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
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.007.h,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.025,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Reports',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              // decoration: TextDecoration.underline,
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.004,
                                ),
                                Container(
                                  color: Color.fromARGB(255, 167, 162, 162),
                                  width: double.infinity,
                                  height:
                                      SizeVariables.getHeight(context) * 0.002,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.028,
                        ),
                        Container(
                          // color: Colors.amber,
                          // height: SizeVariables.getHeight(context) * 0.024.h,

                          width: SizeVariables.getWidth(context) * 0.7,
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 50,
                              mainAxisSpacing: 80,
                            ),
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[6]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            images[6]["image"],
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.054,
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.2,
                                          ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[6],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[7]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            images[7]["image"],
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.054,
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.2,
                                          ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[7],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: SizeVariables.getHeight(context) * 0.028,
                  // ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.007.h,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Claims',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.004,
                            ),
                            Container(
                              color: Color.fromARGB(255, 167, 162, 162),
                              width: double.infinity,
                              height: SizeVariables.getHeight(context) * 0.002,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        Container(
                          // height: SizeVariables.getHeight(context) *
                          //             0.065.h,
                          // color: Colors.amberAccent,
                          child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 50,
                              mainAxisSpacing: 50,
                            ),
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[11]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[11]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[11],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[8]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[8]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[8],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[9]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(images[9]["image"]),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[9],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, images[10]["routes"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: ContainerStyle(
                                    height: SizeVariables.getHeight(context) *
                                        0.024.h,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            images[10]["image"],
                                            height: 50,
                                            width: 30,
                                            color: Color(0xffF59F23),
                                          ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          Text(
                                            name[10],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   height: height > 800
            //       ? 95.h
            //       : height < 650
            //           ? 133.h
            //           : 130.h,
            //   // height: SizeVariables.getHeight(context) * 0.9,
            //   // color: Colors.amber,
            //   child: GridView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: images.length,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 50,
            //       mainAxisSpacing: 40,
            //     ),
            //     itemBuilder: (BuildContext context, int index) {
            //       return InkWell(
            //         onTap: () => index == 4
            //             ? Navigator.pushNamed(
            //                 context, images[index]["routes"])
            //             : Navigator.pushNamed(
            //                 context, images[index]["routes"]),
            //         child: Container(
            //           // color: Colors.red,
            //           child: ContainerStyle(
            //             height: SizeVariables.getHeight(context) * 0.5,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   SvgPicture.asset(images[index]["image"]),
            //                   SizedBox(
            //                       height: SizeVariables.getHeight(context) *
            //                           0.02),
            //                   Text(
            //                     name[index],
            //                     textAlign: TextAlign.center,
            //                     style: Theme.of(context).textTheme.bodyText1,
            //                   ),
            //                   // Text(
            //                   //   // '${value.managerView.data!.data!.length} Requests',
            //                   //   '8 Requests',
            //                   //   style: Theme.of(context).textTheme.bodyText1,
            //                   // ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
