// import 'dart:io';

// import 'package:another_flushbar/flushbar.dart';
// import 'package:claimz/utils/routes/routeNames.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:edge_detection/edge_detection.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../data/response/status.dart';
// import '../../../viewModel/claimzFormIndividualViewModel.dart';
// import '../../../viewModel/claimzHistoryViewModel.dart';
// import '../../widgets/historyClaimListWidget/accordionClaimWidget.dart';
// import '../../widgets/historyClaimListWidget/claimListWidget.dart';
// import 'claimzHistory.dart';

// class HistoryClaimList extends StatefulWidget {
//   Map arguments;
//   HistoryClaimList(Map this.arguments);

//   // const HistoryClaimList({Key? key}) : super(key: key);
//   @override
//   State<HistoryClaimList> createState() => _HistoryClaimListState();
// }

// class _HistoryClaimListState extends State<HistoryClaimList> {
//   int role = 0;

//   DateTime? _dateTime;
//   DateFormat dateFormat = DateFormat('dd-MM-yyyy');
//   // var myYears1 = "Mode of Travel";
//   var myYears1;
//   var isClicked = false;

//   String status_travel = "";
//   String status_food = "";
//   String status_incidental = "";

//   TextEditingController _distance_in_km = new TextEditingController();
//   TextEditingController _travel_name_of_serviceprovider =
//       new TextEditingController();
//   TextEditingController _travel_basic_amt = new TextEditingController();
//   TextEditingController _travel_gst_amt = new TextEditingController();
//   TextEditingController _travel_total_amt = new TextEditingController();
//   TextEditingController _travel_bill_no = new TextEditingController();
//   TextEditingController _travel_gst_no = new TextEditingController();

//   TextEditingController _food_name_of_serviceprovider =
//       new TextEditingController();
//   TextEditingController _food_basic_amt = new TextEditingController();
//   TextEditingController _food_gst_amt = new TextEditingController();
//   TextEditingController _food_total_amt = new TextEditingController();
//   TextEditingController _food_gst_no = new TextEditingController();
//   TextEditingController _food_bill_no = new TextEditingController();

//   TextEditingController _ie_name_of_serviceprovider =
//       new TextEditingController();
//   TextEditingController _ie_basic_amt = new TextEditingController();
//   TextEditingController _ie_gst_amt = new TextEditingController();
//   TextEditingController _ie_total_amt = new TextEditingController();
//   TextEditingController _ie_gst_no = new TextEditingController();
//   TextEditingController _ie_bill_no = new TextEditingController();
//   ClaimzHistoryViewModel claimz_list = ClaimzHistoryViewModel();

//   String _distance_in_km_val = '';
//   String _travel_name_of_serviceprovider_val = '';
//   String _travel_basic_amt_val = '';
//   String _travel_gst_amt_val = '';
//   String _travel_total_amt_val = '';

//   String _food_name_of_serviceprovider_val = '';
//   String _food_basic_amt_val = '';
//   String _food_gst_amt_val = '';
//   String _food_total_amt_val = '';
//   String _food_gst_no_val = '';
//   String _food_bill_no_val = '';

//   String _ie_name_of_serviceprovider_val = '';
//   String _ie_basic_amt_val = '';
//   String _ie_gst_amt_val = '';
//   String _ie_total_amt_val = '';
//   String _ie_gst_no_val = '';
//   String _ie_bill_no_val = "";

//   double limit_travel_own_bike = 0.0;
//   double limit_travel_own_car_d = 0.0;
//   double limit_travel_own_car_p = 0.0;
//   double limit_travel_public_transport = 0.0;
//   double limit_travel_company_vehical = 0.0;
//   double limit_food = 0.0;
//   double limit_incidental = 0.0;
//   final ImagePicker _picker = ImagePicker();

//   XFile? _travel_file;
//   XFile? _food_file;
//   XFile? _ie_file;

//   int _pagestart = 0;

//   ClaimzFormIndividualViewModel _claimzFormData =
//       ClaimzFormIndividualViewModel();

//   // List<String> year1 = [
//   //   "Mode of Travel",
//   //   "Own Bike",
//   //   "Own Car(Diesel)",
//   //   "Own Car(Petrol)",
//   //   "Public Transport",
//   //   "Company Vehicle",
//   // ];
//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   bool clicked() {
//     setState(() {
//       isClicked = !isClicked;
//     });
//     return isClicked;
//   }

//   @override
//   void initState() {
//     _pagestart = 0;

//     initialiseRole();

//     // var ownBike = Provider.of<ClaimzFormIndividualViewModel>(context).ownBike;
//     // var publicTransport =
//     //     Provider.of<ClaimzFormIndividualViewModel>(context).public;
//     // var ownCarP = Provider.of<ClaimzFormIndividualViewModel>(context).ownCarP;
//     // var ownCarD = Provider.of<ClaimzFormIndividualViewModel>(context).ownCarD;
//     // var companyVehicle =
//     //     Provider.of<ClaimzFormIndividualViewModel>(context).compVehicle;

//     // // limit_travel_own_bike = double.parse(ownBike.toString());
//     // print('OWN BIKE $ownBike');
//     // // limit_travel_own_car_d = double.parse(ownCarD.toString());
//     // print('OWN CARd $ownCarD');

//     // // limit_travel_own_car_p = double.parse(ownCarP.toString());
//     // print('OWN CARp $ownCarP');

//     // // limit_travel_public_transport = double.parse(publicTransport.toString());
//     // print('PUBLIC TRANSPORT $publicTransport');

//     // // limit_travel_company_vehical = double.parse(companyVehicle.toString());
//     // print('COMPANY VEHICLE $companyVehicle');

//     super.initState();
//     final Map<String, dynamic> _data = {
//       'doc_no': widget.arguments["doc_no"],
//     };

//     _claimzFormData.getClaimzLimit(_data, context);

//     _distance_in_km.addListener(() {
//       if (myYears1 == "Mode of Travel" || myYears1 == null) {
//         Flushbar(
//           message:
//               "Please provide the mode of travel before providing distance",
//           icon: Icon(
//             Icons.info_outline,
//             size: 28.0,
//             color: Colors.blue,
//           ),
//           duration: Duration(seconds: 3),
//           leftBarIndicatorColor: Colors.blue,
//         )..show(context);
//       } else if (myYears1 == "1") {
//         print('Travel Own Bike $limit_travel_own_bike');
//         setState(() {
//           _travel_basic_amt.text =
//               (limit_travel_own_bike * int.parse(_distance_in_km.text))
//                   .toString();
//           _travel_total_amt.text =
//               (limit_travel_own_bike * int.parse(_distance_in_km.text))
//                   .toString();
//         });
//       } else if (myYears1 == "2") {
//         _travel_basic_amt.text =
//             (limit_travel_own_car_d * int.parse(_distance_in_km.text))
//                 .toString();
//         _travel_total_amt.text =
//             (limit_travel_own_bike * int.parse(_distance_in_km.text))
//                 .toString();
//       } else if (myYears1 == "3") {
//         _travel_basic_amt.text =
//             (limit_travel_own_car_p * int.parse(_distance_in_km.text))
//                 .toString();
//         _travel_total_amt.text =
//             (limit_travel_own_bike * int.parse(_distance_in_km.text))
//                 .toString();
//       } else if (myYears1 == "4") {
//         _travel_basic_amt.text =
//             (limit_travel_public_transport * int.parse(_distance_in_km.text))
//                 .toString();
//         _travel_total_amt.text =
//             (limit_travel_own_bike * int.parse(_distance_in_km.text))
//                 .toString();
//       } else if (myYears1 == "5") {
//         _travel_basic_amt.text =
//             (limit_travel_company_vehical * int.parse(_distance_in_km.text))
//                 .toString();
//         _travel_total_amt.text =
//             (limit_travel_own_bike * int.parse(_distance_in_km.text))
//                 .toString();
//       }
//     });

//     _travel_gst_amt.addListener(() {
//       setState(() {
//         _travel_total_amt.text = (double.parse(_travel_basic_amt.text) +
//                 double.parse(_travel_gst_amt.text))
//             .toString();
//       });
//     });

//     // _food_basic_amt.addListener(() {
//     //   if (double.parse(_food_basic_amt.text) > limit_food) {
//     //     setState(() {
//     //       _food_basic_amt.text = limit_food.toString();
//     //     });
//     //   }
//     // });

//     // _ie_basic_amt.addListener(() {
//     //   if (double.parse(_ie_basic_amt.text) > limit_incidental) {
//     //     setState(() {
//     //       _ie_basic_amt.text = limit_incidental.toString();
//     //     });
//     //   }
//     // });
//   }

//   void initialiseRole() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     setState(() {
//       role = localStorage.getInt('role')!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigator.pushNamed(context, );
//         Navigator.of(context).pop();
//         Navigator.pushNamed(context, RouteNames.claimzhistory);
//         // Navigator.of(context).pushAndRemoveUntil(
//         //     MaterialPageRoute(builder: (context) => ClaimzHistory()),
//         //     (route) => true);
//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (context) => ClaimzHistory()));
//         return false;
//       },
//       child: Stack(
//         children: [
//           // Image.asset(
//           //   "assets/img/bg.png",
//           //   height: MediaQuery.of(context).size.height,
//           //   width: MediaQuery.of(context).size.width,
//           //   fit: BoxFit.cover,
//           // ),
//           Scaffold(
//             backgroundColor: Colors.black,
//             body: Container(
//               padding: EdgeInsets.only(
//                 left: SizeVariables.getWidth(context) * 0.03,
//                 right: SizeVariables.getWidth(context) * 0.04,
//               ),
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: SizeVariables.getHeight(context) * 0.02),
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             // Navigator.pushNamed(
//                             //     context, RouteNames.claimzhistory);
//                             Navigator.of(context).pop();
//                             Navigator.pushNamed(
//                                 context, RouteNames.claimzhistory);
//                           },
//                           child: SvgPicture.asset(
//                             "assets/icons/back button.svg",
//                           ),
//                         ),
//                         // ProfilededarWidget(),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: SizeVariables.getHeight(context) * 0.01,
//                               left: SizeVariables.getWidth(context) * 0.01),
//                           child: Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 FittedBox(
//                                   fit: BoxFit.contain,
//                                   child: Text(
//                                     'Claim Form Submission',
//                                     style: Theme.of(context).textTheme.caption,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                     width:
//                                         SizeVariables.getWidth(context) * 0.05),
//                                 Container(
//                                     height:
//                                         SizeVariables.getHeight(context) * 0.05,
//                                     width:
//                                         SizeVariables.getHeight(context) * 0.05,
//                                     // color: Colors.red,
//                                     child: Lottie.asset(
//                                         'assets/json/final_submit.json'))
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Container(
//                         //   color: Colors.red,
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.end,
//                         //     children: [
//                         //       Lottie.asset('assets/json/final_submit.json'),
//                         //     ],
//                         //   ),
//                         // )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeVariables.getHeight(context) * 0.02,
//                   ),
//                   // ClaimListWidget(widget.arguments),
//                   // SizedBox(
//                   //   height: SizeVariables.getHeight(context) * 0.02,
//                   // ),
//                   Container(
//                     // color: Colors.amber,
//                     height: SizeVariables.getHeight(context) * 0.15,
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           // color: Colors.blue,
//                           height: SizeVariables.getHeight(context) * 0.13,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     height: SizeVariables.getHeight(context) *
//                                         0.045,
//                                     width:
//                                         SizeVariables.getWidth(context) * 0.4,
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 17, 17, 17),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Center(
//                                       child: FittedBox(
//                                         fit: BoxFit.contain,
//                                         child: Text(
//                                           widget.arguments["date"],
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     // padding: EdgeInsets.all(8),
//                                     height: SizeVariables.getHeight(context) *
//                                         0.045,
//                                     width:
//                                         SizeVariables.getWidth(context) * 0.4,
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 17, 17, 17),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Center(
//                                       child: FittedBox(
//                                         fit: BoxFit.contain,
//                                         child: Text(
//                                           "Doc No : " +
//                                               widget.arguments["doc_no"],
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: SizeVariables.getHeight(context) * 0.01,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Container(
//                                     height: SizeVariables.getHeight(context) *
//                                         0.045,
//                                     decoration: BoxDecoration(
//                                       color: Color.fromARGB(255, 17, 17, 17),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Center(
//                                       child: FittedBox(
//                                         fit: BoxFit.contain,
//                                         child: Text(
//                                           widget.arguments["from"] +
//                                               " to " +
//                                               widget.arguments["to"],
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // AccordionClaim(widget.arguments),
//                   ChangeNotifierProvider<ClaimzFormIndividualViewModel>(
//                     create: (context) => _claimzFormData,
//                     child: Consumer<ClaimzFormIndividualViewModel>(
//                       builder: (context, value, child) {
//                         switch (value.claimz_user_limit.status) {
//                           case Status.LOADING:
//                             return Center(child: CircularProgressIndicator());
//                           case Status.ERROR:
//                             return Center(
//                               child: Text(
//                                   value.claimz_user_limit.message.toString()),
//                             );
//                           case Status.COMPLETED:
//                             Future.delayed(Duration(milliseconds: 300), () {
//                               setState(() {
//                                 status_travel = value
//                                     .claimz_user_limit!.data!.travelStatus
//                                     .toString();
//                                 status_food = value
//                                     .claimz_user_limit!.data!.foodStatus
//                                     .toString();
//                                 status_incidental = value
//                                     .claimz_user_limit!.data!.incidentalStatus
//                                     .toString();

//                                 _distance_in_km_val = value.claimz_user_limit!
//                                     .data!.travelData.distance
//                                     .toString();
//                                 _travel_name_of_serviceprovider_val = value
//                                     .claimz_user_limit!
//                                     .data!
//                                     .travelData
//                                     .serviceProvider
//                                     .toString();
//                                 _travel_basic_amt_val = value.claimz_user_limit!
//                                     .data!.travelData.basicAmount
//                                     .toString();
//                                 _travel_gst_amt_val = value.claimz_user_limit!
//                                     .data!.travelData.gSTAmount
//                                     .toString();
//                                 _travel_total_amt_val = value.claimz_user_limit!
//                                     .data!.travelData.totalAmount
//                                     .toString();

//                                 _food_name_of_serviceprovider_val = value
//                                     .claimz_user_limit!
//                                     .data!
//                                     .foodData
//                                     .serviceProvider
//                                     .toString();
//                                 _food_basic_amt_val = value.claimz_user_limit!
//                                     .data!.foodData.basicAmount
//                                     .toString();
//                                 _food_gst_amt_val = value
//                                     .claimz_user_limit!.data!.foodData.gSTAmount
//                                     .toString();
//                                 _food_total_amt_val = value.claimz_user_limit!
//                                     .data!.foodData.totalAmount
//                                     .toString();
//                                 _food_gst_no_val = value
//                                     .claimz_user_limit!.data!.foodData.gSTNo
//                                     .toString();
//                                 // _food_bill_no_val =  value.claimz_user_limit!.data!.foodData.bill_no.toString();

//                                 _ie_name_of_serviceprovider_val = value
//                                     .claimz_user_limit!
//                                     .data!
//                                     .incidentData
//                                     .serviceProvider
//                                     .toString();
//                                 _ie_basic_amt_val = value.claimz_user_limit!
//                                     .data!.incidentData.basicAmount
//                                     .toString();
//                                 _ie_gst_amt_val = value.claimz_user_limit!.data!
//                                     .incidentData.gSTAmount
//                                     .toString();
//                                 _ie_total_amt_val = value.claimz_user_limit!
//                                     .data!.incidentData.totalAmount
//                                     .toString();
//                                 _ie_gst_no_val = value
//                                     .claimz_user_limit!.data!.incidentData.gSTNo
//                                     .toString();
//                                 // _ie_bill_no_val =  value.claimz_user_limit!.data!.incidentData.bill_no.toString();

//                                 if (_pagestart == 0) {
//                                   _dataFeeding();
//                                   _pagestart = 1;
//                                 }
//                               });

//                               if (myYears1 == "1") {
//                                 setState(() {
//                                   limit_travel_own_bike = double.parse(value
//                                       .claimz_user_limit
//                                       .data!
//                                       .travel![0]
//                                       .limitPerKm
//                                       .toString());
//                                 });
//                                 print('Own Bike: $limit_travel_own_bike');
//                               } else if (myYears1 == "2") {
//                                 setState(() {
//                                   limit_travel_own_car_d = double.parse(value
//                                       .claimz_user_limit
//                                       .data!
//                                       .travel![1]
//                                       .limitPerKm
//                                       .toString());
//                                 });
//                               } else if (myYears1 == "3") {
//                                 setState(() {
//                                   limit_travel_public_transport = double.parse(
//                                       value.claimz_user_limit.data!.travel![2]
//                                           .limitPerKm
//                                           .toString());
//                                 });
//                               } else if (myYears1 == "4") {
//                                 setState(() {
//                                   limit_travel_own_car_p = double.parse(value
//                                       .claimz_user_limit
//                                       .data!
//                                       .travel![3]
//                                       .limitPerKm
//                                       .toString());
//                                 });
//                               } else if (myYears1 == "5") {
//                                 setState(() {
//                                   limit_travel_company_vehical = double.parse(
//                                       value.claimz_user_limit.data!.travel![4]
//                                           .limitPerKm
//                                           .toString());
//                                 });
//                               }

//                               setState(() {
//                                 limit_food = double.parse(value
//                                     .claimz_user_limit.data!.food![0].limit
//                                     .toString());
//                                 limit_incidental = double.parse(value
//                                     .claimz_user_limit
//                                     .data!
//                                     .incidental![0]
//                                     .limit
//                                     .toString());
//                               });
//                             });

//                             return Column(
//                               children: [
//                                 Container(
//                                   height:
//                                       SizeVariables.getHeight(context) * 0.69,
//                                   // color: Colors.red,
//                                   child: ListView(
//                                     children: [
//                                       buildCard('Travel', '', value),
//                                       buildCard1(
//                                         'Food',
//                                         '',
//                                       ),
//                                       buildCard2(
//                                         'Incidental Expanse',
//                                         '',
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           case Status.ERROR:
//                             print("ERROR");
//                         }
//                         return Container();
//                       },
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

//   Widget buildCard(
//     String title,
//     String text,
//     ClaimzFormIndividualViewModel value,
//   ) =>
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           color: Colors.black,
//           child: ExpandablePanel(
//             header: Text(title, style: TextStyle(color: Colors.white)),
//             collapsed: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         // _travel_file =
//                         //     await _picker.pickImage(source: ImageSource.camera);
//                         FocusScope.of(context).unfocus();
//                         var imagePath = await EdgeDetection.detectEdge;
//                         _travel_file = XFile(File(imagePath.toString()).path);
//                       },
//                       child: Container(
//                         // color: Colors.red,
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: SizeVariables.getWidth(context) * 0.02,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         // final List<XFile>? travel_file = await _picker.pickMultiImage();
//                         FocusScope.of(context).unfocus();
//                         var imagePath = await EdgeDetection.detectEdge;
//                         _travel_file = XFile(File(imagePath.toString()).path);
//                       },
//                       child: Container(
//                         // color: Colors.red,
//                         child: const Icon(
//                           Icons.upload_file_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     // SizedBox(
//                     //   width: SizeVariables.getWidth(context) * 0.02,
//                     // ),
//                     // InkWell(
//                     //   onTap: () async {
//                     //     _travel_file =
//                     //         await _picker.pickImage(source: ImageSource.camera);
//                     //   },
//                     //   child: Container(
//                     //     // color: Colors.red,
//                     //     child: const Icon(
//                     //       Icons.camera_alt,
//                     //       color: Colors.white,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 50,
//                       child: Container(
//                         height: SizeVariables.getHeight(context) * 0.04,
//                         width: SizeVariables.getWidth(context) * 0.4,
//                         // decoration: BoxDecoration(
//                         //   color: Color.fromARGB(255, 17, 17, 17),
//                         //   borderRadius: BorderRadius.circular(12),
//                         // ),
//                         child: DropdownButton<String>(
//                             underline: Container(),
//                             elevation: 10,
//                             iconSize: 20,
//                             hint: Text('Mode Of Travel',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText1!
//                                     .copyWith(fontSize: 12)),
//                             icon: Padding(
//                               padding: EdgeInsets.only(
//                                   left: SizeVariables.getWidth(context) * 0.03),
//                               child: const Icon(
//                                 Icons.expand_more,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             dropdownColor: Colors.grey,
//                             onChanged: (value) {
//                               setState(() {
//                                 myYears1 = value!;
//                               });
//                               print('SELECTED CHOICE: $myYears1');
//                             },
//                             value: myYears1,
//                             // year1.map((item) {
//                             items:
//                                 value.claimz_user_limit.data!.travel!.map((e) {
//                               return DropdownMenuItem(
//                                   alignment: Alignment.topLeft,
//                                   // value: e.componentName.toString(),
//                                   value: e.conveyanceId.toString(),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: SizeVariables.getWidth(context) *
//                                             0.04),
//                                     child: Text(
//                                       e.componentName.toString(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1!
//                                           .copyWith(fontSize: 12),
//                                     ),
//                                   ));
//                             }).toList()
//                             // items: year1.map((item) {
//                             // return DropdownMenuItem(
//                             //     alignment: Alignment.topLeft,
//                             //     value: item,
//                             //     child: Padding(
//                             //       padding: EdgeInsets.only(
//                             //           left: SizeVariables.getWidth(context) *
//                             //               0.04),
//                             //       child: Text(
//                             //         item,
//                             //         style: Theme.of(context)
//                             //             .textTheme
//                             //             .bodyText1!
//                             //             .copyWith(fontSize: 12),
//                             //       ),
//                             //     ));
//                             // }).toList(),
//                             ),
//                       ),
//                     ),
//                     myYears1 == "3"
//                         ? Expanded(
//                             flex: 50,
//                             child: Container(
//                               // color: Colors.amber,
//                               // padding: EdgeInsets.all(8),
//                               height: SizeVariables.getHeight(context) * 0.075,
//                               width: SizeVariables.getWidth(context) * 0.4,
//                               // decoration: BoxDecoration(
//                               //   color: Color.fromARGB(255, 17, 17, 17),
//                               //   borderRadius: BorderRadius.circular(12),
//                               // ),
//                               child: Center(
//                                 child: TextFormField(
//                                   readOnly:
//                                       widget.arguments['flag'] == 1 && role == 1
//                                           ? true
//                                           : false,
//                                   controller: _travel_name_of_serviceprovider,
//                                   decoration: InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           width: 2, color: Colors.white),
//                                     ),
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           width: 2, color: Colors.white),
//                                     ),
//                                     // border: InputBorder.none,
//                                     labelText: 'Name of Service Provider',
//                                     labelStyle: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(fontSize: 12),
//                                   ),
//                                   style: Theme.of(context).textTheme.bodyText1,
//                                   showCursor: false,
//                                   cursorColor: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Container(),
//                   ],
//                 ),
//                 // SizedBox(
//                 //   height: SizeVariables.getHeight(context) * 0.01,
//                 // ),
//                 myYears1 == "3"
//                     ? Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             // color: Colors.amber,
//                             // padding: EdgeInsets.all(8),
//                             height: SizeVariables.getHeight(context) * 0.075,
//                             width: SizeVariables.getWidth(context) * 0.4,
//                             // decoration: BoxDecoration(
//                             //   color: Color.fromARGB(255, 17, 17, 17),
//                             //   borderRadius: BorderRadius.circular(12),
//                             // ),
//                             child: Center(
//                               child: TextFormField(
//                                 controller: _travel_gst_no,
//                                 readOnly:
//                                     widget.arguments['flag'] == 1 && role == 1
//                                         ? true
//                                         : false,
//                                 inputFormatters: [
//                                   LengthLimitingTextInputFormatter(15)
//                                 ],
//                                 decoration: InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                     //<-- SEE HERE
//                                     borderSide: BorderSide(
//                                         width: 2, color: Colors.white),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     //<-- SEE HERE
//                                     borderSide: BorderSide(
//                                         width: 2, color: Colors.white),
//                                   ),
//                                   // border: InputBorder.none,
//                                   labelText: 'GST No',
//                                   labelStyle: Theme.of(context)
//                                       .textTheme
//                                       .bodyText1!
//                                       .copyWith(fontSize: 12),
//                                 ),
//                                 style: Theme.of(context).textTheme.bodyText1,
//                                 showCursor: false,
//                                 cursorColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             // color: Colors.amber,
//                             // padding: EdgeInsets.all(8),
//                             height: SizeVariables.getHeight(context) * 0.075,
//                             width: SizeVariables.getWidth(context) * 0.4,
//                             // decoration: BoxDecoration(
//                             //   color: Color.fromARGB(255, 17, 17, 17),
//                             //   borderRadius: BorderRadius.circular(12),
//                             // ),
//                             child: Center(
//                               child: TextFormField(
//                                 controller: _travel_bill_no,
//                                 decoration: InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                     //<-- SEE HERE
//                                     borderSide: BorderSide(
//                                         width: 2, color: Colors.white),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     //<-- SEE HERE
//                                     borderSide: BorderSide(
//                                         width: 2, color: Colors.white),
//                                   ),
//                                   // border: InputBorder.none,
//                                   labelText: 'Bill No',
//                                   labelStyle: Theme.of(context)
//                                       .textTheme
//                                       .bodyText1!
//                                       .copyWith(fontSize: 12),
//                                 ),
//                                 style: Theme.of(context).textTheme.bodyText1,
//                                 showCursor: false,
//                                 cursorColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : Container(),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 116, 22, 22),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _distance_in_km,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               //<-- SEE HERE
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               //<-- SEE HERE
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Distance in km',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _travel_total_amt,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               //<-- SEE HERE
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               //<-- SEE HERE
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Total Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),

//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.04,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     widget.arguments['flag'] == 1 && role == 1
//                         ? Container()
//                         : Container(
//                             height: SizeVariables.getHeight(context) * 0.04,
//                             width: SizeVariables.getWidth(context) * 0.325,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 primary: Color.fromARGB(168, 94, 92, 92),
//                               ),
//                               //     disabledColor: Colors.red,
//                               // disabledTextColor: Colors.black,
//                               // padding: const EdgeInsets.all(12),
//                               // textColor: const Color(0xffF59F23),
//                               // color: const Color.fromARGB(168, 81, 80, 80),
//                               onPressed: () {
//                                 if (status_travel == "0")
//                                   _travel_submit(context);
//                                 else
//                                   _errorMsg(context);
//                               },
//                               child: Text('Save As Draft',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyText2
//                                       ?.copyWith(
//                                         color: const Color(0xffF59F23),
//                                       )),
//                             ),
//                             decoration: new BoxDecoration(
//                               color: Color.fromARGB(168, 94, 92, 92),
//                               shape: BoxShape.rectangle,
//                               borderRadius: BorderRadius.circular(8),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color.fromARGB(255, 74, 74, 70),
//                                   blurRadius: 5.0,
//                                   offset: const Offset(2.0, 2.0),
//                                 ),
//                               ],
//                             ),
//                           ),
//                   ],
//                 ),
//               ],
//             ),
//             expanded: Text(
//               '',
//             ),
//           ),
//         ),
//       );

//   Widget buildCard1(
//     String title,
//     String text,
//   ) =>
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           color: Colors.black,
//           // surfaceTintColor: Colors.white,
//           child: ExpandablePanel(
//             header: Text(title, style: TextStyle(color: Colors.white)),
//             collapsed: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         // _food_file =
//                         //     await _picker.pickImage(source: ImageSource.camera);
//                         FocusScope.of(context).unfocus();
//                         var imagePath = await EdgeDetection.detectEdge;
//                         _food_file = XFile(File(imagePath.toString()).path);
//                       },
//                       child: Container(
//                         // color: Colors.red,
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: SizeVariables.getWidth(context) * 0.02,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         // final List<XFile>? food_file = await _picker.pickMultiImage();
//                         FocusScope.of(context).unfocus();
//                         var imagePath = await EdgeDetection.detectEdge;
//                         _food_file = XFile(File(imagePath.toString()).path);
//                       },
//                       child: Container(
//                         // color: Colors.red,
//                         child: const Icon(
//                           Icons.upload_file_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.02,
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _food_name_of_serviceprovider,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Name of Service Provider',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _food_bill_no,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Bill No',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _food_gst_no,
//                           // maxLength: 15,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(15)
//                           ],
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'GST No',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           keyboardType: TextInputType.number,
//                           controller: _food_basic_amt,
//                           onChanged: (_) {
//                             if (double.parse(_food_basic_amt.text) >
//                                 limit_food) {
//                               setState(() {
//                                 _food_total_amt.text = limit_food.toString();
//                               });
//                             } else {
//                               setState(() {
//                                 _food_total_amt.text = _food_basic_amt.text;
//                               });
//                             }
//                           },
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Basic Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _food_gst_amt,
//                           keyboardType: TextInputType.number,
//                           onChanged: (_) {
//                             if (double.parse(_food_gst_amt.text) +
//                                     double.parse(_food_basic_amt.text) >
//                                 limit_food) {
//                               setState(() {
//                                 _food_total_amt.text = limit_food.toString();
//                               });
//                             } else {
//                               setState(() {
//                                 var total = double.parse(_food_gst_amt.text) +
//                                     double.parse(_food_basic_amt.text);
//                                 _food_total_amt.text = total.toString();
//                               });
//                             }
//                           },
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'GST Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _food_total_amt,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Total Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.04,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     widget.arguments['flag'] == 1 && role == 1
//                         ? Container()
//                         : Container(
//                             height: SizeVariables.getHeight(context) * 0.04,
//                             width: SizeVariables.getWidth(context) * 0.325,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 primary: Color.fromARGB(168, 94, 92, 92),
//                               ),
//                               //     disabledColor: Colors.red,
//                               // disabledTextColor: Colors.black,
//                               // padding: const EdgeInsets.all(12),
//                               // textColor: const Color(0xffF59F23),
//                               // color: const Color.fromARGB(168, 81, 80, 80),
//                               onPressed: () {
//                                 if (status_food == "0")
//                                   _food_submit(context);
//                                 else
//                                   _errorMsg(context);
//                               },
//                               child: Text('Save As Draft',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyText2
//                                       ?.copyWith(
//                                         color: const Color(0xffF59F23),
//                                       )),
//                             ),
//                             decoration: new BoxDecoration(
//                               color: Color.fromARGB(168, 94, 92, 92),
//                               shape: BoxShape.rectangle,
//                               borderRadius: BorderRadius.circular(8),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color.fromARGB(255, 74, 74, 70),
//                                   blurRadius: 5.0,
//                                   offset: const Offset(2.0, 2.0),
//                                 ),
//                               ],
//                             ),
//                           ),
//                   ],
//                 ),
//               ],
//             ),
//             expanded: Text(
//               '',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       );

//   Widget buildCard2(
//     String title,
//     String text,
//   ) =>
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//           color: Colors.black,
//           // surfaceTintColor: Colors.white,
//           child: ExpandablePanel(
//             expanded: const Text('', style: TextStyle(color: Colors.white)),
//             header: Text(title, style: TextStyle(color: Colors.white)),
//             collapsed: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         FocusScope.of(context).unfocus();
//                         var imagePath = await EdgeDetection.detectEdge;
//                         _ie_file = XFile(File(imagePath.toString()).path);
//                       },
//                       child: Container(
//                         // color: Colors.red,
//                         child: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: SizeVariables.getWidth(context) * 0.02,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         // final List<XFile>? ie_file = await _picker.pickMultiImage();
//                         // _ie_file = await _picker.pickImage(
//                         //     source: ImageSource.gallery);
//                         FocusScope.of(context).unfocus();
//                         var imagePath = await EdgeDetection.detectEdge;
//                         _ie_file = XFile(File(imagePath.toString()).path);
//                       },
//                       child: Container(
//                         // color: Colors.red,
//                         child: const Icon(
//                           Icons.upload_file_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.02,
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           controller: _ie_name_of_serviceprovider,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Name of Service Provider',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           controller: _ie_bill_no,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Bill No',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           controller: _ie_gst_no,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(15)
//                           ],
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'GST No',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _ie_basic_amt,
//                           keyboardType: TextInputType.number,
//                           onChanged: (_) {
//                             if (double.parse(_ie_basic_amt.text) >
//                                 limit_incidental) {
//                               _ie_total_amt.text = limit_incidental.toString();
//                             } else {
//                               setState(() {
//                                 _ie_total_amt.text = _ie_basic_amt.text;
//                               });
//                             }
//                           },
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Basic Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _ie_gst_amt,
//                           keyboardType: TextInputType.number,
//                           onChanged: (_) {
//                             if (double.parse(_ie_basic_amt.text) +
//                                     double.parse(_ie_gst_amt.text) >
//                                 limit_incidental) {
//                               setState(() {
//                                 _ie_total_amt.text =
//                                     limit_incidental.toString();
//                               });
//                             } else {
//                               setState(() {
//                                 _ie_total_amt.text =
//                                     (double.parse(_ie_basic_amt.text) +
//                                             double.parse(_ie_gst_amt.text))
//                                         .toString();
//                               });
//                             }
//                           },
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'GST Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.amber,
//                       // padding: EdgeInsets.all(8),
//                       height: SizeVariables.getHeight(context) * 0.075,
//                       width: SizeVariables.getWidth(context) * 0.4,
//                       // decoration: BoxDecoration(
//                       //   color: Color.fromARGB(255, 17, 17, 17),
//                       //   borderRadius: BorderRadius.circular(12),
//                       // ),
//                       child: Center(
//                         child: TextFormField(
//                           readOnly: widget.arguments['flag'] == 1 && role == 1
//                               ? true
//                               : false,
//                           controller: _ie_total_amt,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 2, color: Colors.white),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Total Amount',
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 12),
//                           ),
//                           style: Theme.of(context).textTheme.bodyText1,
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: SizeVariables.getHeight(context) * 0.04,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     widget.arguments['flag'] == 1 && role == 1
//                         ? Container()
//                         : Container(
//                             height: SizeVariables.getHeight(context) * 0.04,
//                             width: SizeVariables.getWidth(context) * 0.325,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 primary: Color.fromARGB(168, 94, 92, 92),
//                               ),
//                               //     disabledColor: Colors.red,
//                               // disabledTextColor: Colors.black,
//                               // padding: const EdgeInsets.all(12),
//                               onPressed: () {
//                                 if (status_incidental == "0")
//                                   _ie_submit(context);
//                                 else
//                                   _errorMsg(context);
//                               },
//                               child: Text('Save As Draft',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyText2
//                                       ?.copyWith(
//                                         color: const Color(0xffF59F23),
//                                       )),
//                             ),
//                             decoration: new BoxDecoration(
//                               color: Color.fromARGB(168, 94, 92, 92),
//                               shape: BoxShape.rectangle,
//                               borderRadius: BorderRadius.circular(8),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color.fromARGB(255, 74, 74, 70),
//                                   blurRadius: 5.0,
//                                   offset: const Offset(2.0, 2.0),
//                                 ),
//                               ],
//                             ),
//                           ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   void _travel_submit(BuildContext context) {
//     if (_travel_name_of_serviceprovider.text.isEmpty &&
//         _travel_gst_amt.text.isEmpty &&
//         _travel_basic_amt.text.isEmpty &&
//         _travel_total_amt.text.isEmpty &&
//         // year1.indexOf(myYears1).toString().isEmpty
//         myYears1 == null) {
//       _errorVal_fields(context);
//     } else {
//       Map request_filename = {
//         "file_name": "travel_attachment",
//       };

//       Map<String, String> request_data = {
//         "doc_no": widget.arguments["doc_no"],
//         'claim_type': 'travel',
//         "distance": _distance_in_km.text,
//         'bill_no': myYears1 == 3 ? _travel_bill_no.text : '',
//         "gst_no": myYears1 == 3 ? _travel_gst_no.text : '',
//         "basic_amount":
//             myYears1 == 3 ? _travel_basic_amt.text : _travel_total_amt.text,
//         "claim_amount": _travel_total_amt.text,
//         "service_provider":
//             myYears1 == 3 ? _travel_name_of_serviceprovider.text : '',
//         "gst_amount": '',
//         // "mode_of_travel": year1.indexOf(myYears1).toString(),
//         "mode_of_travel": myYears1.toString(),

//         "from": "",
//       };

//       print('DATAAAAAA: $request_data');

//       if (_travel_file == null) {
//         _errorVal(context);
//       } else {
//         _claimzFormData.postClaimzFormSubmit(
//             context, request_filename, _travel_file!, request_data);
//         Map data = {
//           // "month": "",
//           "month": '',
//           "all": 1,
//           "year": "2022",
//         };

//         print('DATAAAAA: $data');

//         claimz_list.postClaimzHistoryList(context, data);
//         // print('REQUEST DATA: $request_data');
//       }
//     }
//   }

//   void _food_submit(BuildContext context) {
//     if (_food_name_of_serviceprovider.text.isEmpty &&
//         _food_gst_no.text.isEmpty &&
//         _food_gst_amt.text.isEmpty &&
//         _food_basic_amt.text.isEmpty &&
//         _food_total_amt.text.isEmpty) {
//       _errorVal_fields(context);
//     } else {
//       Map request_file = {
//         "file_name": "food_attachment",
//       };

//       Map<String, String> request_data = {
//         "doc_no": widget.arguments["doc_no"],
//         'claim_type': 'food',
//         'bill_no': _food_bill_no.text,
//         "service_provider": _food_name_of_serviceprovider.text,
//         "gst_no": _food_gst_no.text,
//         "gst_amount": _food_gst_amt.text,
//         "basic_amount": _food_basic_amt.text,
//         "claim_amount": _food_total_amt.text,
//       };

//       print('DATAAAAAA: $request_data');


//       // XFile myfile = XFile.fromData(Uint8List.fromList([0]));
//       if (_food_file == null) {
//         _errorVal(context);
//       } else {
//         _claimzFormData.postClaimzFormSubmit(
//             context, request_file, _food_file!, request_data);
//         Map data = {
//           // "month": "",
//           "month": '',
//           "all": 1,
//           "year": "2022",
//         };

//         print('DATAAAAA: $data');

//         claimz_list.postClaimzHistoryList(context, data);
//       }
//     }
//   }

//   void _ie_submit(BuildContext context) {
//     if (_ie_gst_no.text.isEmpty &&
//         _ie_gst_amt.text.isEmpty &&
//         _ie_basic_amt.text.isEmpty &&
//         _ie_total_amt.text.isEmpty) {
//       _errorVal_fields(context);
//     } else {
//       Map request_file = {
//         "file_name": "incidental_attachment",
//       };
//       Map<String, String> request_data = {
//         "doc_no": widget.arguments["doc_no"],
//         'claim_type': 'incidental',
//         'bill_no': _ie_bill_no.text,
//         "gst_no": _ie_gst_no.text,
//         "gst_amount": _ie_gst_amt.text,
//         "basic_amount": _ie_basic_amt.text,
//         "claim_amount": _ie_total_amt.text,
//       };

//       print('DATAAAAAA: $request_data');

//       if (_ie_file == null) {
//         _errorVal(context);
//       } else {
//         _claimzFormData.postClaimzFormSubmit(
//             context, request_file, _ie_file!, request_data);
//         Map data = {
//           // "month": "",
//           "month": '',
//           "all": 1,
//           "year": "2022",
//         };

//         print('DATAAAAA: $data');

//         claimz_list.postClaimzHistoryList(context, data);
//       }
//     }
//   }

//   void _errorMsg(BuildContext context) {
//     Flushbar(
//       message: "You cant submit the form",
//       icon: Icon(
//         Icons.warning_amber_outlined,
//         size: 28.0,
//         color: Colors.red,
//       ),
//       duration: Duration(seconds: 3),
//       leftBarIndicatorColor: Colors.red,
//     )..show(context);
//   }

//   void _errorVal(BuildContext context) {
//     Flushbar(
//       message: "please provide image",
//       icon: Icon(
//         Icons.warning_amber_outlined,
//         size: 28.0,
//         color: Colors.red,
//       ),
//       duration: Duration(seconds: 3),
//       leftBarIndicatorColor: Colors.red,
//     )..show(context);
//   }

//   void _errorVal_fields(BuildContext context) {
//     Flushbar(
//       message: "please provide all details",
//       icon: Icon(
//         Icons.warning_amber_outlined,
//         size: 28.0,
//         color: Colors.red,
//       ),
//       duration: Duration(seconds: 3),
//       leftBarIndicatorColor: Colors.red,
//     )..show(context);
//   }

//   void _dataFeeding() {
//     _distance_in_km.text = _distance_in_km_val;
//     _travel_name_of_serviceprovider.text = _travel_name_of_serviceprovider_val;
//     _travel_basic_amt.text = _travel_basic_amt_val;
//     _travel_gst_amt.text = _travel_gst_amt_val;
//     _travel_total_amt.text = _travel_total_amt_val;

//     _food_name_of_serviceprovider.text = _food_name_of_serviceprovider_val;
//     _food_basic_amt.text = _food_basic_amt_val;
//     _food_gst_amt.text = _food_gst_amt_val;
//     _food_total_amt.text = _food_total_amt_val;
//     _food_gst_no.text = _food_gst_no_val;
//     // _food_bill_no.text =  _food_bill_no_val;

//     _ie_name_of_serviceprovider.text = _ie_name_of_serviceprovider_val;
//     _ie_basic_amt.text = _ie_basic_amt_val;
//     _ie_gst_amt.text = _ie_gst_amt_val;
//     _ie_total_amt.text = _ie_total_amt_val;
//     _ie_gst_no.text = _ie_gst_no_val;
//     // _ie_bill_no.text =  value.claimz_user_limit!.data!.incidentData.bill_no.toString();
//   }
// }
