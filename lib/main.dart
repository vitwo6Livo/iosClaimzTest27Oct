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

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');

//   return true;
// }

// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   service.on('stop').listen((event) {
//     service.stopSelf();
//   });

//   // bring to foreground

//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: geol.LocationAccuracy.bestForNavigation);
//   }

//   Timer.periodic(const Duration(minutes: 1), (timer) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     Position positioned = await _getGeoLocationPosition().then((value) {
//       print(value.toString());
//       return value;
//     });

//     //post data
//     geol.Position? position = await geol.Geolocator.getLastKnownPosition();

//     await placemarkFromCoordinates(position!.latitude, position.longitude)
//         .then((value) async {
//       var first = value.first;
//       var address =
//           '${first.name}, ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.postalCode}';
//       print(address);

//       Map<String, String> body = {
//         "lat": position.latitude.toString(),
//         "lng": position.longitude.toString(),
//         "address": address,
//       };

//       print("BACKGROUND SCAN: $body");

//       String authToken = localStorage.getString('token').toString();

//       var response = await http.post(Uri.parse(AppUrl.claimz_post_location),
//           body: json.encode(body),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $authToken,'
//           });

//       print('STATUS CODE: ${response.statusCode}');

//       print('RESPONSE: ${json.decode(response.body)}');
//     });

//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }

//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }

//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FaceCamera.initialize();

  // await initializeService();

  // await AndroidAlarmManager.initialize();
  // initializeService();
  // Future.delayed(
  //     Duration(seconds: 2), () => FlutterBackgroundService().invoke("stop"));

  // Timer.periodic(
  //     Duration(seconds: 5),
  //     (timer) => Provider.of<AnnouncementViewModel>(contextt!, listen: false)
  //         .getAllAnouncements(
  //             DateFormat('MMMM').format(DateTime.now()).toString(),
  //             DateFormat('yyyy').format(DateTime.now()).toString()));

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
  // FlutterDownloader.registerCallback(TestClass.callback);

//   const notificationChannelId = 'my_foreground';

// // this will be used for notification id, So you can update your custom notification with this id.
// const notificationId = 888;

  // Future<void> initializeService() async {
  //   final service = FlutterBackgroundService();

  //   // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   //   notificationChannelId, // id
  //   //   'MY FOREGROUND SERVICE', // title
  //   //   description:
  //   //       'This channel is used for important notifications.', // description
  //   //   importance: Importance.low, // importance must be at low or higher level
  //   // );

  //   // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   //     FlutterLocalNotificationsPlugin();

  //   // await flutterLocalNotificationsPlugin
  //   //     .resolvePlatformSpecificImplementation<
  //   //         AndroidFlutterLocalNotificationsPlugin>()
  //   //     ?.createNotificationChannel(channel);

  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will be executed when app is in foreground or background in separated isolate
  //       onStart: onStart,
  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,

  //       // notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
  //       // initialNotificationTitle: 'AWESOME SERVICE',
  //       // initialNotificationContent: 'Initializing',
  //       // foregroundServiceNotificationId: notificationId,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       // auto start service
  //       autoStart: true,

  //       // this will be executed when app is in foreground in separated isolate
  //       onForeground: onStart,

  //       // you have to enable background fetch capability on xcode project
  //       onBackground: onIosBackground,
  //     ),
  //   );
  //   service.startService();
  // }

  runApp(ClaimzApp());
  configLoading();
}

class TestClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}
// void main() async{
//   // initserviceCall();
//   await FlutterDownloader.initialize(
//       debug: true, // optional: set to false to disable printing logs to console (default: true)
//       ignoreSsl: true // option: set to false to disable working with http links (default: false)
//   );
//   FlutterDownloader.registerCallback(TestClass.callback);

//   runApp(ClaimzApp());}

class ClaimzApp extends StatefulWidget {
  ClaimzAppState createState() => ClaimzAppState();
}

const notificationChannelId = 'my_foreground';

// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 888;

// Future<void> startTracking(bool action) async {
//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: geol.LocationAccuracy.bestForNavigation);
//   }

//   Timer.periodic(const Duration(minutes: 1), (Timer t) async {
//     if (action == true) {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();

//       Position positioned = await _getGeoLocationPosition().then((value) {
//         print(value.toString());
//         return value;
//       });

//       //post data
//       geol.Position? position = await geol.Geolocator.getLastKnownPosition();

//       await placemarkFromCoordinates(position!.latitude, position!.longitude)
//           .then((value) async {
//         var first = value.first;
//         var address =
//             '${first.name}, ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.postalCode}';
//         print(address);

//         Map<String, String> body = {
//           "lat": position.latitude.toString(),
//           "lng": position.longitude.toString(),
//           "address": address,
//           'time': DateTime.now().toString()
//         };
//         print("BACKGROUND SCAN " + body.toString());
//         String authToken = localStorage.getString('token').toString();
//         var response = await http.post(Uri.parse(AppUrl.claimz_post_location),
//             body: json.encode({
//               "lat": position.latitude.toString(),
//               "lng": position.longitude.toString(),
//               "address": address
//             }),
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': 'Bearer $authToken'
//             });

//         print('STATUS CODE: ${response.statusCode}');

//         print('RESPONSE: ${json.decode(response.body)}');
//       });
//     } else {
//       t.cancel();
//     }
//   });
// }

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();

//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     notificationChannelId, // id
//     'MY FOREGROUND SERVICE', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.low, // importance must be at low or higher level
//   );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//         // this will be executed when app is in foreground or background in separated isolate
//         onStart: onStart,
//         // auto start service
//         autoStart: true,
//         isForegroundMode: true,
//         notificationChannelId:
//             notificationChannelId, // this must match with notification channel you created above.
//         initialNotificationTitle: 'AWESOME SERVICE',
//         initialNotificationContent: 'Initializing',
//         foregroundServiceNotificationId: notificationId),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,

//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,

//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');

//   return true;
// }

// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually

//   service.on('stop').listen((event) {
//     service.stopSelf();
//   });

//   // bring to foreground

//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: geol.LocationAccuracy.bestForNavigation);
//   }

//   Timer.periodic(const Duration(minutes: 5), (timer) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     Position positioned = await _getGeoLocationPosition().then((value) {
//       print(value.toString());
//       return value;
//     });

//     // if (service is AndroidServiceInstance) {
//     //   if (await service.isForegroundService()) {

//     flutterLocalNotificationsPlugin.show(
//       notificationId,
//       'COOL SERVICE',
//       'Awesome ${DateTime.now()}',
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           notificationChannelId,
//           'MY FOREGROUND SERVICE',
//           icon: 'ic_bg_service_small',
//           ongoing: true,
//         ),
//       ),
//     );
//     //   }
//     // }

//     //post data
//     geol.Position? position = await geol.Geolocator.getLastKnownPosition();

//     await placemarkFromCoordinates(position!.latitude, position!.longitude)
//         .then((value) async {
//       var first = value.first;
//       var address =
//           '${first.name}, ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.postalCode}';
//       print(address);

//       Map<String, String> body = {
//         "lat": position.latitude.toString(),
//         "lng": position.longitude.toString(),
//         "address": address,
//         'time': DateTime.now().toString()
//       };

//       print("BACKGROUND SCAN " + body.toString());

//       String authToken = localStorage.getString('token').toString();

//       var response = await http.post(Uri.parse(AppUrl.claimz_post_location),
//           body: json.encode({
//             "lat": position.latitude.toString(),
//             "lng": position.longitude.toString(),
//             "address": address,
//           }),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $authToken,'
//           });

//       print('STATUS CODE: ${response.statusCode}');

//       print('RESPONSE: ${json.decode(response.body)}');
//     });

//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }

//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }

//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }

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
