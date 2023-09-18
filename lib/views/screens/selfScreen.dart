import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/requestLeaveNew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';

class SelfScreen extends StatefulWidget {
  SelfScreenState createState() => SelfScreenState();
  List<Map<String, dynamic>> images = [
    {
      "image": "assets/icons/attendance.svg",
      "name": "Attendance",
      "routes": RouteNames.attendancereport,
    },
    {
      "image": "assets/icons/leave request.svg",
      "name": "Leave Request",
      "routes": RouteNames.requestleave,
    },
    {
      "image": "assets/icons/regularisation.svg",
      "name": "Regularisations",
      "routes": RouteNames.viewRegularisations,
    },
    {
      "image": "assets/icons/comp off.svg",
      "name": "Comp-off",
      "routes": RouteNames.compoff,
    },
    {
      "image": "assets/icons/payslip.svg",
      "name": "Payslip",
      "routes": RouteNames.payslip,
    },
    {
      'image': 'assets/icons/admin.svg',
      'name': 'Managers',
      'routes': RouteNames.managerScreen
    },
    {
      "image": "assets/icons/organisation.svg",
      "name": "Organization",
      "routes": RouteNames.organization,
    },
    {
      "image": "assets/clamizFrom/flight.svg",
      "name": "Travel",
      "routes": RouteNames.travelClaimsList,
    },
    {
      "image": "assets/icons/conveynance.svg",
      "name": "Conveyance",
      "routes": RouteNames.claimzhistory,
    },
    {
      "image": "assets/icons/incidentals.svg",
      "name": "Incidental Screen",
      "routes": RouteNames.incidentalClaimsScreen,
    },
    {
      "image": "assets/icons/claimz.svg",
      "name": "All claims",
      "routes": RouteNames.claimzsummary_all,
    },
    {
      "image": "assets/icons/event.svg",
      "name": "Event",
      "routes": RouteNames.event,
    },
    {
      "image": "assets/icons/TDS-icon (1).svg",
      "name": "TDS",
      "routes": RouteNames.tds,
    },
    {
      "image": "assets/icons/TDS-icon (1).svg",
      "name": "Sales Order",
      "routes": RouteNames.salesorder,
    },
  ];

  List<String> name = [
    "Record",
    "Request",
    "Regularisations",
    "Comp-off",
    "Payslip",
    'Managers',
    "Organization",
    "Travel",
    "Conveyance",
    'Incidental',
    "All claims",
    "Event",
    "TDS",
    "Order",
  ];
}

class SelfScreenState extends State<SelfScreen> {
  int? role;

  @override
  void initState() {
    // TODO: implement initState
    initialise();
    super.initState();
  }

  void initialise() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      role = localStorage.getInt('role');
    });

    print('Role: $role');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: implement build
    return Container(
      // color: Colors.amber,
      // height: height > 750
      //     ? 60.h
      //     : height < 650
      //         ? 50.h
      //         : 53.h,
      child: ListView(
        children: [
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
                                    'Attendance',
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
                                  context, widget.images[0]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[0]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[0],
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
                                  context, widget.images[2]["routes"]),
                              child: Container(
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
                                        SvgPicture.asset(
                                            widget.images[2]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[2],
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
                                'Leave',
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
                              // onTap: () => Navigator.pushNamed(
                              //     context, widget.images[1]["routes"]),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RequestLeaveNew(),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                          widget.images[1]["image"],
                                        ),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[1],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, widget.images[3]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[3]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[3],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
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
                                'Payroll and Organization',
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
                                  context, widget.images[4]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[4]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[4],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, widget.images[6]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[6]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[6],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
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
                                'Event',
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
                                  context, widget.images[11]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[11]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[11],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
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
                Column(
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
                              'TDS',
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
                                context, widget.images[12]["routes"]),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: (themeProvider.darkTheme)
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          //offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                              ),
                              child: ContainerStyle(
                                height:
                                    SizeVariables.getHeight(context) * 0.024.h,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        widget.images[12]["image"],
                                        color: const Color(0xffF59F23),
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.06,
                                      ),
                                      SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.02),
                                      Text(
                                        widget.name[12],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
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
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.007.h,
                ),
                Column(
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
                              'Sales Order',
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
                                context, widget.images[13]["routes"]),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: (themeProvider.darkTheme)
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          //offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                              ),
                              child: ContainerStyle(
                                height:
                                    SizeVariables.getHeight(context) * 0.024.h,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        widget.images[13]["image"],
                                        color: const Color(0xffF59F23),
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.06,
                                      ),
                                      SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.02),
                                      Text(
                                        widget.name[13],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
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
                                  context, widget.images[7]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[7]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[7],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, widget.images[8]["routes"],
                                  arguments: true),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[8]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[8],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, widget.images[9]["routes"]),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: (themeProvider.darkTheme)
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            widget.images[9]["image"]),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.02),
                                        Text(
                                          widget.name[9],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, widget.images[10]["routes"]),
                              child: ContainerStyle(
                                height:
                                    SizeVariables.getHeight(context) * 0.024.h,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        widget.images[10]["image"],
                                        height: 50,
                                        width: 30,
                                        color: Color(0xffF59F23),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.02),
                                      Text(
                                        widget.name[10],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
