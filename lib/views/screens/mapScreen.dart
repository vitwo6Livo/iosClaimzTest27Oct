import 'dart:async';
import 'dart:ui';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../res/components/date_range_picker.dart';
import '../../viewModel/mapMarkers.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  MapScreenState createState() => MapScreenState();

  MapScreen(this.data);
}

class MapScreenState extends State<MapScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );
  // Completer<GoogleMapController> _controller = Completer();
  // Location location = Location();
  List<Marker> markers = [];
  Map<String, dynamic> locationInfo = {};
  bool isLoading = true;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  var selectedDate;
  var address;

  // static CameraPosition kGoogle = const CameraPosition(
  //   target: LatLng(22.5850206, 88.4868687),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<MapMarkers>(context, listen: false)
        .mapMarkers(widget.data)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    print('SENT DATE: ${widget.data}');

    print('SENT DATE: ${widget.data['date']}');
    super.initState();
  }

  // Future<String> getAddress(double latitude, double longitude) async {

  // }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    markers = Provider.of<MapMarkers>(context).markers.isEmpty
        ? []
        : Provider.of<MapMarkers>(context).markers;

    locationInfo = Provider.of<MapMarkers>(context).positionMarkers;

    address = Provider.of<MapMarkers>(context).address;

    print('List Of Addresses: $address');

    // print('INFOOOOOOOOOOOo LOCAAAATIOOOOOON: ${locationInfo['data']}');

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/back button.svg",
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Location',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: () => pickDateRange(widget.data),
                    // showDatePicker(
                    //             builder: (context, child) => Theme(
                    //                   data: ThemeData().copyWith(
                    //                     colorScheme: const ColorScheme.dark(
                    //                       primary: Color(0xffF59F23),
                    //                       surface: Colors.black,
                    //                       onSurface: Colors.white,
                    //                     ),
                    //                     dialogBackgroundColor:
                    //                         const Color.fromARGB(
                    //                             255, 91, 91, 91),
                    //                   ),
                    //                   child: child!,
                    //                 ),
                    //             context: context,
                    // initialDate: DateTime.now(),
                    // firstDate: DateTime(2015),
                    // lastDate: DateTime.now())
                    //         .then((value) {
                    //       setState(() {
                    //         // _dateTimeStart = value;
                    //         selectedDate = dateFormat
                    //             .format(DateTime.parse(value.toString()));
                    //       });
                    //       Provider.of<MapMarkers>(context, listen: false)
                    //           .mapMarkers({
                    //         'user_id': widget.data['user_id'],
                    //         'place_of_posting': widget.data['place_of_posting'],
                    //         'date': selectedDate,
                    //       });
                    //       print('SELECTED DATE: $selectedDate');
                    //       // print('DATE START: $_dateTimeStart');
                    //     }),
                    child:
                        const Icon(Icons.calendar_month, color: Colors.amber)),
              )
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       border: const Border(
              //         bottom: BorderSide(width: 0.06),
              //         top: BorderSide(width: 0.06),
              //         right: BorderSide(width: 0.06),
              //         left: BorderSide(width: 0.06),
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Color.fromARGB(255, 197, 195, 195),
              //           offset: Offset(
              //             3.0,
              //             3.0,
              //           ),
              //           blurRadius: 3.0,
              //           spreadRadius: 1.0,
              //         ), //BoxShadow
              //       ],
              //     ),
              //     width: SizeVariables.getWidth(context) * 0.5,
              //     child: DateRangePicker(
              //       onPressed: pickDateRange,
              //       end: end,
              //       start: start,
              //       // width: double.infinity,
              //     ),
              //   ),
              // ),
            ],
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              // : Stack(
              //     children: [
              //       Container(
              //         child: GoogleMap(
              //           initialCameraPosition: kGoogle,
              //           mapType: MapType.normal,
              //           onMapCreated: (GoogleMapController controller) {
              //             _controller.complete(controller);
              //           },
              //           markers: Set.of(markers),
              //           myLocationEnabled: true,
              //         ),
              //       ),
              //     ],
              //   ),
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.red,
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) => SizedBox(
                          height: constraints.maxHeight / 1,
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(22.5850206, 88.4868687),
                              zoom: 14,
                              minZoom: 8,
                              maxZoom: 16,
                            ),
                            children: [
                              TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.claimz.claimz'),
                              MarkerLayer(markers: markers)
                            ],
                          ),
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.2,
                        minChildSize: 0.2,
                        maxChildSize: 0.6,
                        builder: (context, scrollController) => Container(
                          color: Colors.white,
                          // padding: const EdgeInsets.all(8),
                          child: locationInfo['data'].isEmpty
                              ? const Center(
                                  child: Text('No Records',
                                      style: TextStyle(color: Colors.black)),
                                )
                              : Stack(
                                  children: [
                                    ListView.builder(
                                        // shrinkWrap: true,
                                        // reverse: true,
                                        physics: const ClampingScrollPhysics(),
                                        controller: scrollController,
                                        itemBuilder: (context, index) {
                                          if (index == 0 &&
                                              locationInfo['data'].length > 1) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: const [
                                                  SizedBox(
                                                    width: 50,
                                                    child: Divider(
                                                      thickness: 5,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Swipe up for more',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return InkWell(
                                            onTap: () =>
                                                Provider.of<MapMarkers>(context,
                                                        listen: false)
                                                    .updateMapMarkers(
                                                        locationInfo['data']
                                                            [index]['lat'],
                                                        locationInfo['data']
                                                            [index]['lng']),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: const Border(
                                                    bottom:
                                                        BorderSide(width: 0.06),
                                                    top:
                                                        BorderSide(width: 0.06),
                                                    right:
                                                        BorderSide(width: 0.06),
                                                    left:
                                                        BorderSide(width: 0.06),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 197, 195, 195),
                                                      offset: Offset(
                                                        3.0,
                                                        3.0,
                                                      ),
                                                      blurRadius: 3.0,
                                                      spreadRadius: 1.0,
                                                    ), //BoxShadow
                                                  ],
                                                ),
                                                // color: Colors.white,
                                                width: double.infinity,
                                                // height: 23,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .lock_clock,
                                                                        color: Color(
                                                                            0xffF59F23),
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          locationInfo['data'][index]['created_at']
                                                                              .split(' ')[1],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .copyWith(
                                                                                color: Colors.black,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Color(
                                                                            0xffF59F23),
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          locationInfo['data'][index]['created_at']
                                                                              .split(' ')[0],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .copyWith(
                                                                                color: Colors.black,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .social_distance,
                                                                    color: Color(
                                                                        0xffF59F23),
                                                                    size: 20,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '${locationInfo['data'][index]['distance'].toStringAsFixed(2)} metre(s)',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2!
                                                                          .copyWith(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                16,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // padding: EdgeInsets.all(2),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.pin_drop,
                                                                color: Color(
                                                                    0xffF59F23),
                                                                size: 30),
                                                            Expanded(
                                                              child: Text(
                                                                locationInfo['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'address'] ??
                                                                    'Address',
                                                                // address[index]['address'],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: locationInfo['data'].length),
                                    // const Icon(Icons.arrow_upward, color: Colors.black)
                                  ],
                                ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }

  Future pickDateRange(dynamic data) async {
    isLoading = true;
    // DateTimeRange? newDateRange = await showDateRangePicker(
    //     saveText: 'SET',
    //     context: context,
    //     builder: (context, child) => Theme(
    //           data: ThemeData().copyWith(
    //             colorScheme: const ColorScheme.dark(
    //               primary: Color(0xffF59F23),
    //               surface: Colors.black,
    //               onSurface: Colors.grey,
    //             ),
    //             dialogBackgroundColor: const Color.fromARGB(255, 91, 91, 91),
    //           ),
    //           child: child!,
    //         ),
    //     firstDate: DateTime(1900),
    //     lastDate: DateTime(2100),
    //     initialDateRange: dateRange

    print('Sent Data: $data');
    //     );

    showDatePicker(
            builder: (context, child) => Theme(
                  data: ThemeData().copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xffF59F23),
                      surface: Colors.black,
                      onSurface: Colors.white,
                    ),
                    dialogBackgroundColor:
                        const Color.fromARGB(255, 91, 91, 91),
                  ),
                  child: child!,
                ),
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime.now())
        .then((value) {
      Provider.of<MapMarkers>(context, listen: false).mapMarkers({
        'device_id': data['device_id'],
        'place_of_posting': data['place_of_posting'],
        'date': DateFormat('yyyy-MM-dd').format(value!),
      }).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
    //     .then((value) {
    //   setState(() {
    //     // _dateTimeStart = value;
    //     selectedDate = dateFormat
    //         .format(DateTime.parse(value.toString()));
    //   });
    //   Provider.of<MapMarkers>(context, listen: false)
    //       .mapMarkers({
    //     'user_id': widget.data['user_id'],
    //     'place_of_posting': widget.data['place_of_posting'],
    //     'date': selectedDate,
    //   });
    //   print('SELECTED DATE: $selectedDate');
    //   // print('DATE START: $_dateTimeStart');
    // });

    // if (selectedDate == null) return;

    // setState(() {
    //   dateRange = newDateRange;
    //   // isLoading = true;
    // });

    print('dateRange: $dateRange');
    return dateRange;
  }
}
