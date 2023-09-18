//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:http/http.dart' as http;
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../res/appUrl.dart';
// import 'locationPermissions.dart';
//
// class BackgroundService{
//   final service = FlutterBackgroundService();
//   double? currentLatitude;
//   double? currentLongitude;
//   String? address;
//   BuildContext context;
//
//   BackgroundService(this.context);
//
//
//   triggerStart() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     // final service = FlutterBackgroundService();
//
//     await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         // this will be executed when app is in foreground or background in separated isolate
//         onStart: onStart,
//         // auto start service
//         autoStart: true,
//         isForegroundMode: true,
//
//       ),
//       iosConfiguration: IosConfiguration(
//         // auto start service
//         autoStart: true,
//
//         // this will be executed when app is in foreground in separated isolate
//         onForeground: onStart,
//
//         // you have to enable background fetch capability on xcode project
//         onBackground: onIosBackground,
//       ),
//     );
//     service.startService();
//   }
//
//   // to ensure this is executed
// // run app from xcode, then from xcode menu, select Simulate Background Fetch
//   bool onIosBackground(ServiceInstance service) {
//     WidgetsFlutterBinding.ensureInitialized();
//     print('FLUTTER BACKGROUND FETCH');
//
//     return true;
//   }
//
//   void onStart(ServiceInstance service) async {
//     // Only available for flutter 3.0.0 and later
//     DartPluginRegistrant.ensureInitialized();
//
//     // For flutter prior to version 3.0.0
//     // We have to register the plugin manually
//
//     currentLatitude = Provider.of<LocationProvider>(context, listen: false)
//         .coorDinates['lat'];
//     currentLongitude = Provider.of<LocationProvider>(context, listen: false)
//         .coorDinates['lng'];
//
//     address = Provider.of<LocationProvider>(context, listen: false)
//         .address;
//
//
//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//
//     // bring to foreground
//     Timer.periodic(const Duration(minutes: 30), (timer) async {
//       //post data
//       Map<String, String> body = {
//         "lat": "22.573465",
//         "lng": "88.463084",
//         "address": "Mani Casadona Building street 2"
//       };
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//
//       String authToken = localStorage.getString('token').toString();
//
//       await http.post(Uri.parse(AppUrl.claimz_post_location),
//           body: json.encode(body),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $authToken,'
//           });
//
//       /// you can see this log in logcat
//       print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//
//       // test using external plugin
//       final deviceInfo = DeviceInfoPlugin();
//       String? device;
//       if (Platform.isAndroid) {
//         final androidInfo = await deviceInfo.androidInfo;
//         device = androidInfo.model;
//       }
//
//       if (Platform.isIOS) {
//         final iosInfo = await deviceInfo.iosInfo;
//         device = iosInfo.model;
//       }
//
//       service.invoke(
//         'update',
//         {
//           "current_date": DateTime.now().toIso8601String(),
//           "device": device,
//         },
//       );
//     });
//   }
//
// }
