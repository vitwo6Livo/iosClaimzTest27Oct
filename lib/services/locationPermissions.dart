import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    getLocation();
  }

  String _address = '';
  String _deliveryAddress = '';
  String _state = '';
  String? postCode;
  String? addressLine;
  String _locality = '';
  String? city;
  String? selectedState;
  late LocationSettings locationSettings;
  var defaultTargetPlatform;

  bool isLoading = true;

  bool get loading {
    return isLoading;
  }

  Map<String, dynamic> _coorDinates = {'lat': 0.0, 'lng': 0.0};

  Map<String, dynamic> get coorDinates {
    return {..._coorDinates};
  }

  String? get state {
    return _state;
  }

  String get address {
    return _address;
  }

  String get deliveryAddress {
    return _deliveryAddress;
  }

  String get locality {
    return _locality;
  }

  Future<bool> _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  Future<Position> _getGeoLocationPosition() async {
    // var status = await Permission.locationWhenInUse.status;
    // if (!status.isGranted) {
    //   var status = await Permission.locationWhenInUse.request();
    //   if (status.isGranted) {
    //     var status = await Permission.locationAlways.request();
    //     if (status.isGranted) {
    //       //Do some stuff
    //     } else {
    //       //Do another stuff
    //     }
    //   } else {
    //     //The user deny the permission
    //   }
    //   if (status.isPermanentlyDenied) {
    //     //When the user previously rejected the permission and select never ask again
    //     //Open the screen of settings
    //     bool res = await openAppSettings();
    //   }
    // } else {
    //   //In use is available, check the always in use
    //   var status = await Permission.locationAlways.status;
    //   if (!status.isGranted) {
    //     var status = await Permission.locationAlways.request();
    //     if (status.isGranted) {
    //       //Do some stuff
    //     } else {
    //       //Do another stuff
    //     }
    //   } else {
    //     //previously available, do some stuff or nothing
    //   }
    // }

    //PREVIOUS CODEEEE

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // permission = await Geolocator.requestPermission();
      // if (permission == LocationPermission.denied) {
      //   return Future.error('Location permissions are denied');
      // }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'en');
    print(placemarks);
    Placemark place = placemarks[0];
    _address = '${place.subLocality}';
    _deliveryAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    _state = place.administrativeArea!;

    postCode = place.postalCode!;
    addressLine = '${place.street} ${place.thoroughfare}';
    _locality = place.subLocality!;
    city = place.locality!;
    selectedState = place.administrativeArea!;

    print('Initial Address $postCode');
    print('Initial Address $addressLine');
    print('Initial Address $locality');
    print('Initial Address $city');
    print('Initial Address $selectedState');

    _coorDinates['lat'] = position.latitude;
    _coorDinates['lng'] = position.longitude;
    print('Delivery Address: $_deliveryAddress');
    print('Coordinates in Location ${_coorDinates['lat']}');
    print('Coordinates in Location ${_coorDinates['lng']}');
    // setState(() {});
    notifyListeners();
  }

  Future<void> getAddressFromLocationTwo(Position position) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: false,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 100,
      );
    }

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      // print(position == null
      //     ? 'Unknown'
      //     : '${position.latitude.toString()}, ${position.longitude.toString()}');
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position.longitude,
          localeIdentifier: 'en');
      print('PLACEMARKKKKKKKKKS: $placemarks');
      Placemark place = placemarks[0];
      _address = '${place.subLocality}';
      _deliveryAddress =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      _state = place.administrativeArea!;

      postCode = place.postalCode!;
      addressLine = '${place.street} ${place.thoroughfare}';
      _locality = place.subLocality!;
      city = place.locality!;
      selectedState = place.administrativeArea!;

      print('Initial Address $postCode');
      print('Initial Address $addressLine');
      print('Initial Address $locality');
      print('Initial Address $city');
      print('Initial Address $selectedState');

      _coorDinates['lat'] = position.latitude;
      _coorDinates['lng'] = position.longitude;
      print('Delivery Address: $_deliveryAddress');
      print('Coordinates in Location ${_coorDinates['lat']}');
      print('Coordinates in Location ${_coorDinates['lng']}');
      // setState(() {});
      notifyListeners();
    });
  }

  Future<void> getLocation() async {
    bool hasPermission = await _requestLocationPermission();

    if (hasPermission) {
      Position position = await _getGeoLocationPosition();
      getAddressFromLatLong(position);
    } else {
      print('Location permissions are denied.');
    }

    // getAddressFromLocationTwo(position);
    notifyListeners();
  }
}
