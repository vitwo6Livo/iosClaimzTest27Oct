import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/managerScreen.dart';
import 'package:claimz/views/screens/selfScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModel/attendanceReportViewModel.dart';
import '../../viewModel/leaveRequestViewModel.dart';

class MenuScreen extends StatefulWidget {
  MenuScreenState createState() => MenuScreenState();
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
      "name": "Regularisation",
      "routes": RouteNames.regularisation,
    },
    {
      "image": "assets/icons/comp off.svg",
      "name": "Comp-off",
      "routes": RouteNames.compoff,
    },
    {
      "image": "assets/icons/payslip.svg",
      "name": "Paysilp",
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
      "routes": RouteNames.claimzfrom,
    },
    {
      "image": "assets/icons/conveynance.svg",
      "name": "Convenyance",
      "routes": RouteNames.claimzhistory,
    },
    {
      "image": "assets/icons/conveynance.svg",
      "name": "Incidental Screen",
      "routes": RouteNames.incidentalClaimsScreen,
    },
  ];

  List<String> name = [
    "Record",
    "Request",
    "Regularisation",
    "Comp-off",
    "Payslip",
    'Managers',
    "Organization",
    "Travel",
    "Convenyance",
    'Incidental'
  ];

  // list<Map> data = {
  //   "doc_no": claimData[index].docNo.toString(),
  //   "from": claimData[index].tStartOriginAddress.toString(),
  //   "date": claimData[index].travelStartDate.toString(),
  //   "to": claimData[index].tEndOriginAddress.toString(),
  // };
}

class MenuScreenState extends State<MenuScreen> {
  int? role;
  bool isLoading = true;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat secondMonthFormat = DateFormat('MMM');

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

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
    // return Scaffold(
    //   backgroundColor: Color.fromARGB(94, 129, 128, 128),
    //   appBar: AppBar(
    //     elevation: 12,
    //     backgroundColor: Colors.black,
    //     shadowColor: Colors.grey,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         bottomLeft: Radius.circular(600),
    //         bottomRight: Radius.circular(50)
    //       )
    //     ),
    //     bottom: PreferredSize(
    //       child: SizedBox(),
    //       preferredSize: Size.fromHeight(150)),
    //   ),

    //   // body: ListView(
    //   //   children: [
    //   //     ClipPath(
    //   //       clipper: CurvedAppBar(),
    //   //       child: Container(
    //   //         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    //   //         height: SizeVariables.getHeight(context)*0.25,
    //   //         decoration: BoxDecoration(
    //   //         color: Colors.amber,
    //   //         ),
    //   //       ),
    //   //     ),
    //   //   ],
    //   // ),
    // );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: role == 1
            ? AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Theme.of(context)
                      .appBarTheme
                      .systemOverlayStyle
                      ?.statusBarColor,
                ),
                automaticallyImplyLeading: false,
                elevation: 1,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        'Menu',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ),
                bottom: const TabBar(indicatorColor: Colors.amber, tabs: [
                  Tab(text: 'Self'),
                  Tab(text: 'Team'),
                ]),
              )
            : AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                automaticallyImplyLeading: false,
                elevation: 1,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        'Menu',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ),
              ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: role == 1
            ? Center(
                child: TabBarView(
                  children: [
                    SelfScreen(),
                    // role == 1
                    //     ?
                    ManagersScreen()
                    // : Container(
                    //     // color: Colors.red,
                    //     child: Column(
                    //       children: [
                    //         Container(
                    //           height: 400,
                    //           width: 700,
                    //           child: Lottie.asset('assets/json/ToDo.json',
                    //               height: 250, width: 250),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              )
            : SelfScreen(),
      ),
    );
  }
}
