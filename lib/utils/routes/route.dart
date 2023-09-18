import 'package:claimz/views/screens/accommodationScreen.dart';
import 'package:claimz/views/screens/announcementScreen.dart';
import 'package:claimz/views/screens/approvalPending.dart';
import 'package:claimz/views/screens/eventScreen.dart';
import 'package:claimz/views/screens/hierarchy/atWorkListScreen.dart';
import 'package:claimz/views/screens/busScreen.dart';
import 'package:claimz/views/screens/cabScreen.dart';
import 'package:claimz/views/screens/claimzFrom.dart';
import 'package:claimz/views/screens/claimzListShow.dart';
import 'package:claimz/views/screens/claimzManagerUserChoose.dart';
import 'package:claimz/views/screens/claimz_categoryScreen.dart';
import 'package:claimz/views/screens/compoffScreen.dart';
import 'package:claimz/views/screens/edittaskScreen.dart';
import 'package:claimz/views/screens/flightScreen.dart';
import 'package:claimz/views/screens/foodScreen.dart';
import 'package:claimz/views/screens/incidentalClaimsScreen.dart';
import 'package:claimz/views/screens/incidentalScreen.dart';
import 'package:claimz/views/screens/loginScreen.dart';
import 'package:claimz/views/screens/logs/conveyance/conveynancelogview.dart';
import 'package:claimz/views/screens/logs/conveyance/conyeyanceloglist.dart';
import 'package:claimz/views/screens/logs/incidental/incidentallist.dart';
import 'package:claimz/views/screens/logs/incidental/incidentalview.dart';
import 'package:claimz/views/screens/logs/logscreen.dart';
import 'package:claimz/views/screens/logs/travel/travellist.dart';
import 'package:claimz/views/screens/logs/travel/travelview.dart';
import 'package:claimz/views/screens/managertravelClaimList.dart';
import 'package:claimz/views/screens/managertravelStatusList.dart';
import 'package:claimz/views/screens/otpScreen.dart';
import 'package:claimz/views/screens/profileScreen.dart';
import 'package:claimz/views/screens/requestLeaveScreen.dart';
import 'package:claimz/views/screens/taskAddScreen.dart';
import 'package:claimz/views/screens/ticketHistory.dart';
import 'package:claimz/views/screens/ticketManu.dart';
import 'package:claimz/views/screens/ticketScreen.dart';

import 'package:claimz/views/screens/trainScreen.dart';
import 'package:claimz/views/screens/travelClaimForm.dart';
import 'package:claimz/views/screens/travelClaimList.dart';
import 'package:claimz/views/screens/travelClaimListShimmer.dart';
import 'package:claimz/views/screens/travelStatusList.dart';

import 'package:claimz/views/widgets/managerScreenWidgets/attendanceManager.dart';

import 'package:claimz/views/widgets/managerScreenWidgets/leaveRequest/leaveRequestManager.dart';
import 'package:claimz/views/widgets/managerScreenWidgets/regularizations/regularizationManager.dart';

// import 'package:claimz/views/widgets/managerScreenWidgets/leaveRequestManager.dart';
// import 'package:claimz/views/widgets/managerScreenWidgets/regularizationManager.dart';

import 'package:flutter/material.dart';
import '../../res/components/bottomNavigationBar.dart';
import '../../viewModel/toDoViewModel/completedTaskList.dart';
import '../../viewModel/toDoViewModel/tasksViewModel.dart';
import '../../views/screens/allEmployeeAttendance.dart';
import '../../views/screens/allEmployeeLeave.dart';
import '../../views/screens/holidays/allUpcomingHolidayList.dart';
import '../../views/screens/atWorkListMenu.dart';
import '../../views/screens/attendancereportScreen.dart';
import '../../views/screens/attendaneScreen.dart';
import '../../views/screens/birthdayWish.dart';
import '../../views/screens/changepassScreen.dart';
import '../../views/screens/claimzHistory/claimzHistory.dart';
import '../../views/screens/claimzHistory/convenyanceClaimFrom.dart';
import '../../views/screens/claimzHistory/managerConvenyanceClaim.dart';
import '../../views/screens/claimzScreen.dart';
import '../../views/screens/claimzsummary_all_Screen.dart';
import '../../views/screens/comoffAdd.dart';
import '../../views/screens/dashBoard.dart';
import '../../views/screens/domesticListScreen.dart';
import '../../views/screens/claimzHistory/historyClaimList.dart';
import '../../views/screens/hierarchy/managersAtWorkListScreen.dart';
import '../../views/screens/incidentalExpenseScreen.dart';
import '../../views/screens/introScreen.dart';
import '../../views/screens/lateCheckInRequests.dart';
import '../../views/screens/leaveList.dart';
import '../../views/screens/leaveScreen.dart';
import '../../views/screens/managerApprovClaim.dart';
import '../../views/screens/managerCompOffList.dart';
import '../../views/screens/managerIncidentalScreen/managerIncidental.dart';
import '../../views/screens/managerScreen.dart';
import '../../views/screens/menuscreen.dart';
import '../../views/screens/notificationList.dart';
import '../../views/screens/organizationScreen.dart';
import '../../views/screens/paySlip.dart';
import '../../views/screens/regularisationScreen.dart';
import '../../views/screens/salesOrder/salesOrder_Screen.dart';
import '../../views/screens/signup/kycdetails_Screen.dart';
import '../../views/screens/signup/signup_Screen.dart';
import '../../views/screens/signup/signupdetails_Screen.dart';
import '../../views/screens/taskCompleteScreen.dart';
import '../../views/screens/taskEditScreen.dart';
import '../../views/screens/tasklistScreen.dart';
import '../../views/screens/tds/investment_upload.dart';
import '../../views/screens/tds/tds_Screen.dart';
import '../../views/screens/themeScreen.dart';
import '../../views/screens/ticketHistoryscroll.dart';
import '../../views/screens/viewRegularisations.dart';
import '../../views/widgets/announcementWidget/managerAnnouncement.dart';
import '../../views/widgets/claimzfromWidget/claimzContainer.dart';
import '../../views/widgets/dashboardWidgets/atWorkWidget/atWork.dart';
import '../../views/widgets/managerScreenWidgets/claimManager/claimManagerScreen.dart';
import '../../views/widgets/managerScreenWidgets/workRole.dart';
import '../../views/widgets/edittaskWidget/edittaskHeader.dart';
import '../../views/widgets/managerScreenWidgets/compOff/compOffManager.dart';
import '../../views/widgets/organizationWidget/organisationList.dart';
import '../../views/widgets/organizationWidget/organizationDetails.dart';
import '../../views/widgets/organizationWidget/organizationNewList.dart';
import './routeNames.dart';
import '../../views/screens/splashScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.intro:
        return MaterialPageRoute(
            builder: (BuildContext context) => IntroScreen(false));

      case RouteNames.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RouteNames.claimz_category:
        return MaterialPageRoute(
            builder: (BuildContext context) => Claimz_category());

      case RouteNames.ticketmanu:
        return MaterialPageRoute(
            builder: (BuildContext context) => TicketManu());

      case RouteNames.dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RouteNames.claimzfrom:
        return MaterialPageRoute(
          builder: (BuildContext context) => ClaimzFrom(
            // not use
            claimzId: '',
            docId: '',
          ),
        );

      case RouteNames.attendance:
        return MaterialPageRoute(
            builder: (BuildContext context) => AttendanceScreen());

      case RouteNames.menu:
        return MaterialPageRoute(
            builder: (BuildContext context) => MenuScreen());

      case RouteNames.leave:
        return MaterialPageRoute(
            builder: (BuildContext context) => LeaveScreen());

      case RouteNames.payslip:
        return MaterialPageRoute(
            builder: (BuildContext context) => PaySlipScreen());

      case RouteNames.claimz:
        return MaterialPageRoute(
            builder: (BuildContext context) => ClaimzScreen()); // not use

      case RouteNames.attendancereport:
        return MaterialPageRoute(
            builder: (BuildContext context) => AttendanceReport());

      // case RouteNames.tasklist:
      //   return MaterialPageRoute(builder: (BuildContext context) => TaskList());

      case RouteNames.changepassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChangePassword());

      case RouteNames.taskedit:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditTaskS()); // not use

      // case RouteNames.requestleave:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => RequestLeave(settings.arguments));

      case RouteNames.addtask:
        return MaterialPageRoute(
            builder: (BuildContext context) => TaskAdd()); // not use

      case RouteNames.edittask:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditTask()); // not use

      case RouteNames.regularisation:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                RegularisationScreen(settings.arguments as String));

      case RouteNames.claimzhistory:
        return MaterialPageRoute(
            builder: (BuildContext context) => ClaimzHistory());

      case RouteNames.flightscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                FlightScreen(settings.arguments as Map)); // not use

      case RouteNames.approvalpending:
        return MaterialPageRoute(
            builder: (BuildContext context) => ApprovalPending()); // not use

      case RouteNames.announcementscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => AnnouncementScreen());

      case RouteNames.compoff:
        return MaterialPageRoute(
            builder: (BuildContext context) => CompoffScreen());

      case RouteNames.taskcomplete:
        return MaterialPageRoute(
            builder: (BuildContext context) => TaskComplete());

      case RouteNames.upcomingHoldayList:
        return MaterialPageRoute(
          builder: (BuildContext context) => AllUpcomingHolidayList(),
        );

      case RouteNames.claimzsummary_all:
        return MaterialPageRoute(
          builder: (BuildContext context) => Claimzsummary_all_Screen(),
        );

      case RouteNames.atWorkList:
        return MaterialPageRoute(
          builder: (BuildContext context) => AtWorkListScreen(),
        );
      case RouteNames.ticketscreen:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              TicketScreen(settings.arguments as Map<String, dynamic>),
        );

      // case RouteNames.compoffAdd:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => CompoffAdd(),
      //   );

      case RouteNames.trainscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => TrainScreen()); // not use

      case RouteNames.busscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => BusScreen()); // not use

      case RouteNames.cabscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => CabScreen()); // not use

      case RouteNames.accommodationscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                AccommodationScreen()); // not use

      case RouteNames.foodscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => FoodScreen()); // not use

      case RouteNames.incidentalscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => IncidentalScreen()); // not use

      case RouteNames.managerScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ManagersScreen());

      case RouteNames.managerAttendance:
        return MaterialPageRoute(
            builder: (BuildContext context) => ManagerAttendance()); // not use

      case RouteNames.managerLeaveRequests:
        return MaterialPageRoute(
            builder: (BuildContext context) => LeaveRequestManager());

      case RouteNames.managerRegularizations:
        return MaterialPageRoute(
            builder: (BuildContext context) => ManagerRegularizations());

      case RouteNames.claimmanagerscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ClaimManagerScreen(
                // settings.arguments as Map
                ));
      // ClaimManagerScreen());

      case RouteNames.organisationlist:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                OrganisationList(settings.arguments as Map<String, dynamic>));

      case RouteNames.incidentalClaimsFormScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => IncidentalClaimsScreen());

      case RouteNames.managerCompOff:
        return MaterialPageRoute(
            builder: (BuildContext context) => ManagerCompOff());

      case RouteNames.leavelist:
        return MaterialPageRoute(
            builder: (BuildContext context) => LeaveList()); // not use

      case RouteNames.organization:
        return MaterialPageRoute(
            builder: (BuildContext context) => OrganizationScreen());

      // case RouteNames.proflieinfo:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => ProfileInfoScreen());

      case RouteNames.lateCheckIn:
        return MaterialPageRoute(
          builder: (BuildContext context) => LateCheckinRequests(),
        );

      case RouteNames.workRole:
        return MaterialPageRoute(builder: (BuildContext context) => WorkRole());

      // case RouteNames.tickethistory:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => TicketHistroy());

      case RouteNames.claimchooseuserscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                claimzManagerUserChooseScreen()); // no understand

      case RouteNames.incidentalClaimsScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => IncidentalExpenseScreen());

      case RouteNames.otpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                OtpScreen(settings.arguments as String));

      case RouteNames.managerIncidentalClaimsScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ManagerIncidentalExpenseScreen());

      case RouteNames.travelClaimsList:
        return MaterialPageRoute(
            builder: (BuildContext context) => TravelClaimList());
      case RouteNames.travelClaimsForm:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                TravelClaimForm(settings.arguments as Map));
      case RouteNames.travelStatusList:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                TravelStatusList(settings.arguments as Map)); // not understand
      case RouteNames.postAnnouncement:
        return MaterialPageRoute(
            builder: (BuildContext context) => ManagerAnnouncementScreen());

      case RouteNames.fieldfrom:
        return MaterialPageRoute(
            builder: (BuildContext context) => ClaimzlistShow(
                settings.arguments as Map<String, dynamic>)); // not understand

      case RouteNames.viewRegularisations:
        return MaterialPageRoute(
          builder: (context) => ViewRegularisations(),
        );

      case RouteNames.managerTravelClaim:
        return MaterialPageRoute(
          builder: (context) => ManagerTravelClaimList(),
        );

      case RouteNames.themescreen:
        return MaterialPageRoute(
          builder: (context) => ThemeScreen(),
        );

      case RouteNames.managerconvenyanceclaim:
        return MaterialPageRoute(
          builder: (context) => ManagerConvenyanceClaim(), // not use
        );

      case RouteNames.managerTravelStatusClaim:
        return MaterialPageRoute(
          builder: (context) => ManagerTravelStatusList(
              settings.arguments as Map<String, dynamic>), // not understand
        );

      case RouteNames.managerapproveclaims:
        return MaterialPageRoute(
          builder: (context) =>
              ManagerApproveClaim(settings.arguments as Map<String, dynamic>),
        );

      case RouteNames.logsscreen:
        return MaterialPageRoute(
          builder: (context) => LogScreen(),
        );
      case RouteNames.travellistlog:
        return MaterialPageRoute(
          builder: (context) => TravelList(),
        );

      case RouteNames.travelviewlog:
        return MaterialPageRoute(
          builder: (context) =>
              TravelViewLog(settings.arguments as Map<String, dynamic>),
        );
      case RouteNames.incidentallistlog:
        return MaterialPageRoute(
          builder: (context) => Incidentallist(),
        );
      case RouteNames.conveyancelistlog:
        return MaterialPageRoute(
          builder: (context) => ConveyanceLogListScreen(),
        );
      case RouteNames.conveyanceviewlog:
        return MaterialPageRoute(
          builder: (context) =>
              ConvenyanceLogsViews(settings.arguments as Map<String, dynamic>),
        );

      case RouteNames.managerCompOffApplications:
        return MaterialPageRoute(
          builder: (context) => ManagerCompOffList(),
        );

      case RouteNames.tickethistoryscroll:
        return MaterialPageRoute(
          builder: (context) =>
              TicketHistoryScroll(settings.arguments as Map<String, dynamic>),
        );

      // case RouteNames.birthdaywish:
      //   return MaterialPageRoute(
      //     builder: (context) => BirthdayWish_Screen(settings.arguments as Map<String, dynamic>, settings.arguments as int),
      //   );

      case RouteNames.event:
        return MaterialPageRoute(
          builder: (context) => EventScreen(),
        );

      case RouteNames.atWork:
        return MaterialPageRoute(
          builder: (context) => ManagerMenuWorkList(), // not understand
        );

      case RouteNames.organizationnewlist:
        return MaterialPageRoute(
          builder: (context) =>
              OrganizationNewList(settings.arguments as Map<String, dynamic>),
        );

      case RouteNames.organizationdetails:
        return MaterialPageRoute(
          builder: (context) =>
              OrganizationDetails(settings.arguments as dynamic),
        );
      case RouteNames.signup:
        return MaterialPageRoute(
          builder: (context) => Signup_Screen(),
        );

      // case RouteNames.signupdetails:
      //   return MaterialPageRoute(
      //     builder: (context) => Signupdetails_Screen(settings.arguments as String),
      //   );

      case RouteNames.kycdetails:
        return MaterialPageRoute(
          builder: (context) => Kycdetails_Screen(settings.arguments as String),
        );

      case RouteNames.notificationList:
        return MaterialPageRoute(
          builder: (context) => NotificationList(),
        );

      case RouteNames.allEmployeeAttendance:
        return MaterialPageRoute(
          builder: (context) => AllEmployeeAttendance(),
        );

      case RouteNames.allEmployeeLeave:
        return MaterialPageRoute(
          builder: (context) => AllEmployeeLeave(),
        );

      case RouteNames.tds:
        return MaterialPageRoute(
          builder: (context) => Tds_Screen(),
        );
      case RouteNames.salesorder:
        return MaterialPageRoute(
          builder: (context) => SalesOrder_Screen(),
        );

      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            body: TravellistShimmer(),
          );
        });
    }
  }
}
