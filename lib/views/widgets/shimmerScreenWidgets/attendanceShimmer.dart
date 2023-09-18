import 'dart:async';
import 'package:claimz/res/components/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/locationPermissions.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/checkInOutViewModel.dart';
import 'package:geolocator/geolocator.dart';
import '../../../viewModel/attendanceViewModel.dart';

// class AttendanceShimmer extends StatefulWidget {
//   Map<String, dynamic> attendanceLatLng;

//   AttendanceShimmerState createState() => AttendanceShimmerState();

//   AttendanceShimmer(this.attendanceLatLng);
// }

class AttendanceShimmer extends StatelessWidget {
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
  bool checkOut = false;
  bool permissionOne = false;
  bool permissionTwo = false;
  bool locationLoader = false;
  dynamic? value;
  double? currentLat;
  double? currentLong;
  double percent = 0.0;

  var greenGradient = const LinearGradient(
    colors: <Color>[
      Color(0XFF00D58D),
      Color(0XFF00C2A0),
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

  @override
  Widget build(BuildContext context) {
    //checkOut == true ? '00' : to turn the timer back to 00

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var hours = twoDigits(duration.inHours);
    var minutes = twoDigits(duration.inMinutes.remainder(60));
    var seconds = twoDigits(duration.inSeconds.remainder(60));

    // TODO: implement build
    return ContainerStyle(
      height: SizeVariables.getHeight(context) * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // color: Colors.red,
            margin:
                EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.008),
            child: Row(
              children: [],
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
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor:
                                    Color.fromARGB(255, 120, 120, 120),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  padding: EdgeInsets.all(
                                    SizeVariables.getHeight(context) * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 65, 65, 65),
                                    borderRadius: BorderRadius.circular(10),
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //       color: Colors.black,
                                    //       spreadRadius: 1,
                                    //       blurRadius: 2,
                                    //       offset: Offset(2, 4))
                                    // ]
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      width: double.infinity,
                                      // color: Colors.pink,
                                      padding: EdgeInsets.all(
                                          SizeVariables.getHeight(context) *
                                              0.02),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor: Color.fromARGB(
                                                    255, 120, 120, 120),
                                                child: Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.015,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.25,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                              // Text(
                                              //   currentTimeStamp == null ||
                                              //           currentTimeStamp == ''
                                              //       ? '00:00:00'
                                              //       : currentTimeStamp!,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyText1!
                                              //       .copyWith(
                                              //           fontSize: 12,
                                              //           color: const Color
                                              //                   .fromARGB(
                                              //               255, 61, 255, 190)),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.015),
                                          Row(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor: Color.fromARGB(
                                                    255, 120, 120, 120),
                                                child: Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.015,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.25,
                                                  color: Colors.amber,
                                                ),
                                              )
                                              // Text(
                                              //   currentTimeStamp == null ||
                                              //           currentTimeStamp == ''
                                              //       ? '00:00:00'
                                              //       : currentTimeStamp!,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyText1!
                                              //       .copyWith(
                                              //           fontSize: 12,
                                              //           color: const Color
                                              //                   .fromARGB(
                                              //               255, 61, 255, 190)),
                                              // )
                                            ],
                                          ),
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
                                              0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor: Color.fromARGB(
                                                    255, 120, 120, 120),
                                                child: Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.015,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.25,
                                                  color: Colors.amber,
                                                ),
                                              )
                                              // Text(
                                              //   currentTimeStamp == null ||
                                              //           currentTimeStamp == ''
                                              //       ? '00:00:00'
                                              //       : currentTimeStamp!,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyText1!
                                              //       .copyWith(
                                              //           fontSize: 12,
                                              //           color: const Color
                                              //                   .fromARGB(
                                              //               255, 61, 255, 190)),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.015),
                                          Row(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor: Color.fromARGB(
                                                    255, 120, 120, 120),
                                                child: Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.015,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.25,
                                                  color: Colors.amber,
                                                ),
                                              )
                                              // Text(
                                              //   currentTimeStamp == null ||
                                              //           currentTimeStamp == ''
                                              //       ? '00:00:00'
                                              //       : currentTimeStamp!,
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyText1!
                                              //       .copyWith(
                                              //           fontSize: 12,
                                              //           color: const Color
                                              //                   .fromARGB(
                                              //               255, 61, 255, 190)),
                                              // )
                                            ],
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
                            child: Container(
                              width: double.infinity,
                              // color: Colors.yellow,
                              padding: const EdgeInsets.all(30),
                              child: Container(
                                height: SizeVariables.getHeight(context) * 0.08,
                                width: SizeVariables.getWidth(context) * 0.2,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: greyGradient,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                            255, 83, 80, 80),
                                        spreadRadius: 15,
                                        blurRadius: 15,
                                      ),
                                    ]),
                                child: const Center(
                                  child: Icon(Icons.power_settings_new_outlined,
                                      color: Colors.white, size: 50),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      height: SizeVariables.getHeight(context) *
                                          0.01),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.04,
                                        right: SizeVariables.getWidth(context) *
                                            0.04),
                                    child: SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.008,
                                      child: LinearPercentIndicator(
                                        // animation: true,
                                        // animationDuration: 3600000,
                                        percent: 0.8,
                                        lineHeight:
                                            SizeVariables.getHeight(context) *
                                                0.04,
                                        progressColor: Colors.amber,
                                        backgroundColor: Colors.amber[100],
                                        linearStrokeCap: LinearStrokeCap.round,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:async';
// import 'package:claimz/res/components/alert_dialog.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import '../../../res/components/containerStyle.dart';
// import '../../config/mediaQuery.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../services/locationPermissions.dart';
// import 'package:provider/provider.dart';
// import '../../../viewModel/checkInOutViewModel.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../../viewModel/attendanceViewModel.dart';

// class AttendanceShimmer extends StatefulWidget {
//   Map<String, dynamic> attendanceLatLng;

//   AttendanceShimmerState createState() => AttendanceShimmerState();

//   AttendanceShimmer(this.attendanceLatLng);
// }

// class AttendanceShimmerState extends State<AttendanceShimmer> {
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
//   bool checkOut = false;
//   bool permissionOne = false;
//   bool permissionTwo = false;
//   bool locationLoader = false;
//   dynamic? value;
//   double? currentLat;
//   double? currentLong;
//   double percent = 0.0;

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

//   @override
//   void initState() {
//     // TODO: implement initState
//     difference();
//     initialiseLocalStorage();
//     setState(() {
//       currentLocation =
//           Provider.of<LocationProvider>(context, listen: false).deliveryAddress;
//       // currentLatitude = Provider.of<LocationProvider>(context, listen: false)
//       //     .coorDinates['lat'];
//       // currentLongitude = Provider.of<LocationProvider>(context, listen: false)
//       //     .coorDinates['lng'];
//       officeLatitude = double.parse(widget.attendanceLatLng['lat']);
//       officeLongitude = double.parse(widget.attendanceLatLng['lng']);
//       radius = widget.attendanceLatLng['radius'];
//     });

//     getCurrentDetails();
//     getCheckOutDetails();
//     distanceDifference();
//     super.initState();
//   }

//   void warning() {
//     showDialog(
//         context: context,
//         builder: (context) => CustomDialog(
//               title: 'Denied',
//               subtitle:
//                   'You Do Not have the Adequate Priviledges for this option',
//               onOk: () => Navigator.of(context).pop(),
//               onCancel: () => Navigator.of(context).pop(),
//             ));
//   }

//   void distanceDifference() async {
//     print('LAT LNG: $currentLatitude $currentLongitude');

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
//     timer!.cancel();
//   }

//   void getCurrentDetails() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     String currentDate =
//         format.format(DateTime.parse(DateTime.now().toString()));

//     setState(() {
//       currentLocality = localStorage.getString('checkInlocality') == null ||
//               localStorage.getString('checkInlocality') == ''
//           ? '---'
//           : localStorage.getString('checkInlocality');

//       currentTimeStamp = localStorage.getString('checkInTimeStamp') == null ||
//               localStorage.getString('checkInTimeStamp') == ''
//           ? '00:00:00'
//           : localStorage.getString('checkInTimeStamp');

//       inOut = localStorage.getString('date') == currentDate ? true : false;
//     });

//     if (kDebugMode) {
//       print('isClicked: $isClicked');
//       print('In Out Status: $inOut');
//       print('Current Date: $currentDate');
//       print('Date: ${localStorage.getString('date')}');
//     }
//   }

//   void getCheckOutDetails() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     setState(() {
//       checkOutTimeStamp = localStorage.getString('checkOutTimeStamp') == null ||
//               localStorage.getString('checkOutTimeStamp') == ''
//           ? '00:00:00'
//           : localStorage.getString('checkOutTimeStamp');

//       checkOutLocality = localStorage.getString('checkOutLocality') == null ||
//               localStorage.getString('checkOutLocality') == ''
//           ? '---'
//           : localStorage.getString('checkOutLocality');
//     });
//   }

//   void getCurrentLocation() {
//     print('CLICKED');
//     setState(() {
//       currentLocation =
//           Provider.of<LocationProvider>(context, listen: false).deliveryAddress;
//     });

//     showDialog(
//       context: context,
//       builder: (context) => CustomDialog(
//         title: 'Distance Difference',
//         subtitle: '${value.toString()} Metres',
//         onOk: () => Navigator.of(context).pop(),
//         onCancel: () => Navigator.of(context).pop(),
//       ),
//       // builder: (context) => AlertDialog(
//       //       // content: Column(
//       //       //   children: [

//       //       //   ],
//       //       // ),
//       //       actions: [
//       //         Text('LOCATIONNNNNNNNNN: $currentLocation',
//       //             style: const TextStyle(color: Colors.black)),
//       //         Text('DISTANCE DIFFERENCE: $value',
//       //             style: const TextStyle(color: Colors.black))
//       //       ],
//       //     )
//     );

//     print('LOCATIONNNNNNNNNN: $currentLocation');
//     print('DISTANCE DIFFERENCE: $value');
//     distanceDifference();
//   }

//   void initialiseLocalStorage() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     print('Stored Button Status: ${localStorage.getBool('attendance')}');
//     print(
//         'Stored Button Status: ${localStorage.getString('currentTimeStamp')}');
//     print('Current Time:  ${DateTime.now()}');
//     if (localStorage.getBool('attendance') == true) {
//       setState(() {
//         isClicked = true;
//       });
//     } else {
//       setState(() {
//         isClicked = false;
//       });
//     }
//     print('Initial Valueeeeeeeeeeeeeeee: $isClicked');
//   }

//   void difference() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     // var diff = DateFormat('yyyy-mm-dd hh:mm:ss').format(DateTime.now());
//     var first = localStorage.getString('currentTimeStamp');
//     var dn = DateTime.now();
//     var second = dn.difference(DateTime.parse(first!)).inSeconds;
//     print("IN SECONDS:- ${second}");
//     timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
//   }

//   void startTimer(Map<String, dynamic> data) async {
//     DateTime currentTime = DateTime.now();
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     if (kDebugMode) {
//       print('Current Time: $currentTime');
//       print('Data Type: ${currentTime.runtimeType}');
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
//         .then((value) =>
//             Provider.of<AttendanceViewModel>(context, listen: false)
//                 .getAttendanceList(context));

//     timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
//   }

//   void addTime() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     final addSeconds = 1;

//     setState(() {
//       if (localStorage.getString('currentTimeStamp') == null ||
//           localStorage.getString('currentTimeStamp') == "") {
//         final seconds = duration.inSeconds + addSeconds;
//         duration = Duration(seconds: seconds);
//         percent += 10;
//       } else {
//         var first = localStorage.getString('currentTimeStamp');
//         var dn = DateTime.now();
//         var second = dn.difference(DateTime.parse(first!)).inSeconds;
//         final seconds = second + addSeconds;
//         duration = Duration(seconds: seconds);
//         // percent += 10;
//       }
//       // final seconds = duration.inSeconds + addSeconds;
//       // if (kDebugMode) {
//       //   print('Type: ${seconds.runtimeType}');
//       // }
//     });
//   }

//   void stopTimer(Map<String, dynamic> checkOutData) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     localStorage.remove('currentTimeStamp');
//     // await Provider.of<CheckInOutViewModel>(context, listen: false)
//     //     .checkOutViewModel(checkOutData, context);

//     String timeStamp =
//         dateFormat.format(DateTime.parse(DateTime.now().toString()).toLocal());

//     localStorage.setString('checkOutTimeStamp', timeStamp);

//     localStorage.setString('checkOutLocality',
//         Provider.of<LocationProvider>(context, listen: false).locality);

//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: const Text('Are you sure you want to Checkout?'),
//               content: const Text(
//                   'If you do, you will not be able to login till the next day'),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         checkOut = true;
//                         // percent = 0.0;
//                       });
//                       Provider.of<CheckInOutViewModel>(context, listen: false)
//                           .checkOutViewModel(checkOutData, context)
//                           .then((value) => Provider.of<AttendanceViewModel>(
//                                   context,
//                                   listen: false)
//                               .getAttendanceList(context));
//                       Navigator.of(context).pop();
//                     },
//                     child:
//                         const Text('Yes', style: TextStyle(color: Colors.red))),
//                 TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child:
//                         const Text('No', style: TextStyle(color: Colors.red)))
//               ],
//             ));

//     getCheckOutDetails();

//     timer?.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //checkOut == true ? '00' : to turn the timer back to 00

//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     var hours = twoDigits(duration.inHours);
//     var minutes = twoDigits(duration.inMinutes.remainder(60));
//     var seconds = twoDigits(duration.inSeconds.remainder(60));

//     // TODO: implement build
//     return ContainerStyle(
//       height: SizeVariables.getHeight(context) * 0.4,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             // color: Colors.red,
//             margin:
//                 EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.008),
//             child: Row(
//               children: [
//                 Flexible(
//                   flex: 1,
//                   fit: FlexFit.tight,
//                   child: Container(
//                     padding: EdgeInsets.only(
//                         left: SizeVariables.getWidth(context) * 0.02),
//                     height: SizeVariables.getHeight(context) * 0.04,
//                     // color: Colors.red,
//                     child: Row(
//                       children: [
//                         Radio(
//                             value: 0,
//                             activeColor: Colors.white,
//                             groupValue: selection,
//                             fillColor: MaterialStateProperty.resolveWith<Color>(
//                                 (states) {
//                               if (states.contains(MaterialState.disabled)) {
//                                 return Colors.white;
//                               }
//                               return Colors.white;
//                             }),
//                             onChanged: (onClick) {
//                               setState(() {
//                                 selection = 0;
//                               });
//                               if (kDebugMode) {
//                                 print('SELECTION: $selection');
//                               }
//                             }),
//                         FittedBox(
//                           fit: BoxFit.contain,
//                           child: Text('Office',
//                               style: Theme.of(context).textTheme.bodyText1),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   fit: FlexFit.tight,
//                   child: Container(
//                       height: SizeVariables.getHeight(context) * 0.04,
//                       // color: Colors.green,
//                       child: Row(
//                         children: [
//                           Radio(
//                               value: 1,
//                               activeColor: Colors.white,
//                               groupValue: selection,
//                               fillColor:
//                                   MaterialStateProperty.resolveWith<Color>(
//                                       (states) {
//                                 if (states.contains(MaterialState.disabled)) {
//                                   return widget.attendanceLatLng['workstation']
//                                               [0]['offsite'] ==
//                                           1
//                                       ? Colors.white
//                                       : Colors.grey;
//                                 }
//                                 return widget.attendanceLatLng['workstation'][0]
//                                             ['offsite'] ==
//                                         1
//                                     ? Colors.white
//                                     : Colors.grey;
//                               }),
//                               onChanged: widget.attendanceLatLng['workstation']
//                                           [0]['offsite'] ==
//                                       1
//                                   ? (onClick) {
//                                       setState(() {
//                                         selection = 1;
//                                       });
//                                       if (kDebugMode) {
//                                         print('SELECTION: $selection');
//                                       }
//                                     }
//                                   : (_) => warning()),
//                           FittedBox(
//                             fit: BoxFit.contain,
//                             child: Text('Offsite',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText1!
//                                     .copyWith(
//                                         color: widget.attendanceLatLng[
//                                                         'workstation'][0]
//                                                     ['offsite'] ==
//                                                 1
//                                             ? Colors.white
//                                             : Colors.grey)),
//                           )
//                         ],
//                       )),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   fit: FlexFit.tight,
//                   child: Container(
//                       padding: EdgeInsets.only(
//                           right: SizeVariables.getWidth(context) * 0.02),
//                       height: SizeVariables.getHeight(context) * 0.04,
//                       // color: Colors.blue,
//                       child: Row(
//                         children: [
//                           Radio(
//                               value: 2,
//                               activeColor: Colors.white,
//                               fillColor:
//                                   MaterialStateProperty.resolveWith<Color>(
//                                       (states) {
//                                 if (states.contains(MaterialState.disabled)) {
//                                   return widget.attendanceLatLng['workstation']
//                                               [0]['onsite'] ==
//                                           1
//                                       ? Colors.white
//                                       : Colors.grey;
//                                 }
//                                 return widget.attendanceLatLng['workstation'][0]
//                                             ['onsite'] ==
//                                         1
//                                     ? Colors.white
//                                     : Colors.grey;
//                               }),
//                               groupValue: selection,
//                               onChanged: widget.attendanceLatLng['workstation']
//                                           [0]['onsite'] ==
//                                       1
//                                   ? (onClick) {
//                                       setState(() {
//                                         selection = 2;
//                                       });
//                                       if (kDebugMode) {
//                                         print('SELECTION: $selection');
//                                       }
//                                     }
//                                   : (_) => warning()),
//                           FittedBox(
//                             fit: BoxFit.contain,
//                             child: Text(
//                               'Onsite',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(
//                                       color:
//                                           widget.attendanceLatLng['workstation']
//                                                       [0]['onsite'] ==
//                                                   1
//                                               ? Colors.white
//                                               : Colors.grey),
//                             ),
//                           )
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: SizeVariables.getHeight(context) * 0.01),
//           Expanded(
//             child: Container(
//               // color: Colors.amber,
//               width: double.infinity,
//               child: Row(
//                 children: [
//                   Flexible(
//                     flex: 1,
//                     fit: FlexFit.tight,
//                     child: Container(
//                       height: double.infinity,
//                       // color: Colors.green,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Flexible(
//                             flex: 1,
//                             fit: FlexFit.tight,
//                             child: Container(
//                               width: double.infinity,
//                               // color: Colors.pink,
//                               padding: const EdgeInsets.all(10),
//                               child: Container(
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 padding: EdgeInsets.all(
//                                     SizeVariables.getHeight(context) * 0.01),
//                                 decoration: BoxDecoration(
//                                     color:
//                                         const Color.fromARGB(255, 65, 65, 65),
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color: Colors.black,
//                                           spreadRadius: 1,
//                                           blurRadius: 2,
//                                           offset: Offset(2, 4))
//                                     ]),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Flexible(
//                                       flex: 1,
//                                       child: Container(
//                                         // color: Colors.blue,
//                                         width: double.infinity,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             SizedBox(
//                                               child: Row(
//                                                 children: [
//                                                   Icon(Icons.location_on,
//                                                       color: Colors.white,
//                                                       size: SizeVariables
//                                                               .getHeight(
//                                                                   context) *
//                                                           0.02),
//                                                   Text('Current Location',
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText1!
//                                                           .copyWith(
//                                                               fontSize: 10))
//                                                 ],
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () => getCurrentLocation(),
//                                               child: Icon(Icons.refresh,
//                                                   color: Colors.white,
//                                                   size: SizeVariables.getHeight(
//                                                           context) *
//                                                       0.02),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: SizeVariables.getHeight(context) *
//                                           0.01,
//                                     ),
//                                     Container(
//                                       // color: Colors.red,
//                                       child: Text(
//                                         currentLocation!,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText1!
//                                             .copyWith(fontSize: 11),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 1,
//                             fit: FlexFit.tight,
//                             child: Container(
//                               width: double.infinity,
//                               // color: Colors.amber,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Flexible(
//                                     flex: 1,
//                                     fit: FlexFit.tight,
//                                     child: Container(
//                                       width: double.infinity,
//                                       // color: Colors.pink,
//                                       padding: EdgeInsets.all(
//                                           SizeVariables.getHeight(context) *
//                                               0.02),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 currentTimeStamp == null ||
//                                                         currentTimeStamp == ''
//                                                     ? '00:00:00'
//                                                     : currentTimeStamp!,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                         fontSize: 12,
//                                                         color: const Color
//                                                                 .fromARGB(
//                                                             255, 61, 255, 190)),
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 currentLocality == null ||
//                                                         currentLocality == ''
//                                                     ? ''
//                                                     : currentLocality!,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                         fontSize: 12,
//                                                         color: const Color
//                                                                 .fromARGB(
//                                                             255, 61, 255, 190)),
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     flex: 1,
//                                     fit: FlexFit.tight,
//                                     child: Container(
//                                       width: double.infinity,
//                                       // color: Colors.red,
//                                       padding: EdgeInsets.all(
//                                           SizeVariables.getHeight(context) *
//                                               0.02),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               // Text('Check Out Time: ',
//                                               //     style: Theme.of(context)
//                                               //         .textTheme
//                                               //         .bodyText1!
//                                               //         .copyWith(fontSize: 11)),
//                                               Text(
//                                                 checkOutTimeStamp == null ||
//                                                         checkOutTimeStamp == ''
//                                                     ? '00:00:00'
//                                                     : checkOutTimeStamp!,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                         fontSize: 12,
//                                                         color: const Color
//                                                                 .fromARGB(
//                                                             255, 232, 96, 96)),
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               // Text('Check Out Address: ',
//                                               //     style: Theme.of(context)
//                                               //         .textTheme
//                                               //         .bodyText1!
//                                               //         .copyWith(fontSize: 11)),
//                                               Text(
//                                                 checkOutLocality == null ||
//                                                         checkOutLocality == ''
//                                                     ? '---'
//                                                     : checkOutLocality!,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                         fontSize: 12,
//                                                         color: const Color
//                                                                 .fromARGB(
//                                                             255, 232, 96, 96)),
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     flex: 1,
//                     fit: FlexFit.tight,
//                     child: Container(
//                       height: double.infinity,
//                       // color: Colors.blue,
//                       child: Column(
//                         children: [
//                           Flexible(
//                             flex: 1,
//                             fit: FlexFit.tight,
//                             child: InkWell(
//                               onTap: () => selection == 1 || selection == 2
//                                   ? inOut == true && isClicked == false
//                                       ? null
//                                       : checkInCheckOut()
//                                   : distanceDiff > radius
//                                       ? showDialog(
//                                           context: context,
//                                           builder: (context) => CustomDialog(
//                                               title: 'Invalid Location',
//                                               subtitle:
//                                                   'Checkin Allowed within 200 metres of Office Area',
//                                               onOk: () =>
//                                                   Navigator.of(context).pop(),
//                                               onCancel: () =>
//                                                   Navigator.of(context).pop()))
//                                       : inOut == true && isClicked == false
//                                           ? null
//                                           : checkInCheckOut(),
//                               child: Container(
//                                 width: double.infinity,
//                                 // color: Colors.yellow,
//                                 padding: const EdgeInsets.all(30),
//                                 child: Container(
//                                   height:
//                                       SizeVariables.getHeight(context) * 0.08,
//                                   width: SizeVariables.getWidth(context) * 0.2,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       gradient:
//                                           inOut == true && isClicked == false
//                                               ? greyGradient
//                                               : isClicked == true
//                                                   ? redGradient
//                                                   : greenGradient,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: inOut == true &&
//                                                   isClicked == false
//                                               ? const Color.fromARGB(
//                                                   255, 83, 80, 80)
//                                               : isClicked == true
//                                                   ? const Color.fromARGB(
//                                                           255, 241, 107, 98)
//                                                       .withOpacity(0.2)
//                                                   : const Color(0XFF00D58D)
//                                                       .withOpacity(0.2),
//                                           spreadRadius: 15,
//                                           blurRadius: 15,
//                                         ),
//                                       ]),
//                                   child: const Center(
//                                     child: Icon(
//                                         Icons.power_settings_new_outlined,
//                                         color: Colors.white,
//                                         size: 50),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 1,
//                             fit: FlexFit.tight,
//                             child: Container(
//                               width: double.infinity,
//                               // color: Colors.orange,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   FittedBox(
//                                     fit: BoxFit.contain,
//                                     child: Text(
//                                       // '00:00:00',
//                                       '$hours : $minutes : $seconds',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1!
//                                           .copyWith(fontSize: 30),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                       height: SizeVariables.getHeight(context) *
//                                           0.01),
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         left: SizeVariables.getWidth(context) *
//                                             0.04,
//                                         right: SizeVariables.getWidth(context) *
//                                             0.04),
//                                     child: SizedBox(
//                                       height: SizeVariables.getHeight(context) *
//                                           0.008,
//                                       child: LinearPercentIndicator(
//                                         // animation: true,
//                                         // animationDuration: 3600000,
//                                         percent: 0.8,
//                                         lineHeight:
//                                             SizeVariables.getHeight(context) *
//                                                 0.04,
//                                         progressColor: Colors.amber,
//                                         backgroundColor: Colors.amber[100],
//                                         linearStrokeCap: LinearStrokeCap.round,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void checkInCheckOut() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     setState(() {
//       isClicked = !isClicked;
//     });

//     localStorage.setBool('attendance', isClicked);

//     bool? value = localStorage.getBool('attendance');

//     print('VALUE: $value');

//     Map<String, dynamic> data = {
//       'lat': Provider.of<LocationProvider>(context, listen: false)
//           .coorDinates['lat']
//           .toString(),
//       'lng': Provider.of<LocationProvider>(context, listen: false)
//           .coorDinates['lng']
//           .toString(),
//       'status': isClicked == false ? 'checkout' : 'checkin',
//       'address':
//           Provider.of<LocationProvider>(context, listen: false).deliveryAddress
//     };

//     Map<String, dynamic> checkOutData = {
//       'checkout_lat': Provider.of<LocationProvider>(context, listen: false)
//           .coorDinates['lat']
//           .toString(),
//       'checkout_lng': Provider.of<LocationProvider>(context, listen: false)
//           .coorDinates['lng']
//           .toString(),
//       'checkout_address':
//           Provider.of<LocationProvider>(context, listen: false).deliveryAddress,
//       'id': localStorage.getInt('loginId')
//     };

//     isClicked == false ? stopTimer(checkOutData) : startTimer(data);

//     if (kDebugMode) {
//       isClicked
//           ? print('CHECK IN OUT: $data')
//           : print('CHECK OUT: $checkOutData');
//     }

//     // isClicked
//     //     ? Provider.of<CheckInOutViewModel>(context, listen: false)
//     //         .checkInOutViewModel(data, context)
//     //         .then((value) =>
//     //             Provider.of<AttendanceViewModel>(context, listen: false)
//     //                 .getAttendanceList(context))
//     //     // : showDialog(
//     //     //     context: context,
//     //     //     builder: (context) => CustomDialog(
//     //     //           title: 'Are You Sure You Want To Log Out',
//     //     //           subtitle:
//     //     //               'If You Do, you will not be able to log in till the next working day',
//     //     //           onOk: () =>
//     //     //               Provider.of<CheckInOutViewModel>(context, listen: false)
//     //     //                   .checkOutViewModel(checkOutData, context)
//     //     //                   .then((value) => Provider.of<AttendanceViewModel>(
//     //     //                           context,
//     //     //                           listen: false)
//     //     //                       .getAttendanceList(context)),
//     //     //           onCancel: () => Navigator.of(context).pop(),
//     //     //         ));
//     //     : Provider.of<CheckInOutViewModel>(context, listen: false)
//     //         .checkOutViewModel(checkOutData, context)
//     //         .then((value) =>
//     //             Provider.of<AttendanceViewModel>(context, listen: false)
//     //                 .getAttendanceList(context));
//   }
// }
