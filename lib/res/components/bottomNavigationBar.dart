import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/leaveRequestViewModel.dart';
import 'package:claimz/views/screens/claimz_categoryScreen.dart';
import 'package:claimz/views/screens/menuscreen.dart';
import 'package:claimz/views/screens/shimmerScreen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import '../../viewModel/claimzHistoryViewModel.dart';
import '../../viewModel/compOffRequestViewModel.dart';
import '../../viewModel/managerIncidentalViewModel.dart';
import '../../viewModel/regularisationRequestViewModel.dart';
import '../../viewModel/toDoViewModel/todaysTask.dart';
import '../../views/screens/dashBoard.dart';
import '../../views/screens/leaveScreen.dart';
import '../../views/screens/leaveScreenShimmer.dart';
import '../../views/screens/paySlip.dart';
import '../../viewModel/attendanceReportViewModel.dart';
import '../../viewModel/announcementViewModel.dart';
import '../../viewModel/holidayViewModel.dart';
import '../../viewModel/leaveTypeViewModel.dart';
import '../../viewModel/toDoViewModel.dart';
import '../../viewModel/profileViewModel.dart';
import 'package:provider/provider.dart';
import '../../services/locationPermissions.dart';
import '../../views/screens/taskListScreen.dart';
import '../../viewModel/claimzListViewModel.dart';
import '../../viewModel/claimsStatusViewModel.dart';
import '../../viewModel/leaveRemainingViewModel.dart';
import 'package:intl/intl.dart';

import '../../views/widgets/dashboardWidgets/ratingPopup.dart';

class CustomBottomNavigation extends StatefulWidget {
  int selectedIndex;
  int notificationCounter = 0;

  CustomBottomNavigationState createState() => CustomBottomNavigationState();

  CustomBottomNavigation(this.selectedIndex);
}

class CustomBottomNavigationState extends State<CustomBottomNavigation> {
  bool isLoading = true;
  int? role;
  int notificationCounter = 0;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat secondMonthFormat = DateFormat('MMM');
  HomeButtonObserver? homeButtonObserver;
  bool? ratingClick;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  // int index = 2;

  Future<void> checkRole() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      role = localStorage.getInt('role');
    });

    print('NAVBARRRRRRRRR ROLE: $role');
  }

  Future<void> ratingSystem() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // Timer.periodic(
    //     const Duration(minutes: 1),
    //     (timer) => AlertDialog(
    //           content: const Text(
    //               'Please Take A Moment To Rate The Application And Share Your Feedback'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () => StoreRedirect.redirect(
    //                     androidAppId: 'com.claimz.claimz'),
    //                 child: const Text('Rate'))
    //           ],
    //         ));

    Timer(
        const Duration(days: 1),
        () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  // title: Text('Popup'),
                  content: const Text(
                      'Please Take A Moment To Rate The Application And Share Your Feedback'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        setState(() {
                          ratingClick = true;
                          localStorage.setBool('ratingClick', ratingClick!);
                        });

                        StoreRedirect.redirect(
                            androidAppId: 'com.claimz.claimz',
                            iOSAppId: 'com.claimz.claimz');

                        Navigator.of(context).pop();
                        // Navigator.of(context).pop(); // Pop the previous screen
                      },
                    ),
                  ],
                )));
  }

  @override
  void initState() {
    // TODO: implement initState

    checkRole().then((_) => ratingClick == null ? ratingSystem() : null);

    // if (role == 1) {
    //   Provider.of<LeaveRequestViewModel>(context, listen: false)
    //       .getLeaveRequest(dateFormat.format(dateRange.start),
    //           dateFormat.format(DateTime.now()))
    //       .then((value) {
    //     Provider.of<RegularisationRequestViewModel>(context, listen: false)
    //         .getRegularisationRequest(dateFormat.format(dateRange.start),
    //             dateFormat.format(DateTime.now()))
    //         .then((value) {
    //       Provider.of<CompOffManagerViewModel>(context, listen: false)
    //           .getManagerCompOffRequests(dateFormat.format(dateRange.start),
    //               dateFormat.format(DateTime.now()))
    //           .then((value) {
    //         Provider.of<CompOffManagerViewModel>(context, listen: false)
    //             .getManagerCompOffRequests(dateFormat.format(dateRange.start),
    //                 dateFormat.format(DateTime.now()))
    //             .then((value) {
    //           Provider.of<ManagerIncidentalViewModel>(context, listen: false)
    //               .getManagerIncidental(dateFormat.format(dateRange.start),
    //                   dateFormat.format(DateTime.now()))
    //               .then((value) {
    //             Provider.of<ClaimzHistoryViewModel>(context, listen: false)
    //                 .getClaimList({
    //               'from_date':
    //                   dateRange.start.toString().split(" ")[0].toString(),
    //               'all': 0,
    //               'to_date': dateRange.end.toString().split(" ")[0].toString(),
    //             }, context).then((value) {
    //               setState(() {
    //                 isLoading = false;
    //                 print(
    //                     'NOTIFICATION COUNTERRRRRRRRRRRRR: $notificationCounter');
    //                 print(
    //                     'PENDING LEAVE COUNTERRRRRRRRRRRRR: ${Provider.of<LeaveRequestViewModel>(context, listen: false).pendingLeaves.length}');
    //                 print(
    //                     'PENDING REGULARISATION COUNTERRRRRRRRRRRRR: ${Provider.of<RegularisationRequestViewModel>(context, listen: false).pendingRegularisation.length}');
    //                 print(
    //                     'PENDING COMP OFF COUNTERRRRRRRRRRRRR: ${Provider.of<CompOffManagerViewModel>(context, listen: false).pendingCompOffData.length}');
    //                 print(
    //                     'PENDING COMP OFF LEAVE COUNTERRRRRRRRRRRRR: ${Provider.of<CompOffManagerViewModel>(context, listen: false).pendingCompOffLeaveData.length}');
    //                 print(
    //                     'PENDING INCIDENTAL COUNTERRRRRRRRRRRRR: ${Provider.of<ManagerIncidentalViewModel>(context, listen: false).pending.length}');
    //               });
    //             });
    //           });
    //         });
    //       });
    //     });
    //   });
    // }

    // setState(() {
    //   notificationCounter = (Provider.of<LeaveRequestViewModel>(context,
    //                   listen: false)
    //               .pendingLeaves
    //               .length +
    //           Provider.of<RegularisationRequestViewModel>(context,
    //                   listen: false)
    //               .pendingRegularisation
    //               .length +
    //           Provider.of<CompOffManagerViewModel>(context, listen: false)
    //               .pendingCompOffData
    //               .length +
    //           Provider.of<CompOffManagerViewModel>(context, listen: false)
    //               .pendingCompOffLeaveData
    //               .length +
    //           Provider.of<ManagerIncidentalViewModel>(context, listen: false)
    //               .pending
    //               .length
    //       //     +
    //       // Provider.of<ClaimzHistoryViewModel>(context, listen: false)
    //       //     .claimList['data']
    //       //     .length
    //       ) as int;
    // });

    initDynamicLinks(context);
    super.initState();
  }

  void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink;
    // FirebaseDynamicLinks.instance.onLink(
    //     onSuccess: (PendingDynamicLinkData? dynamicLink) async {
    //   final Uri? deeplink = dynamicLink?.link;

    //   print("DEEPLINK>>>" + deeplink.toString());
    //   if (deeplink != null) {
    //     print("ROUTING...................");
    //     // print("deeplink data "+deeplink.queryParameters.values.first);
    //     Navigator.pop(context);
    //     Navigator.pushNamed(context, deeplink.queryParameters.values.last);
    //   }
    // }, onError: (e) async {
    //   print(e.message);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      SvgPicture.asset(
        "assets/icons/nav bar/menu.svg",
      ),

      SvgPicture.asset(
        "assets/icons/nav bar/leaves.svg",
      ),
      SvgPicture.asset(
        "assets/icons/nav bar/home.svg",
      ),
      SvgPicture.asset(
        "assets/icons/nav bar/task list.svg",
      ),
      SvgPicture.asset(
        "assets/icons/nav bar/reimbursement.svg",
      ),
      // Icon(Icons.menu, color: Colors.white),
      // Icon(Icons.calendar_month, color: Colors.white),
      // Icon(Icons.home, color: Colors.white),
      // Icon(Icons.money, color: Colors.white),
      // Icon(Icons.account_box, color: Colors.white)
    ];

    final screens = [
      MenuScreen(),
      LeaveScreen(),
      // TaskList(),
      HomeScreen(),
      // PaySlipScreen(),
      TaskList(false),

      Claimz_category(),
      // ClaimzScreen()
    ];

    // TODO: implement build
    return Scaffold(
      // body:
      //     // ? ShimmerScreen()
      //     isLoading ? ShimmerScreen() : screens[widget.selectedIndex],
      body: screens[widget.selectedIndex],
      extendBody: true,
      bottomNavigationBar: role == 1
          ? Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(200)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 10,
                        offset: Offset(1, 2))
                  ]),
              child: Stack(
                children: [
                  CurvedNavigationBar(
                      items: items,
                      index: widget.selectedIndex,
                      height: 60,
                      color: const Color.fromARGB(255, 70, 70, 70),
                      backgroundColor: Colors.transparent,
                      onTap: (index) => setState(() {
                            widget.selectedIndex = index;
                          })),
                  // Positioned(
                  //   left: 45,
                  //   top: 10,
                  //   child: Container(
                  //     width: 10,
                  //     height: 10,
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: Colors.redAccent),
                  //   ),
                  // )
                ],
              ))
          : Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(200)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 10,
                        offset: Offset(1, 2))
                  ]),
              child: Stack(
                children: [
                  CurvedNavigationBar(
                      items: items,
                      index: widget.selectedIndex,
                      height: 60,
                      color: const Color.fromARGB(255, 70, 70, 70),
                      backgroundColor: Colors.transparent,
                      onTap: (index) => setState(() {
                            widget.selectedIndex = index;
                          })),
                  Positioned(
                    left: 45,
                    top: 10,
                    child: Container(),
                  )
                ],
              )),
    );
  }
}
