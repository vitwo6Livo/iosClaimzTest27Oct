import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class MapMarkers with ChangeNotifier {
  Map<String, dynamic> _positionMarkers = {};

  Map<String, String> _addresses = {};

  String? fetchAddress;

  List<Marker> _markers = [
    // Marker(
    //   markerId: MarkerId('1'),
    //   position: LatLng(22.6434340, 88.446740),
    //   infoWindow: InfoWindow(title: 'Station one'),
    // ),
    // Marker(
    //   markerId: MarkerId('2'),
    //   position: LatLng(22.6435442, 88.456742),
    //   infoWindow: InfoWindow(title: 'Station Two'),
    // ),
    // Marker(
    //   markerId: MarkerId('3'),
    //   position: LatLng(22.6436544, 88.466744),
    //   infoWindow: InfoWindow(title: 'Station Three'),
    // ),
    // Marker(
    //   markerId: MarkerId('4'),
    //   position: LatLng(22.6437646, 88.476746),
    //   infoWindow: InfoWindow(title: 'Station Three'),
    // ),
    // Marker(
    //   markerId: MarkerId('5'),
    //   position: LatLng(22.6438748, 88.486748),
    //   infoWindow: InfoWindow(title: 'Station Three'),
    // )
  ];

  List<Map<String, dynamic>> _address = [];

  List<Marker> get markers {
    return [..._markers];
  }

  List<Map<String, dynamic>> get address {
    return [..._address];
  }

  Map<String, dynamic> get positionMarkers {
    return {..._positionMarkers};
  }

  Future<String> convertLatLngToAddress(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        fetchAddress =
            "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";

        //  _addresses['address'] = address;

        // _address.add(_addresses);
        // print('Address: $address');
      } else {
        print('No address found');
      }
    } catch (e) {
      print('Error: $e');
    }
    return fetchAddress!;
  }

  Future<void> mapMarkers(dynamic data) async {
    print('Input Date: $data');

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    _markers = [];

    final response = await http.post(Uri.parse(AppUrl.employeeLocation),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _positionMarkers = json.decode(response.body);
      if (_positionMarkers['data'].isEmpty) {
        _markers = [];
      } else {
        print('LOCAAAAAAAATIONS: $_positionMarkers');
        for (int i = 0; i < _positionMarkers['data'].length; i++) {
          // _markers.add(Marker(
          //     markerId: MarkerId(_positionMarkers['data'][i]['id'].toString()),
          //     position: LatLng(double.parse(_positionMarkers['data'][i]['lat']),
          //         double.parse(_positionMarkers['data'][i]['lng'])),
          //     // infoWindow:
          //     //     InfoWindow(title: _positionMarkers['data'][i]['time'])
          //         )
          //         );

          // convertLatLngToAddress(
          //         double.parse(_positionMarkers['data'][i]['lat']),
          //         double.parse(_positionMarkers['data'][i]['lng']))
          //     .then((address) {
          //   String key = 'address';
          //   String value = address;

          //   _positionMarkers['data'].forEach((map) {
          //     map[key] = value;
          //   });
          // });

          _markers.add(Marker(
            point: LatLng(double.parse(_positionMarkers['data'][i]['lat']),
                double.parse(_positionMarkers['data'][i]['lng'])),
            builder: (context) => RippleAnimation(
                color: Colors.blue,
                repeat: true,
                minRadius: 25,
                ripplesCount: 2,
                child: const Icon(Icons.man, size: 30, color: Colors.amber)),
          ));
        }

        // _markers.add(Marker(
        //     point: LatLng(
        //         double.parse(_positionMarkers['data']
        //             [_positionMarkers['data'].length - 1]['lat']),
        //         double.parse(_positionMarkers['data']
        //             [_positionMarkers['data'].length - 1]['lng'])),
        //     builder: (context) =>
        //     RippleAnimation(
        // color: Colors.blue,
        // repeat: true,
        // minRadius: 25,
        // ripplesCount: 2,
        //         child: const Icon(Icons.man, size: 30, color: Colors.amber))
        //     // RippleAnimation(
        //     //   color: Colors.blue,
        //     //   repeat: true,
        //     //   minRadius: 15,
        //     //   ripplesCount: 2,
        //     //   child: SvgPicture.asset("assets/icons/Man.svg")
        //     //   // child: const Icon(Icons.location_pin, color: Colors.amber),
        //     //   ),
        //     ));

        print('MARKERS: $_positionMarkers');
      }
    } else {
      _positionMarkers = {'error': 'Something went wrong'};
    }
    notifyListeners();
  }

  void updateMapMarkers(String lat, String lng) {
    print('CHANGED LAT LNG: $lat $lng');

    _markers.add(Marker(
        point: LatLng(double.parse(lat), double.parse(lng)),
        builder: (context) =>
            const Icon(Icons.man, size: 30, color: Colors.amber)
        // SvgPicture.asset(
        //   "assets/icons/Man.svg",
        //   // height: 30,
        // ),
        // const Icon(Icons.pin_drop, color: Colors.amber, size: 30),
        ));
    notifyListeners();
  }
}
