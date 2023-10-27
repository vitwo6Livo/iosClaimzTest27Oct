import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:claimz/consts/styles.dart';
import 'package:claimz/models/dashboardModel.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:claimz/services/backgroundServices.dart';
import 'package:claimz/viewModel/allHolidayViewModel.dart';
import 'package:claimz/viewModel/claimFormViewModel.dart';
import 'package:claimz/viewModel/claimzFormIndividualViewModel.dart';
import 'package:claimz/viewModel/claimzViewModel.dart';
import 'package:claimz/viewModel/iosDashboard.dart';
import 'package:claimz/viewModel/logsViewModel.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/viewModel/organisationViewModel.dart';
import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:claimz/viewModel/userIncidentalViewModel.dart';
import 'package:claimz/views/screens/allUpcomingHolidayList.dart';
import 'package:claimz/views/screens/attendancereportScreen.dart';
import 'package:claimz/views/screens/imei.dart';
import 'package:claimz/views/screens/shimmerScreen.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geol;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:workmanager/workmanager.dart';
import './services/locationPermissions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils/routes/route.dart';
import './utils/routes/routeNames.dart';
import './viewModel/logIn&signUpViewModel.dart';
import './viewModel/userViewModel.dart';
import './viewModel/holidayViewModel.dart';
import './viewModel/profileViewModel.dart';
import './viewModel/leaveTypeViewModel.dart';
import './viewModel/announcementViewModel.dart';
import './viewModel/attendanceViewModel.dart';
import './viewModel/toDoViewModel.dart';
import './viewModel/attendanceReportViewModel.dart';
import './viewModel/leaveViewModel.dart';
import './viewModel/leaveListViewModel.dart';
import './viewModel/checkInOutViewModel.dart';
import './viewModel/regularizationViewModel.dart';
import './viewModel/compOffViewModel.dart';
import './viewModel/paySlipViewModel.dart';
import './viewModel/claimzListViewModel.dart';
import './viewModel/claimsStatusViewModel.dart';
import './viewModel/leaveRemainingViewModel.dart';
import './viewModel/regularisationRequestViewModel.dart';
import './viewModel/leaveManager.dart';
import './viewModel/leaveRequestViewModel.dart';
import './viewModel/compOffRequestViewModel.dart';
import './viewModel/lateCheckinViewModel.dart';
import './viewModel/workRoleViewModel.dart';
import './viewModel/onOffViewModel.dart';
import './viewModel/upcomingHolidaysViewModel.dart';
import './viewModel/toDoViewModel/tasksViewModel.dart';
import 'notificationService/localNotification.dart';
import 'viewModel/allRegularisationViewModel.dart';
import 'viewModel/birthdayViewModel.dart';
import 'viewModel/claimzHistoryViewModel.dart';
import 'viewModel/compOffActionList.dart';
import 'viewModel/dashboardAnnouncementViewModel.dart';
import 'viewModel/mapMarkers.dart';
import 'viewModel/toDoViewModel/previousTaskList.dart';
import 'viewModel/toDoViewModel/upcomingTaskList.dart';
import 'package:http/http.dart' as http;
import './views/widgets/dashboardWidgets/attendance.dart';
import './viewModel/postAnnouncementViewModel.dart';
import './viewModel/reportingTreeViewModel.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sizer/sizer.dart';
import './viewModel/notificationAndEvent.dart';
import 'views/screens/imei.dart';

// BuildContext? contextt;

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
  // print('BACKGROUNDDDDDDDDDD');
}

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isAndroid) {
  //   // await AndroidAlarmManager.initialize();
  // } else if (Platform.isIOS) {
  //   await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  //   await Workmanager().registerPeriodicTask(
  //     "1",
  //     fetchBackground,
  //     initialDelay: const Duration(minutes: 10),
  //     frequency: const Duration(minutes: 15),
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ),
  //   );
  // }

  await FaceCamera.initialize();

  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  initializeTimeZones();

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);

  // bool? initialized =
  //     await notificationsPlugin.initialize(initializationSettings);

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  runApp(ClaimzApp());
  configLoading();
}

class TestClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}

class ClaimzApp extends StatefulWidget {
  ClaimzAppState createState() => ClaimzAppState();
}

const notificationChannelId = 'my_foreground';

// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 888;

class ClaimzAppState extends State<ClaimzApp> {
  ThemeProvider themeProvider = ThemeProvider();

  String? token;

  void getCurrentAppTheme() async {
    themeProvider.darkTheme =
        await themeProvider.darkThemePreferences.getTheme();
  }

  void checkToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      token = localStorage.getString('token').toString();
    });

    token == null
        ? print('No Token stored in $token')
        : print('Token stored in $token');
  }

  @override
  void initState() {
    // TODO: implement initState
    // LocationProvider();
    getCurrentAppTheme();

    checkToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('TOKEN IN BUILD: $token');

    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        }),
        ChangeNotifierProvider(create: (context) => LoginSignUpViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => HolidayViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        // ChangeNotifierProvider(create: (context) => LeaveTypeViewModel()),
        ChangeNotifierProvider(create: (context) => AnnouncementViewModel()),
        ChangeNotifierProvider(create: (context) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (context) => ToDoViewModel()),
        ChangeNotifierProvider(
            create: (context) => AttendanceReportViewModel()),
        ChangeNotifierProvider(create: (context) => LeaveViewModel()),
        ChangeNotifierProvider(create: (context) => LeaveListViewModel()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => CheckInOutViewModel()),
        ChangeNotifierProvider(create: (context) => RegularizationViewModel()),
        ChangeNotifierProvider(create: (context) => ClaimzViewModel()),
        ChangeNotifierProvider(create: (context) => CompOffViewModel()),
        ChangeNotifierProvider(create: (context) => PaySlipViewModel()),
        ChangeNotifierProvider(create: (context) => ClaimzListViewModel()),
        ChangeNotifierProvider(create: (context) => ClaimzFormViewModel()),
        ChangeNotifierProvider(create: (context) => ClaimzStatusViewModel()),
        ChangeNotifierProvider(create: (context) => LeaveRemainingViewModel()),
        ChangeNotifierProvider(
            create: (context) => RegularisationRequestViewModel()),
        ChangeNotifierProvider(create: (context) => LeaveManager()),
        ChangeNotifierProvider(create: (context) => TodaysTaskList()),
        ChangeNotifierProvider(create: (context) => LeaveRequestViewModel()),
        ChangeNotifierProvider(create: (context) => CompOffManagerViewModel()),
        ChangeNotifierProvider(create: (context) => LateCheckinViewModel()),
        ChangeNotifierProvider(create: (context) => WorkRoleViewModel()),
        ChangeNotifierProvider(create: (context) => OnOffViewModel()),
        ChangeNotifierProvider(
            create: (context) => UpcomingHolidaysViewModel()),
        ChangeNotifierProvider(create: (context) => TasksViewModel()),
        ChangeNotifierProvider(create: (context) => PreviousTaskList()),
        ChangeNotifierProvider(create: (context) => UpcomingTaskList()),
        ChangeNotifierProvider(
            create: (context) => DashboardAnnouncementViewModel()),
        ChangeNotifierProvider(create: (context) => AllHolidayViewModel()),
        ChangeNotifierProvider(create: (context) => OrganizationViewModel()),
        ChangeNotifierProvider(create: (context) => UserIncidentalViewModel()),
        ChangeNotifierProvider(
            create: (context) => ManagerIncidentalViewModel()),
        ChangeNotifierProvider(create: (context) => TravelViewModel()),
        ChangeNotifierProvider(
            create: (context) => PostAnnouncementViewModel()),
        ChangeNotifierProvider(create: (context) => ReportingTreeViewModel()),
        ChangeNotifierProvider(
            create: (context) => ClaimzFormIndividualViewModel()),
        ChangeNotifierProvider(
            create: (context) => AllRegularisationViewModel()),
        ChangeNotifierProvider(create: (context) => ClaimzHistoryViewModel()),
        ChangeNotifierProvider(create: (context) => LogsViewModel()),
        ChangeNotifierProvider(create: (context) => CompOffActionList()),
        ChangeNotifierProvider(create: (context) => MapMarkers()),
        ChangeNotifierProvider(create: (context) => NotificationAndEvent()),
        ChangeNotifierProvider(create: (context) => BirthdayViewModel()),
        ChangeNotifierProvider(create: (context) => IosDashboard())
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) =>
            Consumer<ThemeProvider>(builder: (context, themeData, child) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MaterialApp(
            builder: EasyLoading.init(),
            theme: Styles.themeData(themeProvider.darkTheme, context),
            onGenerateTitle: (BuildContext context) => 'Claimz',
            // home: ImeiNumber(),
            // initialRoute: token != null ? RouteNames.splash : RouteNames.intro,
            initialRoute: RouteNames.splash,
            // initialRoute: RouteNames.kycdetails,
            onGenerateRoute: Routes.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}
