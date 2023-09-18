import 'package:claimz/res/components/claimz_status.dart';
import 'package:claimz/viewModel/profileViewModel.dart';
import 'package:claimz/views/widgets/dashboardWidgets/pieChart/leave_pie.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../notificationService/localNotification.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/attendanceViewModel.dart';
import '../../viewModel/claimzListViewModel.dart';
import '../../viewModel/dashboardAnnouncementViewModel.dart';
import '../../viewModel/leaveRemainingViewModel.dart';
import '../../viewModel/toDoViewModel.dart';
import '../../viewModel/toDoViewModel/todaysTask.dart';
import '../../viewModel/upcomingHolidaysViewModel.dart';
import '../config/mediaQuery.dart';
import '../widgets/dashboardWidgets/header.dart';
import '../widgets/dashboardWidgets/attendance.dart';
import '../widgets/dashboardWidgets/ratingPopup.dart';
import '../widgets/dashboardWidgets/toDoList/toDoListWidget.dart';
import '../widgets/dashboardWidgets/birthdayAndAnouncement.dart';
import '../widgets/dashboardWidgets/upcomingHolidays.dart';
import '../widgets/dashboardWidgets/atWorkWidget/atWork.dart';
import '../../viewModel/claimsStatusViewModel.dart';
import 'package:provider/provider.dart';
import '../../viewModel/onOffViewModel.dart';
import '../../viewModel/announcementViewModel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  AttendanceViewModel attendaceViewModel = AttendanceViewModel();
  ClaimzStatusViewModel claimzStatusViewModel = ClaimzStatusViewModel();
  OnOffViewModel onOffViewModel = OnOffViewModel();
  UpcomingHolidaysViewModel upcomingHolidaysViewModel =
      UpcomingHolidaysViewModel();
  DashboardAnnouncementViewModel dashboardAnnouncementViewModel =
      DashboardAnnouncementViewModel();

  bool isLoading = true;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(
              message, message.notification!.body);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(
              message, message.notification!.body);
        }
      },
    );
  }

  Future<void> refresh() async {
    // keyRefresh.currentState!.show();

    await Provider.of<ToDoViewModel>(context, listen: false).getAllToDoList();

    await Provider.of<ClaimzListViewModel>(context, listen: false)
        .getClaimzList();

    await Provider.of<LeaveRemainingViewModel>(context, listen: false)
        .getLeaveBalance();

    await Provider.of<ClaimzStatusViewModel>(context, listen: false)
        .getClaimzStatuss();

    await Provider.of<ProfileViewModel>(context, listen: false)
        .getProfileDetails();

    // await Provider.of<LeaveRequestViewModel>(context, listen: false)
    //     .getLeaveRequest();

    await Provider.of<TodaysTaskList>(context, listen: false).getTodaysTasks(
        // localStorage.getInt('role') == 1 ? 0 :
        1);

    await Provider.of<AnnouncementViewModel>(context, listen: false)
        .getAllAnouncements(
            DateFormat('MMMM').format(DateTime.now()).toString(),
            DateFormat('yyyy').format(DateTime.now()).toString());
    //     .then((_) {
    //   setState(() {
    //     Future.delayed(const Duration(milliseconds: 5000));
    //     keyRefresh.currentState!.show();
    //   });
    // });
    //     .then((value) {
    //   // setState(() {
    //   //   isLoading = false;
    //   // });
    //   // await Future.delayed(Duration(seconds: 4));
    //   Provider.of<LocationProvider>(context, listen: false)
    //       .getLocation()
    //       .then((value) {
    //     Navigator.pop(context);

    //     //  Navigator.pushNamed(context, RouteNames.navbar);
    //     Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => CustomBottomNavigation(2)));
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;
    final profileProvider =
        Provider.of<ProfileViewModel>(context).profileDetails;

    final checkinTime = Provider.of<ClaimzStatusViewModel>(context).checkinTime;
    final checkoutTime =
        Provider.of<ClaimzStatusViewModel>(context).checkoutTime;
    final checkinStatus =
        Provider.of<ClaimzStatusViewModel>(context).checkinStatus;
    final attendanceId =
        Provider.of<ClaimzStatusViewModel>(context).attendanceId;
    List<String> names = [];
    List<double> counts = [];

    for (int i = 0;
        i < provider["data"]["dashboard_data"]["claim_count"].length;
        i++) {
      if (names.contains(
          provider["data"]["dashboard_data"]["claim_count"][i]["key"])) {
        int index_name = names.indexOf(
            provider["data"]["dashboard_data"]["claim_count"][i]["key"]);
        counts[index_name] = double.parse(provider["data"]["dashboard_data"]
                    ["claim_count"][i]["value"]
                .toString()) +
            double.parse(counts[index_name].toString());
      } else {
        names.add(provider["data"]["dashboard_data"]["claim_count"][i]["key"]);
        counts.add(double.parse(provider["data"]["dashboard_data"]
                ["claim_count"][i]["value"]
            .toString()));
      }
    }

    print("DASH>>>" + names.toString());
    print(counts.toString());
    print(counts.reduce((a, b) => a + b));

    print('HEIGHT: ${SizeVariables.getHeight(context)}');
    print('WIDTH: ${SizeVariables.getWidth(context)}');

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: RefreshIndicator(
          onRefresh: refresh,
          color: Colors.amber,
          backgroundColor: Colors.white,
          child: Container(
              padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.025,
                right: SizeVariables.getWidth(context) * 0.025,
              ),
              // height: 44.0 + MediaQuery.of(context).padding.bottom,
              child: ListView(
                children: [
                  HeaderWidget(profileProvider['data']),
                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),

                  AttendanceWidget(provider['data']['dashboard_data'],
                      checkinTime, checkoutTime, checkinStatus, attendanceId),

                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                  ToDoList(),
                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),

                  BirthdayAndAnnouncement(profileProvider['data']),

                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                  // LeaveBalance(),s
                  LeavePie_card(),
                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),

                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.015,
                      left: SizeVariables.getWidth(context) * 0.04,
                    ),
                    child: FittedBox(
                      alignment: Alignment.topLeft,
                      fit: BoxFit.scaleDown,
                      child: InkWell(
                        // onTap: () async {
                        //   var data = await FlutterBackgroundService().isRunning();
                        //   if(!data){
                        //     FlutterBackgroundService().startService();
                        //     FlutterBackgroundService().invoke('start');
                        //   }
                        //   else{
                        //     FlutterBackgroundService().invoke('stop');
                        //   }
                        // },
                        child: Text(
                          'Claims Summary',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.green,
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: names.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.claimzsummary_all);
                        },
                        child: ClaimzStatus_card(
                          title: names[index],
                          number: counts[index].toInt(),
                          total: counts.reduce((a, b) => a + b).toInt(),
                        ),
                      ),
                      // ListView(scrollDirection: Axis.horizontal, children: [
                      //
                      //   ClaimzStatus_card(
                      //       title: "Approved",
                      //       number: provider['data']['dashboard_data']
                      //       ['approved_claim']),
                      //   ClaimzStatus_card(
                      //       title: "Pre Audit",
                      //       number: provider['data']['dashboard_data']
                      //       ['pre_audit']),
                      //   ClaimzStatus_card(
                      //       title: "Processed",
                      //       number: provider['data']['dashboard_data']
                      //       ['processed']),
                      //   ClaimzStatus_card(
                      //       title: "Paid",
                      //       number: provider['data']['dashboard_data']['paid'])
                      // ]),
                    ),
                  ),
                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                  UpcomingHolidays(),

                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                  AtWork(),
                  SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                ],
              )),
        ),
      ),
    );
  }
}
