import 'package:claimz/services/locationPermissions.dart';
import 'package:claimz/viewModel/userViewModel.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/components/bottomNavigationBar.dart';
import '../utils/routes/route.dart';
import '../utils/routes/routeNames.dart';
import '../models/authenticationModel.dart';
import '../viewModel/announcementViewModel.dart';
import '../viewModel/attendanceReportViewModel.dart';
import '../viewModel/claimsStatusViewModel.dart';
import '../viewModel/claimzHistoryViewModel.dart';
import '../viewModel/claimzListViewModel.dart';
import '../viewModel/compOffRequestViewModel.dart';
import '../viewModel/leaveRemainingViewModel.dart';
import '../viewModel/leaveRequestViewModel.dart';
import '../viewModel/managerIncidentalViewModel.dart';
import '../viewModel/profileViewModel.dart';
import '../viewModel/regularisationRequestViewModel.dart';
import '../viewModel/toDoViewModel.dart';
import '../viewModel/toDoViewModel/todaysTask.dart';
import '../viewModel/userViewModel.dart';
import '../views/screens/attendancereportScreen.dart';

class SplashServices {
  Future<Data?> getToken() => UserViewModel().getUser();

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat secondMonthFormat = DateFormat('MMM');

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  void authenticate(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    getToken().then((value) async {
      if (value!.accessToken == 'null' || value.accessToken == '') {
        await Future.delayed(const Duration(seconds: 4));
        Navigator.pop(context);
        Navigator.pushNamed(context, RouteNames.intro);
      } else
      // if (value.role == 0)
      {
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
                  Provider.of<TodaysTaskList>(context, listen: false)
                      .getTodaysTasks(1)
                      .then((value) {
                    Provider.of<AnnouncementViewModel>(context, listen: false)
                        .getAllAnouncements(
                            DateFormat('MMMM')
                                .format(DateTime.now())
                                .toString(),
                            DateFormat('yyyy')
                                .format(DateTime.now())
                                .toString())
                        .then((value) {
                      Provider.of<LocationProvider>(context, listen: false)
                          .getLocation()
                          .then((value) {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomBottomNavigation(2)));
                      });
                    });
                  }); //Uncommit this to get All Announcements Working
                  // });
                });
              });
            });
          });
        });
      }
      // else {
      //   Provider.of<ToDoViewModel>(context, listen: false)
      //       .getAllToDoList()
      //       .then((_) {
      //     Provider.of<ClaimzListViewModel>(context, listen: false)
      //         .getClaimzList()
      //         .then((_) {
      //       Provider.of<LeaveRemainingViewModel>(context, listen: false)
      //           .getLeaveBalance()
      //           .then((value) {
      //         Provider.of<ClaimzStatusViewModel>(context, listen: false)
      //             .getClaimzStatuss()
      //             .then((value) {
      //           Provider.of<ProfileViewModel>(context, listen: false)
      //               .getProfileDetails()
      //               .then((value) {
      //             // Provider.of<LeaveRequestViewModel>(context, listen: false)
      //             //     .getLeaveRequest()
      //             //     .then((value) {
      //             Provider.of<TodaysTaskList>(context, listen: false)
      //                 .getTodaysTasks(
      //                     // localStorage.getInt('role') == 1 ? 0 :
      //                     1)
      //                 .then((value) {
      //               Provider.of<AnnouncementViewModel>(context, listen: false)
      //                   .getAllAnouncements(
      //                       DateFormat('MMMM')
      //                           .format(DateTime.now())
      //                           .toString(),
      //                       DateFormat('yyyy')
      //                           .format(DateTime.now())
      //                           .toString())
      //                   .then((value) {
      //                 // setState(() {
      //                 //   isLoading = false;
      //                 // });
      //                 // await Future.delayed(Duration(seconds: 4));
      //                 Provider.of<LocationProvider>(context, listen: false)
      //                     .getLocation()
      //                     .then((value) {
      //                   Provider.of<LeaveRequestViewModel>(context,
      //                           listen: false)
      //                       .getLeaveRequest(dateFormat.format(dateRange.start),
      //                           dateFormat.format(DateTime.now()))
      //                       .then((value) {
      //                     Provider.of<RegularisationRequestViewModel>(context,
      //                             listen: false)
      //                         .getRegularisationRequest(
      //                             dateFormat.format(dateRange.start),
      //                             dateFormat.format(DateTime.now()))
      //                         .then((value) {
      //                       Provider.of<CompOffManagerViewModel>(context,
      //                               listen: false)
      //                           .getManagerCompOffRequests(
      //                               dateFormat.format(dateRange.start),
      //                               dateFormat.format(DateTime.now()))
      //                           .then((value) {
      //                         Provider.of<CompOffManagerViewModel>(context,
      //                                 listen: false)
      //                             .getManagerCompOffRequests(
      //                                 dateFormat.format(dateRange.start),
      //                                 dateFormat.format(DateTime.now()))
      //                             .then((value) {
      //                           Provider.of<ManagerIncidentalViewModel>(context,
      //                                   listen: false)
      //                               .getManagerIncidental(
      //                                   dateFormat.format(dateRange.start),
      //                                   dateFormat.format(DateTime.now()))
      //                               .then((value) {
      //                             Provider.of<ClaimzHistoryViewModel>(context,
      //                                     listen: false)
      //                                 .getClaimList({
      //                               'from_date': dateRange.start
      //                                   .toString()
      //                                   .split(" ")[0]
      //                                   .toString(),
      //                               'all': 0,
      //                               'to_date': dateRange.end
      //                                   .toString()
      //                                   .split(" ")[0]
      //                                   .toString(),
      //                             }, context);
      //                           });
      //                         });
      //                       });
      //                     });
      //                   });

      //                   Navigator.pop(context);

      //                   //  Navigator.pushNamed(context, RouteNames.navbar);
      //                   Navigator.of(context).push(MaterialPageRoute(
      //                       builder: (context) => CustomBottomNavigation(2)));
      //                 });
      //               });
      //             });
      //             // });
      //           });
      //         });
      //       });
      //     });
      //   });
      // }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
