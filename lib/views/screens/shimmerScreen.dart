import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/widgets/shimmerScreenWidgets/attendanceShimmer.dart';
import 'package:claimz/views/widgets/shimmerScreenWidgets/birthdayAndAnnouncementShimmer.dart';
import 'package:claimz/views/widgets/shimmerScreenWidgets/headerShimmer.dart';
import 'package:claimz/views/widgets/shimmerScreenWidgets/leaveShimmer.dart';
import 'package:claimz/views/widgets/shimmerScreenWidgets/toDoShimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/components/bottomNavigationBar.dart';
import '../../services/locationPermissions.dart';
import '../../viewModel/announcementViewModel.dart';
import '../../viewModel/claimsStatusViewModel.dart';
import '../../viewModel/claimzListViewModel.dart';
import '../../viewModel/leaveRemainingViewModel.dart';
import '../../viewModel/leaveRequestViewModel.dart';
import '../../viewModel/profileViewModel.dart';
import '../../viewModel/toDoViewModel.dart';
import '../../viewModel/toDoViewModel/todaysTask.dart';
import '../widgets/shimmerScreenWidgets/claimzStatusCardShimmer.dart';
import '../widgets/shimmerScreenWidgets/upcomingHolidayShimmer.dart';

class ShimmerScreen extends StatefulWidget {
  ShimmerScreenState createState() => ShimmerScreenState();
}

class ShimmerScreenState extends State<ShimmerScreen> {
  bool isLoading = true;
  dynamic? roleValue;

  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<LocationProvider>(context, listen: false).getDefaultAddress();

    roleValue = initialiseStorage();

    Provider.of<ToDoViewModel>(context, listen: false)
        .getAllToDoList()
        .then((_) {
      Provider.of<ClaimzListViewModel>(context, listen: false)
          .getClaimzList()
          .then((_) {
        Provider.of<LeaveRemainingViewModel>(context, listen: false)
            .getLeaveBalance()
            .then((value) {
          Provider.of<ClaimzStatusViewModel>(context, listen: false)
              .getClaimzStatuss()
              .then((value) {
            Provider.of<ProfileViewModel>(context, listen: false)
                .getProfileDetails()
                .then((value) {
              // Provider.of<LeaveRequestViewModel>(context, listen: false)
              //     .getLeaveRequest()
              //     .then((value) {
              Provider.of<TodaysTaskList>(context, listen: false)
                  .getTodaysTasks(roleValue == 1 ? 0 : 1)
                  .then((value) {
                Provider.of<AnnouncementViewModel>(context, listen: false)
                    .getAllAnouncements(
                        DateFormat('MMMM').format(DateTime.now()).toString(),
                        DateFormat('yyyy').format(DateTime.now()).toString())
                    .then((value) {
                  // setState(() {
                  //   isLoading = false;
                  // });
                  // await Future.delayed(Duration(seconds: 4));
                  Provider.of<LocationProvider>(context, listen: false)
                      .getLocation()
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomBottomNavigation(2)));
                  });
                });
              });
              // });
            });
          });
        });
      });
    });

    super.initState();
  }

  dynamic initialiseStorage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    return localStorage.getInt('role') == 1 ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: isLoading
            ? Container(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.025,
                  right: SizeVariables.getWidth(context) * 0.025,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    HeaderShimmer(),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    AttendanceShimmer(),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    ToDoShimmer(),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    BirthdayAndAnnouncementShimmer(),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    LeaveShimmer(),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    UpcomingHolidaysShimmerState(),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FittedBox(
                        //   fit: BoxFit.contain,
                        //   child: Text(
                        //     'Claimz Status',
                        //     // style: TextStyle(
                        //     //   fontSize: 30,
                        //     //   color: Colors.white,
                        //     // ),
                        //     style: Theme.of(context).textTheme.caption,
                        //   ),
                        // ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            height: SizeVariables.getHeight(context) * 0.04,
                            width: SizeVariables.getWidth(context) * 0.5,
                            margin: EdgeInsets.only(
                                bottom:
                                    SizeVariables.getHeight(context) * 0.008),
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          height: 140,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ClaimzStatusCardShimmer(
                                    title: "Lodged", number: 0),
                                ClaimzStatusCardShimmer(
                                    title: "Approved", number: 0),
                                ClaimzStatusCardShimmer(
                                    title: "Pre Audit", number: 0),
                                ClaimzStatusCardShimmer(
                                    title: "Processed", number: 0),
                                ClaimzStatusCardShimmer(
                                    title: "Paid", number: 0)
                              ]),
                        )
                      ],
                    ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                  ],
                ),
              )
            : Container());
  }
}
