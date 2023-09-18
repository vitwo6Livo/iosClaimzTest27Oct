// import 'dart:async';
// import 'dart:ui';

// // import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:another_flushbar/flushbar.dart';
// // import 'package:background_location/background_location.dart';
// // import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter/gestures.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIOSBackground,
//     ),
//     androidConfiguration: AndroidConfiguration(
//         onStart: onStart, isForegroundMode: true, autoStart: true),
//   );
// }

// @pragma('vm:entry-point')
// Future<bool> onIOSBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   int alarmId = 21;
//   DartPluginRegistrant.ensureInitialized();
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   if (service is AndroidServiceInstance) {
//     if (await service.isForegroundService()) {
//       service.setForegroundNotificationInfo(
//           title: 'Background service', content: 'tracking started');
//     }
//   }
//   await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//           forceAndroidLocationManager: false)
//       .then((Position position) async {
//     // AndroidAlarmManager.periodic(Duration(seconds: 120), alarmId, fireLocation);
//   }).catchError((e) {
//     print('error with location tracking-----------------');
//   });
//   print('background service running');
//   service.invoke('update');
// }

// @pragma('vm:entry-point')
// Future<void> fireLocation() async {
//   print("Backhround Fired at BS ${DateTime.now()}");

//   // var deviceInfo = DeviceInfoPlugin();

//   // var androidDeviceInfo = await deviceInfo.androidInfo;

//   Position userLocation = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);

//   // await http.get(
//   //   Uri.parse(
//   //       "http://devalpha.vitwo.ai/api/v2/claimz.php?device=${000000000}&lat=${userLocation.latitude}&lng=${userLocation.longitude}"),
//   // );

//   http.get(Uri.parse(
//       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}/address"));

//   print( 
//       "Show latlong at BS ${userLocation.latitude} ${userLocation.longitude}");

//   // convertLatLngToAddress(userLocation.latitude, userLocation.longitude).then(
//   //     (value) => http.get(Uri.parse(
//   //         "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}/address")));

//   // http.get(
//   //   Uri.parse(
//   //       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}"),
//   // );

//   // await BackgroundLocation.setAndroidNotification(
//   //   title: 'Background service is running',
//   //   message: 'Background location in progress',
//   //   icon: '@mipmap/ic_launcher',
//   // );

//   // await BackgroundLocation.startLocationService(distanceFilter: 0.0);
//   // await BackgroundLocation.getLocationUpdates((location) async {
//   //   print('LAT AND LNG: ${location.latitude} ${location.longitude}');

//   //   // var deviceInfo = DeviceInfoPlugin();
//   //   // if (Platform.isIOS) {
//   //   //   // import 'dart:io'
//   //   //   var iosDeviceInfo = await deviceInfo.iosInfo;
//   //   //   return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//   //   // } else if (Platform.isAndroid) {
//   //   //   var androidDeviceInfo = await deviceInfo.androidInfo;
//   //   //   http.get(
//   //   //     Uri.parse(
//   //   //         "http://devalpha.vitwo.ai/api/v2/claimz.php?device=${androidDeviceInfo.id}&lat=${location.latitude}&lng=${location.longitude}"),
//   //   //   );
//   //   // http.get(
//   //   //   Uri.parse(
//   //   //       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${location.latitude}/${location.longitude}"),
//   //   // );

//   //   //   print("Backhround Fired from API CALL at ${DateTime.now()}");

//   //   //   // Fluttertoast.showToast(
//   //   //   //     msg: "MyLocation ${location.latitude.toString()+" | "+location.longitude.toString()+" | "+androidDeviceInfo.id}",
//   //   //   //     toastLength: Toast.LENGTH_SHORT,
//   //   //   //     gravity: ToastGravity.CENTER,
//   //   //   //     timeInSecForIosWeb: 1,
//   //   //   //     backgroundColor: Colors.red,
//   //   //   //     textColor: Colors.white,
//   //   //   //     fontSize: 16.0
//   //   //   // );
//   //   //   return androidDeviceInfo.id; // unique ID on Android
//   //   // }
//   // });
// }
