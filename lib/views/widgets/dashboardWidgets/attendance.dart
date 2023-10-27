import 'dart:async';
import 'dart:convert';
import 'dart:ui';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:another_flushbar/flushbar.dart';
// import 'package:background_location/background_location.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/alert_dialog.dart';
import 'package:claimz/services/backgroundServices.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';
import '../../../main.dart';
import '../../../res/appUrl.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/locationPermissions.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/checkInOutViewModel.dart';
import 'package:geolocator/geolocator.dart';
import '../../../viewModel/attendanceViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:unique_identifier/unique_identifier.dart';
import '../../screens/mapScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class AttendanceWidget extends StatefulWidget {
  Map<String, dynamic> attendanceLatLng;
  String checkinTime;
  String checkoutTime;
  String checkinStatus;
  int attendanceId;

  AttendanceWidgetState createState() => AttendanceWidgetState();

  AttendanceWidget(this.attendanceLatLng, this.checkinTime, this.checkoutTime,
      this.checkinStatus, this.attendanceId);
}

class AttendanceWidgetState extends State<AttendanceWidget> {
  Duration duration = Duration();
  Timer? timer;
  int selection = 0;
  String? label;
  bool isClicked = false;
  DateFormat dateFormat = DateFormat.Hms();
  DateFormat format = DateFormat('yyyy-MM-dd');
  var checkValue;
  bool isLoading = true;
  String? currentLocation;
  String? currentLocality;
  double? currentLatitude;
  double? currentLongitude;
  double? officeLatitude;
  double? officeLongitude;
  var distanceDiff;
  int? radius;
  String? currentTimeStamp;
  String? checkOutTimeStamp;
  String? checkOutLocality;
  bool inOut = false;
  bool exceeded = false;
  bool checkOut = false;
  bool permissionOne = false;
  bool permissionTwo = false;
  bool locationLoader = false;
  dynamic? value;
  double? currentLat;
  double? currentLong;
  double percent = 0.0;
  int testVariable = 0;
  var lsIsClicked;
  int workOption = 0;
  // late GoogleMapController controller;
  // Location location = Location();
  late LatLng initialCameraPosition;
  String? apiCheckinStatus;
  bool addressLoader = true;
  late Geolocator _geolocator;
  late StreamSubscription<Position> positionStream;
  bool? isLoader;
  bool? isCheckoutLoader;
  int alarmId = 8;
  bool? isBreak;

  var greenGradient = const LinearGradient(
    colors: <Color>[
      Color(0XFF00D58D),
      Color(0XFF00C2A0),
    ],
  );

  var yellowGradient = const LinearGradient(
    colors: <Color>[
      Colors.amber,
      Colors.amberAccent,
    ],
  );

  var redGradient = const LinearGradient(
    colors: <Color>[
      Colors.redAccent,
      Colors.red,
    ],
  );

  var greyGradient = const LinearGradient(
      colors: <Color>[Color.fromARGB(255, 208, 206, 206), Colors.grey]);

  void listenToLocationChanges() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      setState(() async {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position!.latitude, position!.longitude,
            localeIdentifier: 'en');
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
        Placemark place = placemarks[0];
        currentLocation =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ($currentLatitude $currentLongitude)';
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print('CHECKIN TIME: ${widget.checkinTime}');
    print(
        'CHECKOUTTTTTTTT TIMEEEEEEEEEEEE: ${widget.attendanceLatLng['checkout_time']}');
    print('CHECKIN STATUS: ${widget.checkinStatus}');

    // AndroidAlarmManager.periodic(
    //     const Duration(seconds: 120), alarmId, fireLocation);

    listenToLocationChanges();

    checkApiStatus();
    autoRefreshLocation();
    getCurrentDetails();
    getCheckOutDetails();

    Provider.of<LocationProvider>(context, listen: false)
        .getLocation()
        .then((_) {
      setState(() {
        addressLoader = false;
      });
    });

    difference();
    initialiseLocalStorage();

    // isClicked == true
    //     ? AndroidAlarmManager.periodic(
    //         const Duration(seconds: 120), alarmId, fireLocation)
    //     : null;

    // AndroidAlarmManager.periodic(
    //     const Duration(seconds: 120), alarmId, fireLocation);

    setState(() {
      currentLocation =
          '${Provider.of<LocationProvider>(context, listen: false).deliveryAddress} (${Provider.of<LocationProvider>(context, listen: false).coorDinates['lat']} ${Provider.of<LocationProvider>(context, listen: false).coorDinates['lng']})';

      print('Current Location: $currentLocation');

      officeLatitude = double.parse(widget.attendanceLatLng['lat']);
      officeLongitude = double.parse(widget.attendanceLatLng['lng']);
      radius = widget.attendanceLatLng['radius'];
    });

    print('Current Location: $currentLocation');

    distanceDifference();
    super.initState();
  }

  void checkApiStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (widget.checkinTime != '' &&
        widget.checkoutTime == '' &&
        widget.checkinStatus == 'null') {
      apiCheckinStatus = 'Green';

      setState(() {
        localStorage.remove('currentTimeStamp');
        localStorage.remove('date');
        localStorage.setBool('attendance', false);
      });

      timer?.cancel();
    } else if (widget.checkinTime != '' &&
        widget.checkoutTime == '' &&
        widget.checkinStatus == 'checkin') {
      apiCheckinStatus = 'Red';
      var currentTimeStamp = DateTime.parse(widget.checkinTime);
      localStorage.setString('currentTimeStamp', currentTimeStamp.toString());
      localStorage.setString(
          'date', format.format(DateTime.parse(DateTime.now().toString())));
      localStorage.setBool('attendance', true);
      // setState(() {
      //   isClicked = true;
      // });
      print(
          'API INIT Timestamp: ${localStorage.getString('currentTimeStamp')}');
      print('API INIT Date: ${localStorage.getString('currentTimeStamp')}');
      print('IS CLICKED INIT: $isClicked');
    } else if (widget.checkinTime != '' &&
        widget.checkoutTime == '' &&
        widget.checkinStatus == 'checkin') {
      apiCheckinStatus = 'Amber';
    } else if (widget.checkinTime != '' &&
        widget.checkoutTime != '' &&
        widget.checkinStatus == 'checkout') {
      localStorage.setString(
          'date', format.format(DateTime.parse(DateTime.now().toString())));
      localStorage.setBool('attendance', false);

      apiCheckinStatus = 'Grey';
    }
  }

  selectedOption(int i) {
    setState(() {
      selection = i;
    });
  }

  void warning() {
    Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            title: 'Denied',
            message: 'You Do Not have the Adequate Priviledges for this option')
        .show(context);
  }

  void distanceDifference() async {
    print('LAT LNG: $currentLatitude $currentLongitude');

    // BackgroundService(context).triggerStart();
    setState(() {
      currentLatitude = Provider.of<LocationProvider>(context, listen: false)
          .coorDinates['lat'];
      currentLongitude = Provider.of<LocationProvider>(context, listen: false)
          .coorDinates['lng'];
      // currentLat = currentLatitude!;
      // currentLong = currentLongitude!;
    });

    print('LAT LNG: $currentLatitude $currentLongitude');

    distanceDiff = await Geolocator.distanceBetween(
        officeLatitude!, officeLongitude!, currentLatitude!, currentLongitude!);
    setState(() {
      value = distanceDiff;
    });
    print('Distance Difference: $distanceDiff');
    print('RADIUS: $radius');
  }

  @override
  void dispose() {
    super.dispose();
    positionStream.cancel();
    timer?.cancel();
  }

  void getCurrentDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String currentDate =
        format.format(DateTime.parse(DateTime.now().toString()));

    String apiCheckinTime = dateFormat
        .format(DateTime.parse(widget.attendanceLatLng['checkin_time']));

    String apiCheckinLocation =
        widget.attendanceLatLng['checkin_short_address'] ?? '';

    setState(() {
      currentLocality = (localStorage.getString('checkInlocality') == null ||
                  localStorage.getString('checkInlocality') == '') &&
              apiCheckinLocation == ''
          ? '---'
          : localStorage.getString('checkInlocality') == null ||
                  localStorage.getString('checkInlocality') == ''
              ? apiCheckinLocation
              : localStorage.getString('checkInlocality');

      currentTimeStamp = (localStorage.getString('checkInTimeStamp') == null ||
                  localStorage.getString('checkInTimeStamp') == '') &&
              (widget.attendanceLatLng['checkin_time'] != '' &&
                  widget.attendanceLatLng['checkin_status'] == null)
          ? '00:00:00'
          : localStorage.getString('checkInTimeStamp') == null ||
                  localStorage.getString('checkInTimeStamp') == ''
              ? apiCheckinTime
              : localStorage.getString('checkInTimeStamp');
      inOut = localStorage.getString('date') == currentDate ? true : false;
    });

    if (inOut == false) {
      setState(() {
        localStorage.remove('checkInlocality');
        localStorage.remove('checkInTimeStamp');
        currentLocality = '---';
        currentTimeStamp = '00:00:00';
      });
    }

    if (kDebugMode) {
      print('isClicked!!!!!: $isClicked');
      print('In Out Status!!!!!: $inOut');
      print('Current Date!!!!!: $currentDate');
      print('Date!!!!!: ${localStorage.getString('date')}');
    }
  }

  void getCheckOutDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String apiCheckoutTime = widget.attendanceLatLng['checkout_time'] == ''
        ? ''
        : DateFormat('HH:mm:ss')
            .format(DateTime.parse(widget.attendanceLatLng['checkout_time']));

    // dateFormat
    //     .format(DateTime.parse(widget.attendanceLatLng['checkout_time']));
    String apiCheckoutLocation =
        widget.attendanceLatLng['checkout_short_address'] ?? '';

    setState(() {
      checkOutLocality = (localStorage.getString('checkOutLocality') == null ||
                  localStorage.getString('checkOutLocality') == '') &&
              apiCheckoutLocation == ''
          ? '---'
          : localStorage.getString('checkOutLocality') == null ||
                  localStorage.getString('checkOutLocality') == ''
              ? apiCheckoutLocation
              : localStorage.getString('checkOutLocality');

      checkOutTimeStamp =
          (localStorage.getString('checkOutTimeStamp') == null ||
                      localStorage.getString('checkOutTimeStamp') == '') &&
                  widget.attendanceLatLng['checkout_time'] == '' &&
                  apiCheckoutTime == ''
              ? '00:00:00'
              : localStorage.getString('checkOutTimeStamp') == null ||
                      localStorage.getString('checkOutTimeStamp') == ''
                  ? apiCheckoutTime
                  : localStorage.getString('checkOutTimeStamp');
    });

    if (inOut == false) {
      setState(() {
        localStorage.remove('checkOutTimeStamp');
        localStorage.remove('checkOutLocality');
        checkOutTimeStamp = '00:00:00';
        checkOutLocality = '---';
      });
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<void> autoRefreshLocation() async {
    Position position = await _getGeoLocationPosition();
    Provider.of<LocationProvider>(context, listen: false)
        .getAddressFromLatLong(position)
        // .getAddressFromLocationTwo(position)
        .then((_) {
      setState(() {
        currentLocation = Provider.of<LocationProvider>(context, listen: false)
            .deliveryAddress;
        addressLoader = false;
      });
    });
  }

  void getCurrentLocation() async {
    Position position = await _getGeoLocationPosition();

    distanceDifference();

    Provider.of<LocationProvider>(context, listen: false)
        .getAddressFromLatLong(position)
        // .getAddressFromLocationTwo(position)
        .then((_) {
      setState(() {
        currentLocation = Provider.of<LocationProvider>(context, listen: false)
            .deliveryAddress;

        print('CURRENT LOCATIONNNNNNNNNNNNNNNNNNNNN: $currentLocation');
      });
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(
                const Duration(seconds: 8), () => Navigator.of(context).pop());
            return CupertinoAlertDialog(
              content: Column(
                children: [
                  Text('Current Address: $currentLocation!'),
                  value > radius
                      ? Text(
                          'Invalid Location: You are ${value.toStringAsFixed(0)} Metre(s) away from Office')
                      : Text(
                          'You are within ${value.toStringAsFixed(0)} Metre(s) of Office')
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); //close Dialog
                  },
                  child: Text(
                    'Close',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                )
              ],
            );
          });
    });

    print('LOCATIONNNNNNNNNN: $currentLocation');
    print('DISTANCE DIFFERENCE: $value');
  }

  void initialiseLocalStorage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print('Stored Button Status: ${localStorage.getBool('attendance')}');
    print(
        'Stored Button Status: ${localStorage.getString('currentTimeStamp')}');
    print('Current Time: ${DateTime.now()}');
    if (localStorage.getBool('attendance') == true) {
      setState(() {
        isClicked = true;
      });
    } else {
      setState(() {
        isClicked = false;
      });
    }

    // localStorage.setBool('break', isBreak!);
    if (localStorage.getBool('break') == true) {
      setState(() {
        isBreak = localStorage.getBool('break');
      });
    } else {
      setState(() {
        isBreak = localStorage.getBool('break');
      });
    }

    print('BReaaaaaaakkkkkkkkkkkk Valueeeeeeeeeeeeeeee: $isBreak');

    print('Initiallllllllllll Valueeeeeeeeeeeeeeee: $isClicked');
  }

  void difference() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var diff = DateFormat('yyyy-mm-dd hh:mm:ss').format(DateTime.now());
    var first = localStorage.getString('currentTimeStamp');
    var dn = DateTime.now();
    var second = dn.difference(DateTime.parse(first!)).inSeconds;
    print("IN SECONDS:- $second");
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void startTimer(Map<String, dynamic> data) async {
    isLoader = false;

    DateTime currentTime = DateTime.now();
    DateTime dateTime = DateTime.now().add(const Duration(hours: 4));

    DateTime dateTimeOff = DateTime.now().add(const Duration(hours: 8));
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.setBool('loader', false);

    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails('Notification 1', 'Lunch Notification',
            enableVibration: true,
            priority: Priority.max,
            importance: Importance.max,
            styleInformation: BigTextStyleInformation(''));

    IOSInitializationSettings iosDetails = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosNotificationDetails);

    notificationsPlugin.show(
        0,
        'Checked In',
        'A long day ahead, but remember -\nWe are hustlers not sloggers',
        notificationDetails);

    notificationsPlugin.zonedSchedule(
        1,
        'Time for a Break',
        'You\'ve been at it for 4 hours,\ntime to get a Coffee',
        tz.TZDateTime.from(dateTime, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);

    notificationsPlugin.zonedSchedule(
        2,
        'You\'re done for the day',
        'Wohoo you\'ve completed 8 hrs,\ngive a pat on your shoulder',
        tz.TZDateTime.from(dateTimeOff, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);

    // For background

    // initializeService();

    // startTracking(true);

    if (kDebugMode) {
      print('Current Time: $currentTime');
      print('Data Type: ${currentTime.runtimeType}');
      print('CheckIn DATAAAAAAAAAAAAAAa: $data');
    }

    localStorage.setString(
        'date', format.format(DateTime.parse(DateTime.now().toString())));

    localStorage.setString('currentTimeStamp', DateTime.now().toString());

    localStorage.setString('checkInlocality',
        Provider.of<LocationProvider>(context, listen: false).locality);

    String timeStamp =
        dateFormat.format(DateTime.parse(DateTime.now().toString()).toLocal());

    localStorage.setString('checkInTimeStamp', timeStamp);

    print('Timestamppppppppppp: $timeStamp');

    getCurrentDetails();

    if (kDebugMode) {
      print('TIMESTAMP: ${localStorage.getString('currentTimeStamp')}');
    }

    setState(() {
      checkOut = false;
    });

    Provider.of<CheckInOutViewModel>(context, listen: false)
        .checkInOutViewModel(data, context)
        .then((value) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      setState(() {
        localStorage.setBool('loader', true);
        isLoader = true;
      });

      Provider.of<AttendanceViewModel>(context, listen: false)
          .getAttendanceList(context);

      await http.post(Uri.parse(AppUrl.claimz_post_location),
          body: json.encode({
            "lat": Provider.of<LocationProvider>(context, listen: false)
                .coorDinates['lat']
                .toString(),
            "lng": Provider.of<LocationProvider>(context, listen: false)
                .coorDinates['lng']
                .toString(),
            "address": Provider.of<LocationProvider>(context, listen: false)
                .deliveryAddress,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${localStorage.getString('token')},'
          });
    }).then((value) async {
      var deviceInfo = DeviceInfoPlugin();

      var iosDeviceInfo = await deviceInfo.iosInfo;

      Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      http.get(Uri.parse(
          "http://consoledev.claimz.in/api/api/location-store/${iosDeviceInfo.identifierForVendor}/${userLocation.latitude}/${userLocation.longitude}/address"));

      print('Device ID: ${iosDeviceInfo.identifierForVendor}');

      print(
          "Show latlong at Attendance ${userLocation.latitude} ${userLocation.longitude}");
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final addSeconds = 1;

    DateTime dateTime = DateTime.now().add(const Duration(seconds: 10));

    DateTime dateTimeOff = DateTime.now().add(const Duration(seconds: 20));

    setState(() {
      if (localStorage.getString('currentTimeStamp') == null ||
          localStorage.getString('currentTimeStamp') == "") {
        final seconds = duration.inSeconds + addSeconds;
        duration = Duration(seconds: seconds);

        print(
            'DURAAAAAAAAATIOOOOOOOOOON IN HOUUUUUUUUURS 1: ${duration.inMinutes}');

        // percent += 10;
      } else {
        var first = localStorage.getString('currentTimeStamp');
        var dn = DateTime.now();
        var second = dn.difference(DateTime.parse(first!)).inSeconds;
        final seconds = second + addSeconds;
        duration = Duration(seconds: seconds);

        localStorage.setInt('duration', int.parse(duration.inHours.toString()));

        print(
            'DURAAAAAAAAATIOOOOOOOOOON IN HOUUUUUUUUURS LS: ${duration.inMinutes}');
      }
    });
  }

  void stopTimerWithoutApi() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.remove('currentTimeStamp');
  }

  void stopTimer(Map<String, dynamic> checkOutData) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool addressLoader = true;

    // startTracking(false);

    isLoader = false;

    autoRefreshLocation().then((_) {
      // FlutterBackgroundService().invoke('stop');
      localStorage.remove('currentTimeStamp');

      if (kDebugMode) {
        print('CHECK OUT DATA: $checkOutData');
      }

      String timeStamp = dateFormat
          .format(DateTime.parse(DateTime.now().toString()).toLocal());

      localStorage.setString('checkOutTimeStamp', timeStamp);

      localStorage.setString('checkOutLocality',
          Provider.of<LocationProvider>(context, listen: false).locality);

      Provider.of<CheckInOutViewModel>(context, listen: false)
          .checkOutViewModel(checkOutData, context)
          .then((value) async {
        Provider.of<AttendanceViewModel>(context, listen: false)
            .getAttendanceList(context);

        setState(() {
          isLoader = true;
        });

        await http.post(Uri.parse(AppUrl.claimz_post_location),
            body: json.encode({
              "lat": Provider.of<LocationProvider>(context, listen: false)
                  .coorDinates['lat']
                  .toString(),
              "lng": Provider.of<LocationProvider>(context, listen: false)
                  .coorDinates['lng']
                  .toString(),
              "address": Provider.of<LocationProvider>(context, listen: false)
                  .deliveryAddress,
            }),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${localStorage.getString('token')},'
            });
      }).then((value) async {
        var deviceInfo = DeviceInfoPlugin();

        var iosDeviceInfo = await deviceInfo.iosInfo;

        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        http.get(Uri.parse(
            "http://consoledev.claimz.in/api/api/location-store/${iosDeviceInfo.identifierForVendor}/${userLocation.latitude}/${userLocation.longitude}/address"));

        print('Device ID: ${iosDeviceInfo.identifierForVendor}');

        print(
            "Show latlong at Attendance ${userLocation.latitude} ${userLocation.longitude}");
      });

      getCheckOutDetails();

      timer?.cancel();
    });
  }

  void startBreak() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails('Notification 1', 'Lunch Notification',
            enableVibration: true,
            priority: Priority.max,
            importance: Importance.max,
            styleInformation: BigTextStyleInformation(''));

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    DateTime startBreak = DateTime.now().add(const Duration(minutes: 15));
    notificationsPlugin.zonedSchedule(
        3,
        'You might want to get back to work',
        'You\'ve been at break for 15 minutes',
        tz.TZDateTime.from(startBreak, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);

    Provider.of<CheckInOutViewModel>(context, listen: false)
        .breakStart(context)
        .then((value) {
      if (value['status'] == 200) {
        setState(() {
          isBreak = true;

          localStorage.setBool('break', isBreak!);
        });
      }
    });
  }

  void endBreak() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    Provider.of<CheckInOutViewModel>(context, listen: false)
        .breakOver(context)
        .then((value) {
      if (value['status'] == 200) {
        setState(() {
          isBreak = false;

          localStorage.setBool('break', isBreak!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //checkOut == true ? '00' : to turn the timer back to 00
    final themeProvider = Provider.of<ThemeProvider>(context);

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var hours = twoDigits(duration.inHours);
    var minutes = twoDigits(duration.inMinutes.remainder(60));
    var seconds = twoDigits(duration.inSeconds.remainder(60));
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.02),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: SizeVariables.getHeight(context) * 0.35,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: const Border(
                bottom: BorderSide(width: 0.06),
                top: BorderSide(width: 0.06),
                right: BorderSide(width: 0.06),
                left: BorderSide(width: 0.06)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.red,
                // margin: EdgeInsets.only(
                //     top: SizeVariables.getHeight(context) * 0.008),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.02),
                        height: SizeVariables.getHeight(context) * 0.04,
                        // color: Colors.red,
                        child: Row(
                          children: [
                            Radio(
                              value: 0,
                              activeColor: Theme.of(context).highlightColor,
                              groupValue: selection,
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Theme.of(context).highlightColor;
                                }
                                return Theme.of(context).highlightColor;
                              }),
                              onChanged: (_) => selectedOption(0),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: InkWell(
                                onTap: () => selectedOption(0),
                                child: Text('Office',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                          height: SizeVariables.getHeight(context) * 0.04,
                          // color: Colors.green,
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  activeColor: Theme.of(context)
                                      .highlightColor, //Tanay---changed Colors.white to this
                                  groupValue: selection,
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return widget.attendanceLatLng[
                                                      'workstation'][0]
                                                  ['offsite'] ==
                                              1
                                          ? Theme.of(context)
                                              .highlightColor //Tanay---changed Colors.white to this
                                          : Colors.grey;
                                    }
                                    return widget.attendanceLatLng[
                                                'workstation'][0]['offsite'] ==
                                            1
                                        ? Theme.of(context)
                                            .highlightColor //Tanay---changed Colors.white to this
                                        : Colors.grey;
                                  }),
                                  onChanged:
                                      widget.attendanceLatLng['workstation'][0]
                                                  ['offsite'] ==
                                              1
                                          ? (_) => selectedOption(1)
                                          : (_) => warning()),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: InkWell(
                                  onTap: () {
                                    widget.attendanceLatLng['workstation'][0]
                                                ['offsite'] ==
                                            1
                                        ? selectedOption(1)
                                        : warning();
                                  },
                                  child: Text('Offsite',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: widget.attendanceLatLng[
                                                              'workstation'][0]
                                                          ['offsite'] ==
                                                      1
                                                  ? Theme.of(context)
                                                      .highlightColor //Tanay---changed Colors.white to this
                                                  : Colors.grey)),
                                ),
                              )
                            ],
                          )),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.02),
                          height: SizeVariables.getHeight(context) * 0.04,
                          // color: Colors.blue,
                          child: Row(
                            children: [
                              Radio(
                                  value: 2,
                                  activeColor: Colors.white,
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return widget.attendanceLatLng[
                                                  'workstation'][0]['onsite'] ==
                                              1
                                          ? Colors.white
                                          : Colors.grey;
                                    }
                                    return widget.attendanceLatLng[
                                                'workstation'][0]['onsite'] ==
                                            1
                                        ? Colors.white
                                        : Colors.grey;
                                  }),
                                  groupValue: selection,
                                  onChanged:
                                      widget.attendanceLatLng['workstation'][0]
                                                  ['onsite'] ==
                                              1
                                          ? (_) => selectedOption(2)
                                          : (_) => warning()),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: InkWell(
                                  onTap: () {
                                    widget.attendanceLatLng['workstation'][0]
                                                ['onsite'] ==
                                            1
                                        ? selectedOption(2)
                                        : warning();
                                  },
                                  child: Text(
                                    'Onsite',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: widget.attendanceLatLng[
                                                            'workstation'][0]
                                                        ['onsite'] ==
                                                    1
                                                ? Colors.white
                                                : Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeVariables.getHeight(context) * 0.01),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: double.infinity,
                          // color: Colors.green,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  width: double.infinity,
                                  // color: Colors.pink,
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () => getCurrentLocation(),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding: EdgeInsets.all(
                                          SizeVariables.getHeight(context) *
                                              0.01),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(4, 2))
                                          ]),
                                      child: addressLoader
                                          ? Center(
                                              child: Lottie.asset(
                                                  'assets/json/location.json',
                                                  height: 350,
                                                  width: 350))
                                          // const Center(
                                          //     child: CircularProgressIndicator(),
                                          //   )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .highlightColor,
                                                                  size: SizeVariables
                                                                          .getHeight(
                                                                              context) *
                                                                      0.02),
                                                              Text(
                                                                  'Current Location',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                        fontSize:
                                                                            10,
                                                                      ))
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () =>
                                                              getCurrentLocation(),
                                                          child: Icon(
                                                              Icons.refresh,
                                                              color: Theme.of(
                                                                      context)
                                                                  .highlightColor,
                                                              size: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.02),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.01,
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  child: Text(
                                                    currentLocation!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 8,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  width: double.infinity,
                                  // color: Colors.amber,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          width: double.infinity,
                                          // color: Colors.pink,
                                          padding: EdgeInsets.all(
                                              SizeVariables.getHeight(context) *
                                                  0.01),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    currentTimeStamp == null ||
                                                            currentTimeStamp ==
                                                                ''
                                                        ? '00:00:00'
                                                        : currentTimeStamp!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                61, 255, 190)),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    currentLocality == null ||
                                                            currentLocality ==
                                                                ''
                                                        ? ''
                                                        : currentLocality!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                61, 255, 190)),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          width: double.infinity,
                                          // color: Colors.red,
                                          padding: EdgeInsets.all(
                                              SizeVariables.getHeight(context) *
                                                  0.01),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  // Text('Check Out Time: ',
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .bodyText1!
                                                  //         .copyWith(fontSize: 11)),
                                                  Text(
                                                    checkOutTimeStamp == null ||
                                                            checkOutTimeStamp ==
                                                                ''
                                                        ? '00:00:00'
                                                        : checkOutTimeStamp!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 10,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 232, 96, 96),
                                                        ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  // Text('Check Out Address: ',
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .bodyText1!
                                                  //         .copyWith(fontSize: 11)),
                                                  Text(
                                                    checkOutLocality == null ||
                                                            checkOutLocality ==
                                                                ''
                                                        ? '---'
                                                        : checkOutLocality!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                232, 96, 96)),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: double.infinity,
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: InkWell(
                                  onTap: () => selection == 1 || selection == 2
                                      ? inOut == true && isClicked == false ||
                                              apiCheckinStatus == 'Grey'
                                          ? null
                                          : checkInCheckOut(
                                              selection,
                                              currentLatitude,
                                              currentLongitude,
                                              currentLocation)
                                      : distanceDiff > radius
                                          ? Flushbar(
                                                  duration: const Duration(
                                                      seconds: 4),
                                                  flushbarPosition:
                                                      FlushbarPosition.BOTTOM,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  icon: const Icon(Icons.error,
                                                      color: Colors.white),
                                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                                  title: 'Invalid Location',
                                                  message:
                                                      'Checkin/Checkout Allowed within $radius metres of Office Area')
                                              .show(context)
                                          : inOut == true && isClicked == false
                                              ? null
                                              : checkInCheckOut(
                                                  selection,
                                                  currentLatitude,
                                                  currentLongitude,
                                                  currentLocation),
                                  child: Container(
                                    width: double.infinity,
                                    // color: Colors.yellow,
                                    // padding: EdgeInsets.only(
                                    //   left: height > 750
                                    //       ? 12.h
                                    //       : height < 650
                                    //           ? 5.h
                                    //           : 5.h,
                                    // ),
                                    child: Center(
                                      child: Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.15,
                                        width: SizeVariables.getWidth(context) *
                                            0.22,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: inOut == true &&
                                                        isClicked == false ||
                                                    apiCheckinStatus == 'Grey'
                                                ? greyGradient
                                                : isClicked == true &&
                                                        isBreak == true
                                                    ? yellowGradient
                                                    : isClicked == true ||
                                                            apiCheckinStatus ==
                                                                'Red'
                                                        ? redGradient
                                                        : greenGradient,
                                            boxShadow: [
                                              BoxShadow(
                                                color: inOut == true &&
                                                            isClicked ==
                                                                false ||
                                                        apiCheckinStatus ==
                                                            'Grey'
                                                    ? const Color.fromARGB(
                                                        255, 83, 80, 80)
                                                    : isClicked == true &&
                                                            isBreak == true
                                                        ? const Color.fromARGB(
                                                                255, 245, 231, 171)
                                                            .withOpacity(0.2)
                                                        : isClicked == true ||
                                                                apiCheckinStatus ==
                                                                    'Red'
                                                            ? const Color.fromARGB(
                                                                    255,
                                                                    241,
                                                                    107,
                                                                    98)
                                                                .withOpacity(
                                                                    0.2)
                                                            : const Color(
                                                                    0XFF00D58D)
                                                                .withOpacity(0.2),
                                                spreadRadius: 15,
                                                blurRadius: 15,
                                              ),
                                            ]),
                                        child: Center(
                                          child: isLoader == false
                                              ? const CircularProgressIndicator()
                                              : isLoader == null ||
                                                      isLoader == true
                                                  ? const Icon(
                                                      Icons
                                                          .power_settings_new_outlined,
                                                      color: Colors.white,
                                                      size: 50)
                                                  : const Icon(
                                                      Icons
                                                          .power_settings_new_outlined,
                                                      color: Colors.white,
                                                      size: 50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  width: double.infinity,
                                  // color: Colors.orange,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          // '00:00:00',
                                          '$hours : $minutes : $seconds',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 30),
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.01),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: SizeVariables.getWidth(
                                                    context) *
                                                0.04,
                                            right: SizeVariables.getWidth(
                                                    context) *
                                                0.04),
                                        child: SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.008,
                                          child: LinearPercentIndicator(
                                            // animation: true,
                                            // animationDuration: 3600000,
                                            percent: 0.8,
                                            lineHeight: SizeVariables.getHeight(
                                                    context) *
                                                0.04,
                                            progressColor: Colors.amber,
                                            backgroundColor: Colors.amber[100],
                                            linearStrokeCap:
                                                LinearStrokeCap.round,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkInCheckOut(int selectedOption, var currentLatitude,
      var currentLongitude, var currentAddress) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    getCurrentLocation();
    // FlutterBackgroundService().invoke('setAsForeground');
    // FlutterBackgroundService().invoke('setAsBackground');
    List<Placemark> newPlace = await placemarkFromCoordinates(
        Provider.of<LocationProvider>(context, listen: false)
            .coorDinates['lat'],
        Provider.of<LocationProvider>(context, listen: false)
            .coorDinates['lng']);

    Placemark placemark = newPlace[0];

    String? subLocality = placemark.subLocality;

    Map<String, dynamic> data = {
      'lat': currentLatitude.toString(),
      'lng': currentLongitude.toString(),
      // 'status': isClicked == false ? 'checkout' : 'checkin',
      'status': 'checkin',

      'address': currentAddress,
      'checkin_short_address': subLocality,
      'checkin_workstation': selectedOption == 0
          ? 'Office'
          : selectedOption == 1
              ? 'Offsite'
              : 'Onsite'
    };

    Map<String, dynamic> checkOutData = {
      'checkout_lat': currentLatitude.toString(),
      'checkout_lng': currentLongitude.toString(),
      'checkout_address': currentAddress,
      'id': localStorage.getInt('loginId') ?? widget.attendanceId,
      'checkout_short_address': subLocality,
      'checkout_workstation': selectedOption == 0
          ? 'Office'
          : selectedOption == 1
              ? 'Offsite'
              : 'Onsite'
    };

    if (isClicked == false) {
      setState(() {
        isClicked = true;
        localStorage.setBool('attendance', isClicked);
      });
      startTimer(data);
      // localStorage.setBool('attendance', isClicked);
      // print('CHECKIN DATAAAAAAAA: $data');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Are you sure you want to checkout?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black)),
              content: Text(
                  'If you do, you will not be able to checkin till the next working day',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black)),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      setState(() {
                        isClicked = false;
                        localStorage.setBool('attendance', isClicked);
                      });
                      stopTimer(checkOutData);
                      // print('CHECKOUT DATAAAAAAAA: $checkOutData');

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Checkout',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                    )),
                TextButton(
                  onPressed: () {
                    isBreak == true ? endBreak() : startBreak();
                    Navigator.pop(context); //close Dialog
                  },
                  child: Text(
                    isBreak == true ? 'Resume Work' : 'Break',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                )
              ],
            );
          });
    }

    if (kDebugMode) {
      isClicked
          ? print('CHECK IN OUT: $data')
          : print('CHECK OUT: $checkOutData');
    }
  }
}

const fetchBackground = "fetchBackground";

void callbackDispatcher() async {
  String identifier;

  identifier = (await UniqueIdentifier.serial)!;

  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        // Code to run in background

        //   print("Backhround Fired From Attendance at ${DateTime.now()}");

        var deviceInfo = DeviceInfoPlugin();

        var iosDeviceInfo = await deviceInfo.iosInfo;

        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        http.get(Uri.parse(
            "http://consoledev.claimz.in/api/api/location-store/${iosDeviceInfo.identifierForVendor}/${userLocation.latitude}/${userLocation.longitude}/address"));

        print('Device ID: ${iosDeviceInfo.identifierForVendor}');

        print(
            "Show latlong at Attendance ${userLocation.latitude} ${userLocation.longitude}");

        break;
    }
    return Future.value(true);
  });
}

// @pragma('vm:entry-point')
// Future<void> fireLocation() async {
  // print("Backhround Fired From Attendance at ${DateTime.now()}");

  // var deviceInfo = DeviceInfoPlugin();

  // var androidDeviceInfo = await deviceInfo.androidInfo;

  // Position userLocation = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high);
  // // print("Show latlong ${userLocation.longitude}");

//   // await http.get(
//   //   Uri.parse(
//   //       "http://devalpha.vitwo.ai/api/v2/claimz.php?device=${000000000}&lat=${userLocation.latitude}&lng=${userLocation.longitude}"),
//   // );

//   http.get(Uri.parse(
//       "https://console.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}/address"));

//   print('Device ID: ${androidDeviceInfo.id}');

//   print(
//       "Show latlong at Attendance ${userLocation.latitude} ${userLocation.longitude}");

//   // convertLatLngToAddress(userLocation.latitude, userLocation.longitude).then(
//   //     (value) => http.get(Uri.parse(
//   //         "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}/address")));

//   // http.get(
//   //   Uri.parse(
//   //       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}"),
//   // );

//   await BackgroundLocation.setAndroidNotification(
//     title: 'Background service is running',
//     message: 'Background location in progress',
//     icon: '@mipmap/ic_launcher',
//   );

//   await BackgroundLocation.startLocationService(distanceFilter: 0.0);
//   await BackgroundLocation.getLocationUpdates((location) async {
//     print('LAT AND LNG: ${location.latitude} ${location.longitude}');

//     // var deviceInfo = DeviceInfoPlugin();
//     // if (Platform.isIOS) {
//     //   // import 'dart:io'
//     //   var iosDeviceInfo = await deviceInfo.iosInfo;
//     //   return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//     // } else if (Platform.isAndroid) {
//     //   var androidDeviceInfo = await deviceInfo.androidInfo;
//     //   http.get(
//     //     Uri.parse(
//     //         "http://devalpha.vitwo.ai/api/v2/claimz.php?device=${androidDeviceInfo.id}&lat=${location.latitude}&lng=${location.longitude}"),
//     //   );
//     // http.get(
//     //   Uri.parse(
//     //       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${location.latitude}/${location.longitude}"),
//     // );

//     //   print("Backhround Fired from API CALL at ${DateTime.now()}");

//     //   // Fluttertoast.showToast(
//     //   //     msg: "MyLocation ${location.latitude.toString()+" | "+location.longitude.toString()+" | "+androidDeviceInfo.id}",
//     //   //     toastLength: Toast.LENGTH_SHORT,
//     //   //     gravity: ToastGravity.CENTER,
//     //   //     timeInSecForIosWeb: 1,
//     //   //     backgroundColor: Colors.red,
//     //   //     textColor: Colors.white,
//     //   //     fontSize: 16.0
//     //   // );
//     //   return androidDeviceInfo.id; // unique ID on Android
//     // }
//   });
// }






















// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:another_flushbar/flushbar.dart';
// import 'package:background_location/background_location.dart';
// import 'package:claimz/provider/theme_provider.dart';
// import 'package:claimz/res/components/alert_dialog.dart';
// import 'package:claimz/services/backgroundServices.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:sizer/sizer.dart';
// import '../../../main.dart';
// import '../../../res/appUrl.dart';
// import '../../../res/components/containerStyle.dart';
// import '../../config/mediaQuery.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../services/locationPermissions.dart';
// import 'package:provider/provider.dart';
// import '../../../viewModel/checkInOutViewModel.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../../viewModel/attendanceViewModel.dart';
// import 'package:http/http.dart' as http;
// import 'package:timezone/timezone.dart' as tz;
// import '../../screens/mapScreen.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:provider/provider.dart';

// class AttendanceWidget extends StatefulWidget {
//   Map<String, dynamic> attendanceLatLng;
//   String checkinTime;
//   String checkoutTime;
//   String checkinStatus;
//   int attendanceId;

//   AttendanceWidgetState createState() => AttendanceWidgetState();

//   AttendanceWidget(this.attendanceLatLng, this.checkinTime, this.checkoutTime,
//       this.checkinStatus, this.attendanceId);
// }

// class AttendanceWidgetState extends State<AttendanceWidget> {
//   Duration duration = Duration();
//   Timer? timer;
//   int selection = 0;
//   String? label;
//   bool isClicked = false;
//   DateFormat dateFormat = DateFormat.Hms();
//   DateFormat format = DateFormat('yyyy-MM-dd');
//   var checkValue;
//   bool isLoading = true;
//   String? currentLocation;
//   String? currentLocality;
//   double? currentLatitude;
//   double? currentLongitude;
//   double? officeLatitude;
//   double? officeLongitude;
//   var distanceDiff;
//   int? radius;
//   String? currentTimeStamp;
//   String? checkOutTimeStamp;
//   String? checkOutLocality;
//   bool inOut = false;
//   bool exceeded = false;
//   bool checkOut = false;
//   bool permissionOne = false;
//   bool permissionTwo = false;
//   bool locationLoader = false;
//   dynamic? value;
//   double? currentLat;
//   double? currentLong;
//   double percent = 0.0;
//   int testVariable = 0;
//   var lsIsClicked;
//   int workOption = 0;
//   // late GoogleMapController controller;
//   // Location location = Location();
//   late LatLng initialCameraPosition;
//   String? apiCheckinStatus;
//   bool addressLoader = true;
//   late Geolocator _geolocator;
//   late StreamSubscription<Position> positionStream;
//   bool? isLoader;
//   bool? isCheckoutLoader;
//   bool? isBreak;
//   int alarmId = 8;

//   var greenGradient = const LinearGradient(
//     colors: <Color>[
//       Color(0XFF00D58D),
//       Color(0XFF00C2A0),
//     ],
//   );

//   var redGradient = const LinearGradient(
//     colors: <Color>[
//       Colors.redAccent,
//       Colors.red,
//     ],
//   );

//   var greyGradient = const LinearGradient(
//       colors: <Color>[Color.fromARGB(255, 208, 206, 206), Colors.grey]);

//   void listenToLocationChanges() {
//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10,
//     );

//     positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings)
//             .listen((Position? position) {
//       setState(() async {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//             position!.latitude, position!.longitude,
//             localeIdentifier: 'en');
//         currentLatitude = position.latitude;
//         currentLongitude = position.longitude;
//         Placemark place = placemarks[0];
//         currentLocation =
//             '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ($currentLatitude $currentLongitude)';
//       });
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     print('CHECKIN TIME: ${widget.checkinTime}');
//     print(
//         'CHECKOUTTTTTTTT TIMEEEEEEEEEEEE: ${widget.attendanceLatLng['checkout_time']}');
//     print('CHECKIN STATUS: ${widget.checkinStatus}');

//     AndroidAlarmManager.periodic(
//         const Duration(seconds: 120), alarmId, fireLocation);

//     listenToLocationChanges();

//     checkApiStatus();
//     autoRefreshLocation();
//     getCurrentDetails();
//     getCheckOutDetails();

//     Provider.of<LocationProvider>(context, listen: false)
//         .getLocation()
//         .then((_) {
//       setState(() {
//         addressLoader = false;
//       });
//     });

//     difference();
//     initialiseLocalStorage();
//     setState(() {
//       currentLocation =
//           '${Provider.of<LocationProvider>(context, listen: false).deliveryAddress} (${Provider.of<LocationProvider>(context, listen: false).coorDinates['lat']} ${Provider.of<LocationProvider>(context, listen: false).coorDinates['lng']})';

//       print('Current Location: $currentLocation');

//       officeLatitude = double.parse(widget.attendanceLatLng['lat']);
//       officeLongitude = double.parse(widget.attendanceLatLng['lng']);
//       radius = widget.attendanceLatLng['radius'];
//     });

//     print('Current Location: $currentLocation');

//     distanceDifference();
//     super.initState();
//   }

//   void checkApiStatus() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     if (widget.checkinTime != '' &&
//         widget.checkoutTime == '' &&
//         widget.checkinStatus == 'null') {
//       apiCheckinStatus = 'Green';

//       setState(() {
//         localStorage.remove('currentTimeStamp');
//         localStorage.remove('date');
//         localStorage.setBool('attendance', false);
//       });

//       timer?.cancel();
//     }
//     // else if (widget.checkinTime != '' &&
//     //     widget.checkoutTime == '' &&
//     //     widget.checkinStatus == 'checkin') {
//     //   apiCheckinStatus = 'Amber';
//     // }
//     else if (widget.checkinTime != '' &&
//         widget.checkoutTime == '' &&
//         widget.checkinStatus == 'checkin') {
//       apiCheckinStatus = 'Red';
//       var currentTimeStamp = DateTime.parse(widget.checkinTime);
//       localStorage.setString('currentTimeStamp', currentTimeStamp.toString());
//       localStorage.setString(
//           'date', format.format(DateTime.parse(DateTime.now().toString())));
//       localStorage.setBool('attendance', true);
//       // setState(() {
//       //   isClicked = true;
//       // });
//       print(
//           'API INIT Timestamp: ${localStorage.getString('currentTimeStamp')}');
//       print('API INIT Date: ${localStorage.getString('currentTimeStamp')}');
//       print('IS CLICKED INIT: $isClicked');
//     } else if (widget.checkinTime != '' &&
//         widget.checkoutTime != '' &&
//         widget.checkinStatus == 'checkout') {
//       localStorage.setString(
//           'date', format.format(DateTime.parse(DateTime.now().toString())));
//       localStorage.setBool('attendance', false);

//       apiCheckinStatus = 'Grey';
//     }
//   }

//   selectedOption(int i) {
//     setState(() {
//       selection = i;
//     });
//   }

//   void warning() {
//     Flushbar(
//             duration: const Duration(seconds: 4),
//             flushbarPosition: FlushbarPosition.BOTTOM,
//             borderRadius: BorderRadius.circular(10),
//             icon: const Icon(Icons.error, color: Colors.white),
//             // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
//             title: 'Denied',
//             message: 'You Do Not have the Adequate Priviledges for this option')
//         .show(context);
//   }

//   void distanceDifference() async {
//     print('LAT LNG: $currentLatitude $currentLongitude');

//     // BackgroundService(context).triggerStart();
//     setState(() {
//       currentLatitude = Provider.of<LocationProvider>(context, listen: false)
//           .coorDinates['lat'];
//       currentLongitude = Provider.of<LocationProvider>(context, listen: false)
//           .coorDinates['lng'];
//       // currentLat = currentLatitude!;
//       // currentLong = currentLongitude!;
//     });

//     print('LAT LNG: $currentLatitude $currentLongitude');

//     distanceDiff = await Geolocator.distanceBetween(
//         officeLatitude!, officeLongitude!, currentLatitude!, currentLongitude!);
//     setState(() {
//       value = distanceDiff;
//     });
//     print('Distance Difference: $distanceDiff');
//     print('RADIUS: $radius');
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     positionStream.cancel();
//     timer?.cancel();
//   }

//   void getCurrentDetails() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     String currentDate =
//         format.format(DateTime.parse(DateTime.now().toString()));

//     String apiCheckinTime = dateFormat
//         .format(DateTime.parse(widget.attendanceLatLng['checkin_time']));

//     String apiCheckinLocation =
//         widget.attendanceLatLng['checkin_short_address'] ?? '';

//     setState(() {
//       currentLocality = (localStorage.getString('checkInlocality') == null ||
//                   localStorage.getString('checkInlocality') == '') &&
//               apiCheckinLocation == ''
//           ? '---'
//           : localStorage.getString('checkInlocality') == null ||
//                   localStorage.getString('checkInlocality') == ''
//               ? apiCheckinLocation
//               : localStorage.getString('checkInlocality');

//       currentTimeStamp = (localStorage.getString('checkInTimeStamp') == null ||
//                   localStorage.getString('checkInTimeStamp') == '') &&
//               (widget.attendanceLatLng['checkin_time'] != '' &&
//                   widget.attendanceLatLng['checkin_status'] == null)
//           ? '00:00:00'
//           : localStorage.getString('checkInTimeStamp') == null ||
//                   localStorage.getString('checkInTimeStamp') == ''
//               ? apiCheckinTime
//               : localStorage.getString('checkInTimeStamp');
//       inOut = localStorage.getString('date') == currentDate ? true : false;
//     });

//     if (inOut == false) {
//       setState(() {
//         localStorage.remove('checkInlocality');
//         localStorage.remove('checkInTimeStamp');
//         currentLocality = '---';
//         currentTimeStamp = '00:00:00';
//       });
//     }

//     if (kDebugMode) {
//       print('isClicked!!!!!: $isClicked');
//       print('In Out Status!!!!!: $inOut');
//       print('Current Date!!!!!: $currentDate');
//       print('Date!!!!!: ${localStorage.getString('date')}');
//     }
//   }

//   void getCheckOutDetails() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     String apiCheckoutTime = widget.attendanceLatLng['checkout_time'] == ''
//         ? ''
//         : DateFormat('HH:mm:ss')
//             .format(DateTime.parse(widget.attendanceLatLng['checkout_time']));

//     // dateFormat
//     //     .format(DateTime.parse(widget.attendanceLatLng['checkout_time']));
//     String apiCheckoutLocation =
//         widget.attendanceLatLng['checkout_short_address'] ?? '';

//     setState(() {
//       checkOutLocality = (localStorage.getString('checkOutLocality') == null ||
//                   localStorage.getString('checkOutLocality') == '') &&
//               apiCheckoutLocation == ''
//           ? '---'
//           : localStorage.getString('checkOutLocality') == null ||
//                   localStorage.getString('checkOutLocality') == ''
//               ? apiCheckoutLocation
//               : localStorage.getString('checkOutLocality');

//       checkOutTimeStamp =
//           (localStorage.getString('checkOutTimeStamp') == null ||
//                       localStorage.getString('checkOutTimeStamp') == '') &&
//                   widget.attendanceLatLng['checkout_time'] == '' &&
//                   apiCheckoutTime == ''
//               ? '00:00:00'
//               : localStorage.getString('checkOutTimeStamp') == null ||
//                       localStorage.getString('checkOutTimeStamp') == ''
//                   ? apiCheckoutTime
//                   : localStorage.getString('checkOutTimeStamp');
//     });

//     if (inOut == false) {
//       setState(() {
//         localStorage.remove('checkOutTimeStamp');
//         localStorage.remove('checkOutLocality');
//         checkOutTimeStamp = '00:00:00';
//         checkOutLocality = '---';
//       });
//     }
//   }

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
//         desiredAccuracy: LocationAccuracy.bestForNavigation);
//   }

//   Future<void> autoRefreshLocation() async {
//     Position position = await _getGeoLocationPosition();
//     Provider.of<LocationProvider>(context, listen: false)
//         .getAddressFromLatLong(position)
//         // .getAddressFromLocationTwo(position)
//         .then((_) {
//       setState(() {
//         currentLocation = Provider.of<LocationProvider>(context, listen: false)
//             .deliveryAddress;
//         addressLoader = false;
//       });
//     });
//   }

//   void getCurrentLocation() async {
//     Position position = await _getGeoLocationPosition();

//     distanceDifference();

//     Provider.of<LocationProvider>(context, listen: false)
//         .getAddressFromLatLong(position)
//         // .getAddressFromLocationTwo(position)
//         .then((_) {
//       setState(() {
//         currentLocation = Provider.of<LocationProvider>(context, listen: false)
//             .deliveryAddress;

//         print('CURRENT LOCATIONNNNNNNNNNNNNNNNNNNNN: $currentLocation');
//       });
//       showDialog(
//           context: context,
//           builder: (context) {
//             Future.delayed(
//                 const Duration(seconds: 8), () => Navigator.of(context).pop());
//             return CupertinoAlertDialog(
//               content: Column(
//                 children: [
//                   Text('Current Address: $currentLocation!'),
//                   value > radius
//                       ? Text(
//                           'Invalid Location: You are ${value.toStringAsFixed(0)} Metre(s) away from Office')
//                       : Text(
//                           'You are within ${value.toStringAsFixed(0)} Metre(s) of Office')
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context); //close Dialog
//                   },
//                   child: Text(
//                     'Close',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(color: Colors.black),
//                   ),
//                 )
//               ],
//             );
//           });
//     });

//     print('LOCATIONNNNNNNNNN: $currentLocation');
//     print('DISTANCE DIFFERENCE: $value');
//   }

//   void initialiseLocalStorage() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     print('Stored Button Status: ${localStorage.getBool('attendance')}');
//     print(
//         'Stored Button Status: ${localStorage.getString('currentTimeStamp')}');
//     print('Current Time: ${DateTime.now()}');
//     if (localStorage.getBool('attendance') == true) {
//       setState(() {
//         isClicked = true;
//       });
//     } else {
//       setState(() {
//         isClicked = false;
//       });
//     }

//     localStorage.setBool('break', isBreak!);
//     if (localStorage.getBool('break') == true) {
//       setState(() {
//         isBreak = localStorage.getBool('break');
//       });
//     } else {
//       setState(() {
//         isBreak = localStorage.getBool('break');
//       });
//     }

//     print('BReaaaaaaakkkkkkkkkkkk Valueeeeeeeeeeeeeeee: $isBreak');

//     print('Initiallllllllllll Valueeeeeeeeeeeeeeee: $isClicked');
//   }

//   void difference() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     // var diff = DateFormat('yyyy-mm-dd hh:mm:ss').format(DateTime.now());
//     var first = localStorage.getString('currentTimeStamp');
//     var dn = DateTime.now();
//     var second = dn.difference(DateTime.parse(first!)).inSeconds;
//     print("IN SECONDS:- $second");
//     timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
//   }

//   void startTimer(Map<String, dynamic> data) async {
//     isLoader = false;

//     DateTime currentTime = DateTime.now();
//     DateTime dateTime = DateTime.now().add(const Duration(hours: 4));

//     DateTime dateTimeOff = DateTime.now().add(const Duration(hours: 8));
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     localStorage.setBool('loader', false);

//     AndroidNotificationDetails androidDetails =
//         const AndroidNotificationDetails('Notification 1', 'Lunch Notification',
//             enableVibration: true,
//             priority: Priority.max,
//             importance: Importance.max,
//             styleInformation: BigTextStyleInformation(''));

//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     notificationsPlugin.show(
//         0,
//         'Checked In',
//         'A long day ahead, but remember -\nWe are hustlers not sloggers',
//         notificationDetails);

//     notificationsPlugin.zonedSchedule(
//         1,
//         'Time for a Break',
//         'You\'ve been at it for 4 hours,\ntime to get a Coffee',
//         tz.TZDateTime.from(dateTime, tz.local),
//         notificationDetails,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         androidAllowWhileIdle: true);

//     notificationsPlugin.zonedSchedule(
//         2,
//         'You\'re done for the day',
//         'Wohoo you\'ve completed 8 hrs,\ngive a pat on your shoulder',
//         tz.TZDateTime.from(dateTimeOff, tz.local),
//         notificationDetails,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         androidAllowWhileIdle: true);

//     //For background

//     // initializeService();

//     startTracking(true);

//     if (kDebugMode) {
//       print('Current Time: $currentTime');
//       print('Data Type: ${currentTime.runtimeType}');
//       print('CheckIn DATAAAAAAAAAAAAAAa: $data');
//     }

//     localStorage.setString(
//         'date', format.format(DateTime.parse(DateTime.now().toString())));

//     localStorage.setString('currentTimeStamp', DateTime.now().toString());

//     localStorage.setString('checkInlocality',
//         Provider.of<LocationProvider>(context, listen: false).locality);

//     String timeStamp =
//         dateFormat.format(DateTime.parse(DateTime.now().toString()).toLocal());

//     localStorage.setString('checkInTimeStamp', timeStamp);

//     print('Timestamppppppppppp: $timeStamp');

//     getCurrentDetails();

//     if (kDebugMode) {
//       print('TIMESTAMP: ${localStorage.getString('currentTimeStamp')}');
//     }

//     setState(() {
//       checkOut = false;
//     });

//     Provider.of<CheckInOutViewModel>(context, listen: false)
//         .checkInOutViewModel(data, context)
//         .then((value) async {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();

//       setState(() {
//         localStorage.setBool('loader', true);
//         isLoader = true;
//       });

//       Provider.of<AttendanceViewModel>(context, listen: false)
//           .getAttendanceList(context);

//       await http.post(Uri.parse(AppUrl.claimz_post_location),
//           body: json.encode({
//             "lat": Provider.of<LocationProvider>(context, listen: false)
//                 .coorDinates['lat']
//                 .toString(),
//             "lng": Provider.of<LocationProvider>(context, listen: false)
//                 .coorDinates['lng']
//                 .toString(),
//             "address": Provider.of<LocationProvider>(context, listen: false)
//                 .deliveryAddress,
//           }),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer ${localStorage.getString('token')},'
//           });
//     });

//     timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
//   }

//   void addTime() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     final addSeconds = 1;

//     DateTime dateTime = DateTime.now().add(const Duration(seconds: 10));

//     DateTime dateTimeOff = DateTime.now().add(const Duration(seconds: 20));

//     setState(() {
//       if (localStorage.getString('currentTimeStamp') == null ||
//           localStorage.getString('currentTimeStamp') == "") {
//         final seconds = duration.inSeconds + addSeconds;
//         duration = Duration(seconds: seconds);

//         print(
//             'DURAAAAAAAAATIOOOOOOOOOON IN HOUUUUUUUUURS 1: ${duration.inMinutes}');

//         // percent += 10;
//       } else {
//         var first = localStorage.getString('currentTimeStamp');
//         var dn = DateTime.now();
//         var second = dn.difference(DateTime.parse(first!)).inSeconds;
//         final seconds = second + addSeconds;
//         duration = Duration(seconds: seconds);

//         localStorage.setInt('duration', int.parse(duration.inHours.toString()));

//         print(
//             'DURAAAAAAAAATIOOOOOOOOOON IN HOUUUUUUUUURS LS: ${duration.inMinutes}');
//       }
//     });
//   }

//   void stopTimerWithoutApi() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     localStorage.remove('currentTimeStamp');
//   }

//   void stopTimer(Map<String, dynamic> checkOutData) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     bool addressLoader = true;

//     startTracking(false);

//     isLoader = false;

//     autoRefreshLocation().then((_) {
//       FlutterBackgroundService().invoke('stop');
//       localStorage.remove('currentTimeStamp');

//       if (kDebugMode) {
//         print('CHECK OUT DATA: $checkOutData');
//       }

//       String timeStamp = dateFormat
//           .format(DateTime.parse(DateTime.now().toString()).toLocal());

//       localStorage.setString('checkOutTimeStamp', timeStamp);

//       localStorage.setString('checkOutLocality',
//           Provider.of<LocationProvider>(context, listen: false).locality);

//       Provider.of<CheckInOutViewModel>(context, listen: false)
//           .checkOutViewModel(checkOutData, context)
//           .then((value) async {
//         Provider.of<AttendanceViewModel>(context, listen: false)
//             .getAttendanceList(context);

//         setState(() {
//           isLoader = true;
//         });

//         await http.post(Uri.parse(AppUrl.claimz_post_location),
//             body: json.encode({
//               "lat": Provider.of<LocationProvider>(context, listen: false)
//                   .coorDinates['lat']
//                   .toString(),
//               "lng": Provider.of<LocationProvider>(context, listen: false)
//                   .coorDinates['lng']
//                   .toString(),
//               "address": Provider.of<LocationProvider>(context, listen: false)
//                   .deliveryAddress,
//             }),
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': 'Bearer ${localStorage.getString('token')},'
//             });
//       });

//       getCheckOutDetails();

//       timer?.cancel();
//     });
//   }

//   void startBreak() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     AndroidNotificationDetails androidDetails =
//         const AndroidNotificationDetails('Notification 1', 'Lunch Notification',
//             enableVibration: true,
//             priority: Priority.max,
//             importance: Importance.max,
//             styleInformation: BigTextStyleInformation(''));

//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     DateTime startBreak = DateTime.now().add(const Duration(minutes: 15));
//     notificationsPlugin.zonedSchedule(
//         3,
//         'You might want to get back to work',
//         'You\'ve been at break for 15 minutes',
//         tz.TZDateTime.from(startBreak, tz.local),
//         notificationDetails,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         androidAllowWhileIdle: true);

//     Provider.of<CheckInOutViewModel>(context, listen: false)
//         .breakStart(context)
//         .then((value) {
//       if (value['status'] == 200) {
//         setState(() {
//           isBreak = true;

//           localStorage.setBool('break', isBreak!);
//         });
//       }
//     });
//   }

//   void endBreak() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     Provider.of<CheckInOutViewModel>(context, listen: false)
//         .breakOver(context)
//         .then((value) {
//       if (value['status'] == 200) {
//         setState(() {
//           isBreak = false;

//           localStorage.setBool('break', isBreak!);
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //checkOut == true ? '00' : to turn the timer back to 00
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     var hours = twoDigits(duration.inHours);
//     var minutes = twoDigits(duration.inMinutes.remainder(60));
//     var seconds = twoDigits(duration.inSeconds.remainder(60));
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     // TODO: implement build
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(width * 0.02),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
//         child: Container(
//           width: double.infinity,
//           height: SizeVariables.getHeight(context) * 0.35,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.background,
//             border: const Border(
//                 bottom: BorderSide(width: 0.06),
//                 top: BorderSide(width: 0.06),
//                 right: BorderSide(width: 0.06),
//                 left: BorderSide(width: 0.06)),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 // color: Colors.red,
//                 // margin: EdgeInsets.only(
//                 //     top: SizeVariables.getHeight(context) * 0.008),
//                 child: Row(
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       fit: FlexFit.tight,
//                       child: Container(
//                         padding: EdgeInsets.only(
//                             left: SizeVariables.getWidth(context) * 0.02),
//                         height: SizeVariables.getHeight(context) * 0.04,
//                         // color: Colors.red,
//                         child: Row(
//                           children: [
//                             Radio(
//                               value: 0,
//                               activeColor: Theme.of(context).highlightColor,
//                               groupValue: selection,
//                               fillColor:
//                                   MaterialStateProperty.resolveWith<Color>(
//                                       (states) {
//                                 if (states.contains(MaterialState.disabled)) {
//                                   return Theme.of(context).highlightColor;
//                                 }
//                                 return Theme.of(context).highlightColor;
//                               }),
//                               onChanged: (_) => selectedOption(0),
//                             ),
//                             FittedBox(
//                               fit: BoxFit.contain,
//                               child: InkWell(
//                                 onTap: () => selectedOption(0),
//                                 child: Text('Office',
//                                     style:
//                                         Theme.of(context).textTheme.bodyText1),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       fit: FlexFit.tight,
//                       child: Container(
//                           height: SizeVariables.getHeight(context) * 0.04,
//                           // color: Colors.green,
//                           child: Row(
//                             children: [
//                               Radio(
//                                   value: 1,
//                                   activeColor: Theme.of(context)
//                                       .highlightColor, //Tanay---changed Colors.white to this
//                                   groupValue: selection,
//                                   fillColor:
//                                       MaterialStateProperty.resolveWith<Color>(
//                                           (states) {
//                                     if (states
//                                         .contains(MaterialState.disabled)) {
//                                       return widget.attendanceLatLng[
//                                                       'workstation'][0]
//                                                   ['offsite'] ==
//                                               1
//                                           ? Theme.of(context)
//                                               .highlightColor //Tanay---changed Colors.white to this
//                                           : Colors.grey;
//                                     }
//                                     return widget.attendanceLatLng[
//                                                 'workstation'][0]['offsite'] ==
//                                             1
//                                         ? Theme.of(context)
//                                             .highlightColor //Tanay---changed Colors.white to this
//                                         : Colors.grey;
//                                   }),
//                                   onChanged:
//                                       widget.attendanceLatLng['workstation'][0]
//                                                   ['offsite'] ==
//                                               1
//                                           ? (_) => selectedOption(1)
//                                           : (_) => warning()),
//                               FittedBox(
//                                 fit: BoxFit.contain,
//                                 child: InkWell(
//                                   onTap: () {
//                                     widget.attendanceLatLng['workstation'][0]
//                                                 ['offsite'] ==
//                                             1
//                                         ? selectedOption(1)
//                                         : warning();
//                                   },
//                                   child: Text('Offsite',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1!
//                                           .copyWith(
//                                               color: widget.attendanceLatLng[
//                                                               'workstation'][0]
//                                                           ['offsite'] ==
//                                                       1
//                                                   ? Theme.of(context)
//                                                       .highlightColor //Tanay---changed Colors.white to this
//                                                   : Colors.grey)),
//                                 ),
//                               )
//                             ],
//                           )),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       fit: FlexFit.tight,
//                       child: Container(
//                           padding: EdgeInsets.only(
//                               right: SizeVariables.getWidth(context) * 0.02),
//                           height: SizeVariables.getHeight(context) * 0.04,
//                           // color: Colors.blue,
//                           child: Row(
//                             children: [
//                               Radio(
//                                   value: 2,
//                                   activeColor: Colors.white,
//                                   fillColor:
//                                       MaterialStateProperty.resolveWith<Color>(
//                                           (states) {
//                                     if (states
//                                         .contains(MaterialState.disabled)) {
//                                       return widget.attendanceLatLng[
//                                                   'workstation'][0]['onsite'] ==
//                                               1
//                                           ? Colors.white
//                                           : Colors.grey;
//                                     }
//                                     return widget.attendanceLatLng[
//                                                 'workstation'][0]['onsite'] ==
//                                             1
//                                         ? Colors.white
//                                         : Colors.grey;
//                                   }),
//                                   groupValue: selection,
//                                   onChanged:
//                                       widget.attendanceLatLng['workstation'][0]
//                                                   ['onsite'] ==
//                                               1
//                                           ? (_) => selectedOption(2)
//                                           : (_) => warning()),
//                               FittedBox(
//                                 fit: BoxFit.contain,
//                                 child: InkWell(
//                                   onTap: () {
//                                     widget.attendanceLatLng['workstation'][0]
//                                                 ['onsite'] ==
//                                             1
//                                         ? selectedOption(2)
//                                         : warning();
//                                   },
//                                   child: Text(
//                                     'Onsite',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(
//                                             color: widget.attendanceLatLng[
//                                                             'workstation'][0]
//                                                         ['onsite'] ==
//                                                     1
//                                                 ? Colors.white
//                                                 : Colors.grey),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: SizeVariables.getHeight(context) * 0.01),
//               Expanded(
//                 child: Container(
//                   // color: Colors.amber,
//                   width: double.infinity,
//                   child: Row(
//                     children: [
//                       Flexible(
//                         flex: 1,
//                         fit: FlexFit.tight,
//                         child: Container(
//                           height: double.infinity,
//                           // color: Colors.green,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Flexible(
//                                 flex: 1,
//                                 fit: FlexFit.tight,
//                                 child: Container(
//                                   width: double.infinity,
//                                   // color: Colors.pink,
//                                   padding: const EdgeInsets.all(10),
//                                   child: InkWell(
//                                     onTap: () => getCurrentLocation(),
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: double.infinity,
//                                       padding: EdgeInsets.all(
//                                           SizeVariables.getHeight(context) *
//                                               0.01),
//                                       decoration: BoxDecoration(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .tertiary,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.5),
//                                                 spreadRadius: 1,
//                                                 blurRadius: 7,
//                                                 offset: Offset(4, 2))
//                                           ]),
//                                       child: addressLoader
//                                           ? Center(
//                                               child: Lottie.asset(
//                                                   'assets/json/location.json',
//                                                   height: 350,
//                                                   width: 350))
//                                           // const Center(
//                                           //     child: CircularProgressIndicator(),
//                                           //   )
//                                           : Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Flexible(
//                                                   flex: 1,
//                                                   child: Container(
//                                                     // color: Colors.blue,
//                                                     width: double.infinity,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         SizedBox(
//                                                           child: Row(
//                                                             children: [
//                                                               Icon(
//                                                                   Icons
//                                                                       .location_on,
//                                                                   color: Theme.of(
//                                                                           context)
//                                                                       .highlightColor,
//                                                                   size: SizeVariables
//                                                                           .getHeight(
//                                                                               context) *
//                                                                       0.02),
//                                                               Text(
//                                                                   'Current Location',
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .bodyText1!
//                                                                       .copyWith(
//                                                                         fontSize:
//                                                                             10,
//                                                                       ))
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () =>
//                                                               getCurrentLocation(),
//                                                           child: Icon(
//                                                               Icons.refresh,
//                                                               color: Theme.of(
//                                                                       context)
//                                                                   .highlightColor,
//                                                               size: SizeVariables
//                                                                       .getHeight(
//                                                                           context) *
//                                                                   0.02),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height:
//                                                       SizeVariables.getHeight(
//                                                               context) *
//                                                           0.01,
//                                                 ),
//                                                 Container(
//                                                   // color: Colors.red,
//                                                   child: Text(
//                                                     currentLocation!,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                           fontSize: 8,
//                                                         ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 flex: 1,
//                                 fit: FlexFit.tight,
//                                 child: Container(
//                                   width: double.infinity,
//                                   // color: Colors.amber,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Flexible(
//                                         flex: 1,
//                                         fit: FlexFit.tight,
//                                         child: Container(
//                                           width: double.infinity,
//                                           // color: Colors.pink,
//                                           padding: EdgeInsets.all(
//                                               SizeVariables.getHeight(context) *
//                                                   0.01),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     currentTimeStamp == null ||
//                                                             currentTimeStamp ==
//                                                                 ''
//                                                         ? '00:00:00'
//                                                         : currentTimeStamp!,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             fontSize: 10,
//                                                             color: const Color
//                                                                     .fromARGB(
//                                                                 255,
//                                                                 61,
//                                                                 255,
//                                                                 190)),
//                                                   )
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     currentLocality == null ||
//                                                             currentLocality ==
//                                                                 ''
//                                                         ? ''
//                                                         : currentLocality!,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             fontSize: 10,
//                                                             color: const Color
//                                                                     .fromARGB(
//                                                                 255,
//                                                                 61,
//                                                                 255,
//                                                                 190)),
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         flex: 1,
//                                         fit: FlexFit.tight,
//                                         child: Container(
//                                           width: double.infinity,
//                                           // color: Colors.red,
//                                           padding: EdgeInsets.all(
//                                               SizeVariables.getHeight(context) *
//                                                   0.01),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   // Text('Check Out Time: ',
//                                                   //     style: Theme.of(context)
//                                                   //         .textTheme
//                                                   //         .bodyText1!
//                                                   //         .copyWith(fontSize: 11)),
//                                                   Text(
//                                                     checkOutTimeStamp == null ||
//                                                             checkOutTimeStamp ==
//                                                                 ''
//                                                         ? '00:00:00'
//                                                         : checkOutTimeStamp!,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                           fontSize: 10,
//                                                           color: const Color
//                                                                   .fromARGB(
//                                                               255, 232, 96, 96),
//                                                         ),
//                                                   )
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   // Text('Check Out Address: ',
//                                                   //     style: Theme.of(context)
//                                                   //         .textTheme
//                                                   //         .bodyText1!
//                                                   //         .copyWith(fontSize: 11)),
//                                                   Text(
//                                                     checkOutLocality == null ||
//                                                             checkOutLocality ==
//                                                                 ''
//                                                         ? '---'
//                                                         : checkOutLocality!,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             fontSize: 10,
//                                                             color: const Color
//                                                                     .fromARGB(
//                                                                 255,
//                                                                 232,
//                                                                 96,
//                                                                 96)),
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 1,
//                         fit: FlexFit.tight,
//                         child: Container(
//                           height: double.infinity,
//                           // color: Colors.blue,
//                           child: Column(
//                             children: [
//                               Flexible(
//                                 flex: 1,
//                                 fit: FlexFit.tight,
//                                 child: InkWell(
//                                   onTap: () => selection == 1 || selection == 2
//                                       ? inOut == true && isClicked == false ||
//                                               apiCheckinStatus == 'Grey'
//                                           ? null
//                                           : checkInCheckOut(
//                                               selection,
//                                               currentLatitude,
//                                               currentLongitude,
//                                               currentLocation)
//                                       : distanceDiff > radius
//                                           ? Flushbar(
//                                                   duration: const Duration(
//                                                       seconds: 4),
//                                                   flushbarPosition:
//                                                       FlushbarPosition.BOTTOM,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   icon: const Icon(Icons.error,
//                                                       color: Colors.white),
//                                                   // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
//                                                   title: 'Invalid Location',
//                                                   message:
//                                                       'Checkin/Checkout Allowed within $radius metres of Office Area')
//                                               .show(context)
//                                           : inOut == true && isClicked == false
//                                               ? null
//                                               : checkInCheckOut(
//                                                   selection,
//                                                   currentLatitude,
//                                                   currentLongitude,
//                                                   currentLocation),
//                                   child: Container(
//                                     width: double.infinity,
//                                     // color: Colors.yellow,
//                                     // padding: EdgeInsets.only(
//                                     //   left: height > 750
//                                     //       ? 12.h
//                                     //       : height < 650
//                                     //           ? 5.h
//                                     //           : 5.h,
//                                     // ),
//                                     child: Center(
//                                       child: Container(
//                                         height:
//                                             SizeVariables.getHeight(context) *
//                                                 0.15,
//                                         width: SizeVariables.getWidth(context) *
//                                             0.22,
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             gradient: inOut == true &&
//                                                         isClicked == false ||
//                                                     apiCheckinStatus == 'Grey'
//                                                 ? greyGradient
//                                                 : isClicked == true ||
//                                                         apiCheckinStatus ==
//                                                             'Red'
//                                                     ? redGradient
//                                                     : greenGradient,
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: inOut == true &&
//                                                             isClicked ==
//                                                                 false ||
//                                                         apiCheckinStatus ==
//                                                             'Grey'
//                                                     ? const Color.fromARGB(
//                                                         255, 83, 80, 80)
//                                                     // : isBreak == true
//                                                     //     ? const Color.fromARGB(
//                                                     //         255, 250, 208, 23)
//                                                     : isClicked == true ||
//                                                             apiCheckinStatus ==
//                                                                 'Red'
//                                                         ? const Color.fromARGB(
//                                                                 255,
//                                                                 241,
//                                                                 107,
//                                                                 98)
//                                                             .withOpacity(0.2)
//                                                         : const Color(
//                                                                 0XFF00D58D)
//                                                             .withOpacity(0.2),
//                                                 spreadRadius: 15,
//                                                 blurRadius: 15,
//                                               ),
//                                             ]),
//                                         child: Center(
//                                           child: isLoader == false
//                                               ? const CircularProgressIndicator()
//                                               : isLoader == null ||
//                                                       isLoader == true
//                                                   ? const Icon(
//                                                       Icons
//                                                           .power_settings_new_outlined,
//                                                       color: Colors.white,
//                                                       size: 50)
//                                                   : const Icon(
//                                                       Icons
//                                                           .power_settings_new_outlined,
//                                                       color: Colors.white,
//                                                       size: 50),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 flex: 1,
//                                 fit: FlexFit.tight,
//                                 child: Container(
//                                   width: double.infinity,
//                                   // color: Colors.orange,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       FittedBox(
//                                         fit: BoxFit.contain,
//                                         child: Text(
//                                           // '00:00:00',
//                                           '$hours : $minutes : $seconds',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1!
//                                               .copyWith(fontSize: 30),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                           height:
//                                               SizeVariables.getHeight(context) *
//                                                   0.01),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.04,
//                                             right: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.04),
//                                         child: SizedBox(
//                                           height:
//                                               SizeVariables.getHeight(context) *
//                                                   0.008,
//                                           child: LinearPercentIndicator(
//                                             // animation: true,
//                                             // animationDuration: 3600000,
//                                             percent: 0.8,
//                                             lineHeight: SizeVariables.getHeight(
//                                                     context) *
//                                                 0.04,
//                                             progressColor: Colors.amber,
//                                             backgroundColor: Colors.amber[100],
//                                             linearStrokeCap:
//                                                 LinearStrokeCap.round,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void checkInCheckOut(int selectedOption, var currentLatitude,
//       var currentLongitude, var currentAddress) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     getCurrentLocation();

//     List<Placemark> newPlace = await placemarkFromCoordinates(
//         Provider.of<LocationProvider>(context, listen: false)
//             .coorDinates['lat'],
//         Provider.of<LocationProvider>(context, listen: false)
//             .coorDinates['lng']);

//     Placemark placemark = newPlace[0];

//     String? subLocality = placemark.subLocality;

//     Map<String, dynamic> data = {
//       'lat': currentLatitude.toString(),
//       'lng': currentLongitude.toString(),
//       // 'status': isClicked == false ? 'checkout' : 'checkin',
//       'status': 'checkin',

//       'address': currentAddress,
//       'checkin_short_address': subLocality,
//       'checkin_workstation': selectedOption == 0
//           ? 'Office'
//           : selectedOption == 1
//               ? 'Offsite'
//               : 'Onsite'
//     };

//     Map<String, dynamic> checkOutData = {
//       'checkout_lat': currentLatitude.toString(),
//       'checkout_lng': currentLongitude.toString(),
//       'checkout_address': currentAddress,
//       'id': localStorage.getInt('loginId') ?? widget.attendanceId,
//       'checkout_short_address': subLocality,
//       'checkout_workstation': selectedOption == 0
//           ? 'Office'
//           : selectedOption == 1
//               ? 'Offsite'
//               : 'Onsite'
//     };

//     if (isClicked == false) {
//       setState(() {
//         isClicked = true;
//         localStorage.setBool('attendance', isClicked);
//       });
//       startTimer(data);
//       // localStorage.setBool('attendance', isClicked);
//       // print('CHECKIN DATAAAAAAAA: $data');
//     } else {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return CupertinoAlertDialog(
//               title: Text('Do You Want To Checkout or Go On Break?',
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(color: Colors.black)),
//               content: Text(
//                   'If you Checkout, you will not be able to checkin till the next working day',
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(color: Colors.black)),
//               actions: <Widget>[
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         isClicked = false;
//                         localStorage.setBool('attendance', isClicked);
//                       });
//                       stopTimer(checkOutData);
//                       // print('CHECKOUT DATAAAAAAAA: $checkOutData');

//                       Navigator.of(context).pop();
//                     },
//                     child: Text(
//                       'Checkout',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(color: Colors.black),
//                     )),
//                 TextButton(
//                   onPressed: () {
//                     isBreak == true ? endBreak() : startBreak();

//                     Navigator.pop(context); //close Dialog
//                   },
//                   child: Text(
//                     isBreak == true ? 'Resume Work' : 'Break',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(color: Colors.black),
//                   ),
//                 )
//               ],
//             );
//           });
//     }

//     if (kDebugMode) {
//       isClicked
//           ? print('CHECK IN OUT: $data')
//           : print('CHECK OUT: $checkOutData');
//     }
//   }
// }

// Future<String> convertLatLngToAddress(double latitude, double longitude) async {
//   var fetchAddress;

//   try {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(latitude, longitude);
//     if (placemarks != null && placemarks.isNotEmpty) {
//       Placemark placemark = placemarks.first;
//       fetchAddress =
//           "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";

//       //  _addresses['address'] = address;

//       // _address.add(_addresses);
//       // print('Address: $address');
//     } else {
//       print('No address found');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
//   return fetchAddress!;
// }

// @pragma('vm:entry-point')
// Future<void> fireLocation() async {
//   print("Backhround Fired From Attendance at ${DateTime.now()}");

//   var deviceInfo = DeviceInfoPlugin();

//   var androidDeviceInfo = await deviceInfo.androidInfo;

//   Position userLocation = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   // print("Show latlong ${userLocation.longitude}");

//   // await http.get(
//   //   Uri.parse(
//   //       "http://devalpha.vitwo.ai/api/v2/claimz.php?device=${000000000}&lat=${userLocation.latitude}&lng=${userLocation.longitude}"),
//   // );

//   http.get(Uri.parse(
//       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}/address"));

//   print(
//       "Show latlong at Attendance ${userLocation.latitude} ${userLocation.longitude}");

//   // convertLatLngToAddress(userLocation.latitude, userLocation.longitude).then(
//   //     (value) => http.get(Uri.parse(
//   //         "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}/address")));

//   // http.get(
//   //   Uri.parse(
//   //       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${userLocation.latitude}/${userLocation.longitude}"),
//   // );

//   await BackgroundLocation.setAndroidNotification(
//     title: 'Background service is running',
//     message: 'Background location in progress',
//     icon: '@mipmap/ic_launcher',
//   );

//   await BackgroundLocation.startLocationService(distanceFilter: 0.0);
//   await BackgroundLocation.getLocationUpdates((location) async {
//     print('LAT AND LNG: ${location.latitude} ${location.longitude}');

//     // var deviceInfo = DeviceInfoPlugin();
//     // if (Platform.isIOS) {
//     //   // import 'dart:io'
//     //   var iosDeviceInfo = await deviceInfo.iosInfo;
//     //   return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//     // } else if (Platform.isAndroid) {
//     //   var androidDeviceInfo = await deviceInfo.androidInfo;
//     //   http.get(
//     //     Uri.parse(
//     //         "http://devalpha.vitwo.ai/api/v2/claimz.php?device=${androidDeviceInfo.id}&lat=${location.latitude}&lng=${location.longitude}"),
//     //   );
//     // http.get(
//     //   Uri.parse(
//     //       "http://consoledev.claimz.in/api/api/location-store/${androidDeviceInfo.id}/${location.latitude}/${location.longitude}"),
//     // );

//     //   print("Backhround Fired from API CALL at ${DateTime.now()}");

//     //   // Fluttertoast.showToast(
//     //   //     msg: "MyLocation ${location.latitude.toString()+" | "+location.longitude.toString()+" | "+androidDeviceInfo.id}",
//     //   //     toastLength: Toast.LENGTH_SHORT,
//     //   //     gravity: ToastGravity.CENTER,
//     //   //     timeInSecForIosWeb: 1,
//     //   //     backgroundColor: Colors.red,
//     //   //     textColor: Colors.white,
//     //   //     fontSize: 16.0
//     //   // );
//     //   return androidDeviceInfo.id; // unique ID on Android
//     // }
//   });
// }
