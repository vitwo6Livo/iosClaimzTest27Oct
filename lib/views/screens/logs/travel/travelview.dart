import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:accordion/controllers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '';

import 'package:photo_view/photo_view.dart';

class TravelViewLog extends StatefulWidget {
  Map arguments;
  TravelViewLog(Map<String, dynamic> this.arguments, {Key? key})
      : super(key: key);

  @override
  State<TravelViewLog> createState() => _TravelViewLogState();
}

class _TravelViewLogState extends State<TravelViewLog> {
  int _selection = 1;

  Map data = {
    "month": "",
    "type": "",
    "year": "",
    "user_id": "",
    "Info": "1" //self
  };
  //var details = "Action";
  // var details = "Paid by self";
  // var adetails = "Paid by self";
  // var fdetails = "Paid by self";
  // var idetails = "Paid by self";
  // var ldetails = "Paid by self";

  Map<String, dynamic> _ifnull = {
    "emp_name": " ",
    "emp_code": " ",
    "profile_photo": " ",
    "mod_of_travel": " ",
    "mod_of_acco": " ",
    "id": 0,
    "doc_no": 0,
    "trip_way": " ",
    "travel_type": " ",
    "from_place": " ",
    "to_place": " ",
    "from_date": " ",
    "from_time": " ",
    "to_date": " ",
    "to_time": " ",
    "claim_date": " ",
    "service_provider": " ",
    "gst_no": " ",
    "gst_amount": "0",
    "claim_amount": "0",
    "basic_amount": "0",
    "payment_type": "Paid by Company",
    "exchange_rate": " ",
    "document": " ",
    "status": " ",
    "remarks": " ",
    "type": " ",
    "payment_details": " ",
    "original_document": " ",
  };

  List<String> detail = [
    "Action",
    "Approve",
    "Reject",
  ];
  TextEditingController _gstAmount = TextEditingController();
  TextEditingController _basicAmount = TextEditingController();
  TextEditingController _totalAmount = TextEditingController();
  TravelViewModel _travelData = new TravelViewModel();

  TextEditingController _fgstamount = TextEditingController();
  TextEditingController _fgstbasicamount = TextEditingController();
  TextEditingController _fgstclaimamount = TextEditingController();
  TextEditingController _agstamount = TextEditingController();
  TextEditingController _agstbasicamount = TextEditingController();
  TextEditingController _agstclaimamount = TextEditingController();
  TextEditingController _tgstamount = TextEditingController();
  TextEditingController _tgstbasicamount = TextEditingController();
  TextEditingController _tgstclaimamount = TextEditingController();

  TextEditingController _gstAmtTravel = TextEditingController();
  TextEditingController _basicAmtTravel = TextEditingController();
  TextEditingController _claimAmtTravel = TextEditingController();

  TextEditingController _gstAmtLocal = TextEditingController();
  TextEditingController _basicAmtLocal = TextEditingController();
  TextEditingController _claimAmtLocal = TextEditingController();

  TextEditingController _gstAmtIncidental = TextEditingController();
  TextEditingController _basicAmtIncidental = TextEditingController();
  TextEditingController _claimAmtIncidental = TextEditingController();

  TextEditingController _gstAmtAccomodation = TextEditingController();
  TextEditingController _basicAmtAccomodation = TextEditingController();
  TextEditingController _claimAmtAccomodation = TextEditingController();

  TextEditingController _gstAmtFood = TextEditingController();
  TextEditingController _basicAmtFood = TextEditingController();
  TextEditingController _claimAmtFood = TextEditingController();

  String remarks_travel = "no remarks listed",
      remarks_acco = "no remarks listed",
      remarks_food = "no remarks listed",
      remarks_incidental = "no remarks listed",
      remarks_local = "no remarks listed";

  double _final_amount = 0.0;
  int page_load = 0;

  @override
  void initState() {
    // TODO: implement initState
    // _gstAmount.text = '50';
    // _basicAmount.text = '500';
    // _totalAmount.text = '550';
    Map _data_request = {
      "doc_no": widget.arguments["doc"],
      "all": widget.arguments["all"],
      "status": widget.arguments["status"],
    };
    _travelData.postTravelDoc(_data_request);

    Map _data_request2 = {
      "doc_no": widget.arguments["doc"],
    };
    _travelData.postApprovalLog(_data_request2).then((value) {
      // print("DATA>>>"+value.toString());
      if (value["data"]["travel"] != null) {
        remarks_travel = value["data"]["travel"]["remarks"].toString();
      }
      if (value["data"]["accomodation"] != null) {
        remarks_acco = value["data"]["accomodation"]["remarks"].toString();
      }
      if (value["data"]["food"] != null) {
        remarks_food = value["data"]["food"]["remarks"].toString();
      }
      if (value["data"]["local"] != null) {
        remarks_local = value["data"]["local"]["remarks"].toString();
      }
      if (value["data"]["incidental"] != null) {
        remarks_incidental = value["data"]["incidental"]["remarks"].toString();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ChangeNotifierProvider<TravelViewModel>(
        create: (_) => _travelData,
        child: Consumer<TravelViewModel>(
          builder: (context, value, child) {
            switch (value.iternaryDetails.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());

              case Status.COMPLETED:
                // if (page_load == 0) {}
                if (page_load == 0) {
                  if (value.iternaryDetails.data!.data!.travel != null) {
                    _gstAmtTravel.text = value
                                .iternaryDetails.data!.data!.travel!.gstAmount
                                .toString() ==
                            "null"
                        ? "0"
                        : _gstAmtTravel.text = value
                            .iternaryDetails.data!.data!.travel!.gstAmount
                            .toString();
                    // _gstAmtTravel.text = "0";
                    _basicAmtTravel.text = value
                        .iternaryDetails.data!.data!.travel!.basicAmount
                        .toString();
                    _claimAmtTravel.text = value
                        .iternaryDetails.data!.data!.travel!.claimAmount
                        .toString();
                  }
                  if (value.iternaryDetails.data!.data!.accomodation != null) {
                    _gstAmtAccomodation.text = value
                        .iternaryDetails.data!.data!.accomodation!.gstAmount
                        .toString();
                    _basicAmtAccomodation.text = value
                        .iternaryDetails.data!.data!.accomodation!.basicAmount
                        .toString();
                    _claimAmtAccomodation.text = value
                        .iternaryDetails.data!.data!.accomodation!.claimAmount
                        .toString();
                  }
                  if (value.iternaryDetails.data!.data!.food != null) {
                    _gstAmtFood.text = value
                        .iternaryDetails.data!.data!.food!.gstAmount
                        .toString();
                    _basicAmtFood.text = value
                        .iternaryDetails.data!.data!.food!.basicAmount
                        .toString();
                    _claimAmtFood.text = value
                        .iternaryDetails.data!.data!.food!.claimAmount
                        .toString();
                  }
                  if (value.iternaryDetails.data!.data!.local != null) {
                    _gstAmtLocal.text = value
                        .iternaryDetails.data!.data!.local!.gstAmount
                        .toString();
                    _basicAmtLocal.text = value
                        .iternaryDetails.data!.data!.local!.basicAmount
                        .toString();
                    _claimAmtLocal.text = value
                        .iternaryDetails.data!.data!.local!.claimAmount
                        .toString();
                  }
                  if (value.iternaryDetails.data!.data!.incidental != null) {
                    _gstAmtIncidental.text = value
                        .iternaryDetails.data!.data!.incidental!.gstAmount
                        .toString();
                    _basicAmtIncidental.text = value
                        .iternaryDetails.data!.data!.incidental!.basicAmount
                        .toString();
                    _claimAmtIncidental.text = value
                        .iternaryDetails.data!.data!.incidental!.claimAmount
                        .toString();
                  }

                  if (_basicAmtTravel.text.toString() == "null") {
                    _basicAmtTravel.text = "0";
                  }
                  if (_gstAmtTravel.text.toString() == "null") {
                    _gstAmtTravel.text = "0";
                  }
                  if (_basicAmtAccomodation.text.toString() == "null") {
                    _basicAmtAccomodation.text = "0";
                  }
                  if (_gstAmtAccomodation.text.toString() == "null") {
                    _gstAmtAccomodation.text = "0";
                  }
                  if (_basicAmtFood.text.toString() == "null") {
                    _basicAmtFood.text = "0";
                  }
                  if (_gstAmtFood.text.toString() == "null") {
                    _gstAmtFood.text = "0";
                  }
                  if (_basicAmtLocal.text.toString() == "null") {
                    _basicAmtLocal.text = "0";
                  }
                  if (_gstAmtLocal.text.toString() == "null") {
                    _gstAmtLocal.text = "0";
                  }
                  if (_basicAmtIncidental.text.toString() == "null") {
                    _basicAmtIncidental.text = "0";
                  }
                  if (_gstAmtIncidental.text.toString() == "null") {
                    _gstAmtIncidental.text = "0";
                  }

                  _final_amount = double.parse(_claimAmtTravel.text == ""
                          ? "0"
                          : _claimAmtTravel.text) +
                      double.parse(_claimAmtAccomodation.text == ""
                          ? "0"
                          : _claimAmtAccomodation.text) +
                      double.parse(
                          _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
                      double.parse(_claimAmtLocal.text == ""
                          ? "0"
                          : _claimAmtLocal.text) +
                      double.parse(_claimAmtIncidental.text == ""
                          ? "0"
                          : _claimAmtIncidental.text);
                  page_load += 1;
                }

                return Column(
                  children: <Widget>[
                    Padding(
                      //box
                      padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.05,
                        left: SizeVariables.getWidth(context) * 0.04,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/back button.svg",
                                ),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Travel Claim View',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 16, color: Colors.grey),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.13,
                                ),
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Icon(
                                        Icons.file_open_rounded,
                                        color: Theme.of(context).canvasColor,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        widget.arguments["doc"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.amber,
                                                fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.05,
                              right: SizeVariables.getWidth(context) * 0.1,
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.03,
                                  ),
                                  child: const Text(
                                    '₹',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xffF59F23),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: SizeVariables.getWidth(context) * 0.02,
                                // ),
                                Container(
                                  // padding: EdgeInsets.only(
                                  //   right: SizeVariables.getWidth(context)*0.3,
                                  // ),
                                  child: Text(
                                    _final_amount.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 30,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.35,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 3,
                                    ),
                                  ),
                                  child: RippleAnimation(
                                    repeat: true,
                                    color: Colors.grey,
                                    minRadius: 29,
                                    ripplesCount: 1,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/travelIcon/Information.svg",
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.03,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                          ),
                                          // SizedBox(
                                          //     height:
                                          //     SizeVariables.getHeight(context) *
                                          //         0.007),
                                          // FittedBox(
                                          //   fit: BoxFit.contain,
                                          //   child: Text(
                                          //     'Info.',
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText1,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.045),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.77,
                                height: SizeVariables.getHeight(context) * 0.1,
                                // color: Colors.pink,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _selection == 0
                                            ? Colors.amber
                                            : Colors.black,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 0;
                                          Map data = {
                                            "month": "",
                                            "type": "Travel",
                                            "year": "",
                                            "user_id": "",
                                            "all": "1" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, .0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          // color: Colors.pink,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.015,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/flightbus.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.025,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _selection == 2
                                            ? Colors.amber
                                            : Colors.black,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 2;
                                          Map data = {
                                            "month": "",
                                            "type": "Hotel",
                                            "year": "",
                                            "user_id": "",
                                            "all": "2",
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.015,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/Hotel.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.025,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _selection == 3
                                            ? Colors.amber
                                            : Colors.black,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 3;
                                          Map data = {
                                            "month": "",
                                            "type": "Food",
                                            "year": "",
                                            "user_id": "",
                                            "all": "3" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.015,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/Food.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.025,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _selection == 4
                                            ? Colors.amber
                                            : Colors.black,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 4;
                                          Map data = {
                                            "month": "",
                                            "type": "Local",
                                            "year": "",
                                            "user_id": "",
                                            "all": "4" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.016,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/Local Travel.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.025,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _selection == 5
                                            ? Colors.amber
                                            : Colors.black,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 5;
                                          Map data = {
                                            "month": "",
                                            "type": "incidental",
                                            "year": "",
                                            "user_id": "",
                                            "all": "5" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.016,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/incidentals.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.02,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          // color: Colors.pink,
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.only(
                            //   topRight: Radius.circular(20),
                            //   topLeft: Radius.circular(20),
                            //   // bottomLeft: Radius.circular(40),
                            //   // bottomRight: Radius.circular(40),
                            // ),
                            color: Color.fromARGB(239, 228, 226, 226),
                          ),
                          child: ListView(
                            children: [
                              _selection == 1
                                  ? _infotabManager(
                                      value.iternaryDetails!.data!.data!
                                          .meetingDetails,
                                      value.iternaryDetails!.data!.data!
                                          .reasonLog)
                                  : SizedBox(),
                              _selection == 0
                                  ? _traveltabManager(value.iternaryDetails!
                                          .data!.data!.travel ??
                                      Travel.fromJson(_ifnull))
                                  : SizedBox(),
                              _selection == 2
                                  ? _accomondationtabManager(value
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .accomodation ??
                                      Accomodation.fromJson(_ifnull))
                                  : SizedBox(),
                              _selection == 3
                                  ? _foodtabManager(
                                      value.iternaryDetails!.data!.data!.food ??
                                          Accomodation.fromJson(_ifnull))
                                  : SizedBox(),
                              _selection == 4
                                  ? _localtabManager(value
                                          .iternaryDetails!.data!.data!.local ??
                                      Accomodation.fromJson(_ifnull))
                                  : SizedBox(),
                              _selection == 5
                                  ? _incidentaltabManager(value.iternaryDetails!
                                          .data!.data!.incidental ??
                                      Accomodation.fromJson(_ifnull))
                                  : SizedBox(),
                              SizedBox(
                                height: SizeVariables.getHeight(context) * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );

              case Status.ERROR:
                return Center(
                    child: Text(value.iternaryDetails.message.toString()));
            }

            return Container();
          },
        ),
      ),
    );
  }

  _infotabManager(
      List<MeetingDetails>? meetingDetails, List<ReasonLog>? approvalLog) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              // height: SizeVariables.getHeight(context) * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.02,
                            left: SizeVariables.getWidth(context) * 0.054,
                          ),
                          // color: Colors.amber,
                          child: Text(
                            'Meeting details',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Meet to whom',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            meetingDetails![0]
                                                .metWhom
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
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
                            padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.07),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Feedback',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            meetingDetails![0]
                                                .feedback
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.1,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Purpose',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        meetingDetails![0]
                                            .purposeOfVisit
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
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
            SizedBox(height: SizeVariables.getHeight(context) * 0.02),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.05,
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Approval Status',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                height: SizeVariables.getHeight(context) * 0.5,
                child: Scrollbar(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: approvalLog!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 250,
                        child: TimelineTile(
                          endChild: Container(
                            padding: EdgeInsets.only(
                              top: SizeVariables.getHeight(context) * 0.03,
                            ),
                            // color: Color.fromARGB(239, 228, 226, 226),
                            // height: 50,
                            child: Accordion(
                              disableScrolling: true,
                              // maxOpenSections: 1,
                              headerBackgroundColorOpened:
                                  Color.fromARGB(239, 228, 226, 226),
                              scaleWhenAnimating: true,
                              openAndCloseAnimation: true,
                              headerPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              sectionOpeningHapticFeedback:
                                  SectionHapticFeedback.heavy,
                              sectionClosingHapticFeedback:
                                  SectionHapticFeedback.light,
                              children: [
                                AccordionSection(
                                  contentBackgroundColor:
                                      Color.fromARGB(239, 228, 226, 226),
                                  // isO?pen: true,

                                  headerBackgroundColor:
                                      Color.fromARGB(239, 228, 226, 226),
                                  headerBackgroundColorOpened:
                                      Color.fromARGB(239, 228, 226, 226),
                                  contentBorderColor:
                                      Color.fromARGB(239, 228, 226, 226),
                                  header: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Icon(
                                              Icons.currency_rupee_outlined,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              approvalLog[index].sum.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Color(0xfffe2f6ed),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                              top: 2.5,
                                              bottom: 2.5),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                approvalLog[index]
                                                    .status
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color:
                                                            Color(0xfff26af48),
                                                        fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 3,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.54,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  approvalLog[index]
                                                              .remarks
                                                              .toString() ==
                                                          "null"
                                                      ? "No Remarks"
                                                      : approvalLog[index]
                                                          .remarks
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              approvalLog[index]
                                                  .empName
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontStyle:
                                                          FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 2,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.6,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.007,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  approvalLog[index]
                                                      .approvedAt
                                                      .toString()
                                                      .split(" ")[0],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  approvalLog[index]
                                                      .approvedAt
                                                      .toString()
                                                      .split(" ")[1],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  contentHorizontalPadding: 20,
                                  contentBorderWidth: 1,
                                  // onOpenSection: () => print('onOpenSection ...'),
                                  // onCloseSection: () => print('onCloseSection ...'),
                                ),
                              ],
                            ),
                          ),
                          isLast: index == approvalLog!.length ? true : false,
                          isFirst: index == 0 ? true : false,
                          indicatorStyle: IndicatorStyle(
                            height: 100,
                            width: 25,
                            color: Colors.green,
                            iconStyle: IconStyle(
                              iconData: Icons.download_done,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _traveltabManager(Travel? travel) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AutofillGroup(
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.01,
          right: SizeVariables.getWidth(context) * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: SizeVariables.getHeight(context) * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.02,
                            left: SizeVariables.getWidth(context) * 0.054,
                          ),
                          // color: Colors.amber,
                          child: Text(
                            'Travel details',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _viewdocument(context, travel!.document.toString(),
                                travel!.original_document.toString(), "travel");
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.07),
                            child: const Icon(
                              Icons.remove_red_eye,
                              // size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    _originalInvStatus(travel, width),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.02,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.mode_of_travel_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Travel type',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      travel!.modOfTravel.toString() == "null"
                                          ? "Business class"
                                          : travel!.modOfTravel.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child:
                                            Icon(Icons.travel_explore_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Travel way',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.tripWay.toString() !=
                                                          ""
                                                      ? travel!.tripWay
                                                          .toString()
                                                      : " ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.location_on_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'From',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.fromPlace
                                                              .toString()
                                                              .length <=
                                                          15
                                                      ? travel!.fromPlace
                                                          .toString()
                                                      : travel!.fromPlace
                                                          .toString()
                                                          .replaceRange(
                                                              15,
                                                              travel!.fromPlace
                                                                  .toString()
                                                                  .length,
                                                              "..."),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child:
                                            Icon(Icons.calendar_month_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Departure',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.fromDate.toString() ==
                                                          ""
                                                      ? " "
                                                      : travel!.fromDate
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.handshake_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Name of Provider',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.serviceProvider
                                                              .toString() !=
                                                          ""
                                                      ? travel!.serviceProvider
                                                          .toString()
                                                      : " ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.location_on_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'To',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.toPlace
                                                              .toString()
                                                              .length <=
                                                          12
                                                      ? travel!.toPlace
                                                          .toString()
                                                      : travel!.toPlace
                                                          .toString()
                                                          .replaceRange(
                                                              12,
                                                              travel!.toPlace
                                                                  .toString()
                                                                  .length,
                                                              "..."),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.17,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        child:
                                            Icon(Icons.calendar_month_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Return',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.toDate.toString() ==
                                                          ""
                                                      ? " "
                                                      : travel!.toDate
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04,
                            top: SizeVariables.getHeight(context) * 0.01,
                          ),
                          // color: Colors.amber,
                          child: Text(
                            'Claim',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.238),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.07,
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Doc. date',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              travel!.claimDate.toString() == ""
                                                  ? " "
                                                  : travel!.claimDate
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Icon(Icons.account_balance_wallet_outlined),
                          //       ),
                          //       SizedBox(
                          //         width: SizeVariables.getWidth(context) * 0.01,
                          //       ),
                          //       Container(
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               child: FittedBox(
                          //                 fit: BoxFit.contain,
                          //                 child: Text(
                          //                   'Exchange rate',
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyText1!
                          //                       .copyWith(
                          //                           color: Colors.black,
                          //                           fontSize: 12),
                          //                 ),
                          //               ),
                          //             ),
                          //             Container(
                          //               child: FittedBox(
                          //                 fit: BoxFit.contain,
                          //                 child: Text(
                          //                   '2734767437',
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyText2!
                          //                       .copyWith(
                          //                           color: Colors.black,
                          //                           fontSize: 14),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.book_online),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'GST No',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  travel!.gstNo.toString() == ""
                                                      ? " "
                                                      : travel!.gstNo
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 14),
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
                                  child: Row(
                                    children: [
                                      Container(
                                        child:
                                            Icon(Icons.currency_rupee_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Basic Amount',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.021,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.18,
                                              child: TextFormField(
                                                controller: _basicAmtTravel,
                                                onChanged: (content) {
                                                  if (_gstAmtTravel.text ==
                                                      '') {
                                                    setState(() {
                                                      _claimAmtTravel.text =
                                                          _basicAmtTravel.text;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _claimAmtTravel
                                                          .text = (double.parse(
                                                                  _basicAmtTravel
                                                                      .text) +
                                                              double.parse(
                                                                  _gstAmtTravel
                                                                      .text))
                                                          .toString();
                                                    });
                                                  }
                                                  setState(() {
                                                    _limitManager(
                                                        _claimAmtTravel.text,
                                                        travel,
                                                        _claimAmtTravel,
                                                        _gstAmtTravel,
                                                        _basicAmtTravel);
                                                  });
                                                  setState(() {
                                                    //_final_amount = double.parse(tclaim_amount.text);

                                                    _finalSum(
                                                        "travel",
                                                        travel!.paymentType
                                                            .toString());
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                cursorColor: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child:
                                            Icon(Icons.currency_rupee_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'GST Amount',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.021,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.18,
                                              child: TextField(
                                                controller: _gstAmtTravel,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                cursorColor: Colors.black,
                                                onChanged: (val) {
                                                  if (_gstAmtTravel.text ==
                                                      '') {
                                                    setState(() {
                                                      _claimAmtTravel.text =
                                                          _basicAmtTravel.text;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _claimAmtTravel.text =
                                                          double.parse(
                                                                  _gstAmtTravel
                                                                      .text)
                                                              .toString();
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child:
                                            Icon(Icons.currency_rupee_outlined),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'Claim Amount',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.021,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.18,
                                              child: TextFormField(
                                                readOnly: true,
                                                controller: _claimAmtTravel,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                cursorColor: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.05,
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.payment_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Payment type',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              travel!.paymentType.toString() ==
                                                      ""
                                                  ? " "
                                                  : travel!.paymentType
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _approvar_remarks("travel"),
          ],
        ),
      ),
    );
  }

  _accomondationtabManager(Accomodation? accomodation) {
    print('accomodation.claimAmount: ${accomodation!.claimAmount}');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: SizeVariables.getHeight(context) * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 3,
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: SizeVariables.getHeight(context) * 0.02,
                          left: SizeVariables.getWidth(context) * 0.054,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Accomodation details',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // _viewdocument(context, travel);
                          _viewdocument(
                              context,
                              accomodation!.document.toString(),
                              accomodation!.original_document.toString(),
                              "acco");
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.07),
                          child: Icon(
                            Icons.remove_red_eye,
                            // size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  _originalInvStatus(accomodation, width),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.handshake_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Name of Provider',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            accomodation!.serviceProvider!
                                                        .toString() ==
                                                    ""
                                                ? " "
                                                : accomodation!.serviceProvider!
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.238),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.calendar_month_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'From date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            accomodation!.fromDate.toString() ==
                                                    ""
                                                ? " "
                                                : accomodation!.fromDate
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.calendar_month_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'To date',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          accomodation!.toDate.toString() == ""
                                              ? " "
                                              : accomodation!.toDate.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04,
                          top: SizeVariables.getHeight(context) * 0.01,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Claim',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.238),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.calendar_month_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Doc. date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            accomodation!.claimDate
                                                        .toString() ==
                                                    ""
                                                ? " "
                                                : accomodation!.claimDate
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         child: Icon(Icons.account_balance_wallet_outlined),
                        //       ),
                        //       SizedBox(
                        //         width: SizeVariables.getWidth(context) * 0.01,
                        //       ),
                        //       Container(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Container(
                        //               child: FittedBox(
                        //                 fit: BoxFit.contain,
                        //                 child: Text(
                        //                   'Exchange rate',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText1!
                        //                       .copyWith(
                        //                           color: Colors.black,
                        //                           fontSize: 12),
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               child: FittedBox(
                        //                 fit: BoxFit.contain,
                        //                 child: Text(
                        //                   '7347756784',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText2!
                        //                       .copyWith(
                        //                           color: Colors.black,
                        //                           fontSize: 14),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'GST No',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            accomodation!.gstNo.toString() == ""
                                                ? " "
                                                : accomodation!.gstNo
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'GST Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        controller: _gstAmtAccomodation,
                                        onChanged: (val) {
                                          if (_gstAmtAccomodation.text == '') {
                                            setState(() {
                                              _claimAmtAccomodation.text =
                                                  _basicAmtAccomodation.text;
                                            });
                                          } else {
                                            setState(() {
                                              _claimAmtAccomodation
                                                  .text = double.parse(
                                                      _gstAmtAccomodation.text)
                                                  .toString();
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.219),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.currency_rupee_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Basic Amount',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.021,
                                        width: SizeVariables.getWidth(context) *
                                            0.18,
                                        child: TextFormField(
                                          controller: _basicAmtAccomodation,
                                          onChanged: (content) {
                                            if (_gstAmtAccomodation.text ==
                                                '') {
                                              setState(() {
                                                _claimAmtAccomodation.text =
                                                    _basicAmtAccomodation.text;
                                              });
                                            } else {
                                              setState(() {
                                                _claimAmtAccomodation
                                                    .text = (double.parse(
                                                            _basicAmtAccomodation
                                                                .text) +
                                                        double.parse(
                                                            _gstAmtAccomodation
                                                                .text))
                                                    .toString();
                                              });
                                            }
                                            setState(() {
                                              _limitManagerAcco(
                                                  _claimAmtAccomodation.text,
                                                  accomodation,
                                                  _claimAmtAccomodation,
                                                  _gstAmtAccomodation,
                                                  _basicAmtAccomodation);
                                            });
                                            //_final_amount = double.parse(tclaim_amount.text);

                                            _finalSum(
                                                "accomodation",
                                                accomodation!.paymentType
                                                    .toString());
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Claim Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _claimAmtAccomodation,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.payment_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Payment type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            accomodation!.paymentType
                                                        .toString() ==
                                                    ""
                                                ? " "
                                                : accomodation!.paymentType
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _approvar_remarks("acco"),
        ],
      ),
    );
  }

  _foodtabManager(Accomodation? food) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: SizeVariables.getHeight(context) * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 3,
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: SizeVariables.getHeight(context) * 0.02,
                          left: SizeVariables.getWidth(context) * 0.054,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Food details',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _viewdocument(
                              context,
                              food!.document.toString(),
                              food!.original_document.toString(),
                              "no_original");
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.07),
                          child: Icon(
                            Icons.remove_red_eye,
                            // size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  // _originalInvStatus(food,width),

                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.handshake_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Name of Provider',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.serviceProvider.toString() ==
                                                    ""
                                                ? " "
                                                : food!.serviceProvider
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04,
                          top: SizeVariables.getHeight(context) * 0.01,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Claim',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.238),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.calendar_month_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Doc. date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.claimDate.toString() == ""
                                                ? " "
                                                : food!.claimDate.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         child: Icon(Icons.account_balance_wallet_outlined),
                        //       ),
                        //       SizedBox(
                        //         width: SizeVariables.getWidth(context) * 0.01,
                        //       ),
                        //       Container(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Container(
                        //               child: FittedBox(
                        //                 fit: BoxFit.contain,
                        //                 child: Text(
                        //                   'Exchange rate',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText1!
                        //                       .copyWith(
                        //                           color: Colors.black,
                        //                           fontSize: 12),
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               child: FittedBox(
                        //                 fit: BoxFit.contain,
                        //                 child: Text(
                        //                   '2999999999',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText2!
                        //                       .copyWith(
                        //                           color: Colors.black,
                        //                           fontSize: 14),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'GST No',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.gstNo.toString() == ""
                                                ? " "
                                                : food!.gstNo.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'GST Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        controller: _gstAmtFood,
                                        onChanged: (val) {
                                          if (_gstAmtFood.text == '') {
                                            setState(() {
                                              _claimAmtFood.text =
                                                  _basicAmtFood.text;
                                            });
                                          } else {
                                            setState(() {
                                              _claimAmtFood.text =
                                                  double.parse(_gstAmtFood.text)
                                                      .toString();
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                        // onChanged: (val) {
                                        //   setState(() {
                                        //     _gstAmtTravel.text = val;
                                        //   });
                                        // },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.219),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.currency_rupee_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Basic Amount',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.021,
                                        width: SizeVariables.getWidth(context) *
                                            0.18,
                                        child: TextFormField(
                                          controller: _basicAmtFood,
                                          onChanged: (content) {
                                            if (_gstAmtFood.text == '') {
                                              setState(() {
                                                _claimAmtFood.text =
                                                    _basicAmtFood.text;
                                              });
                                            } else {
                                              setState(() {
                                                _claimAmtFood
                                                    .text = (double.parse(
                                                            _basicAmtFood
                                                                .text) +
                                                        double.parse(
                                                            _gstAmtFood.text))
                                                    .toString();
                                              });
                                            }
                                            setState(() {
                                              _limitManagerAcco(
                                                  _claimAmtFood.text,
                                                  food,
                                                  _claimAmtFood,
                                                  _gstAmtFood,
                                                  _basicAmtFood);
                                            });
                                            //_final_amount = double.parse(tclaim_amount.text);

                                            setState(() {
                                              _finalSum("food",
                                                  food!.paymentType.toString());
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Claim Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _claimAmtFood,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.payment_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Payment type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.paymentType.toString() == ""
                                                ? " "
                                                : food!.paymentType.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _approvar_remarks("food"),
        ],
      ),
    );
  }

  _localtabManager(Accomodation? food) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: SizeVariables.getHeight(context) * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 3,
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: SizeVariables.getHeight(context) * 0.02,
                          left: SizeVariables.getWidth(context) * 0.054,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Local details',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _viewdocument(
                              context,
                              food!.document.toString(),
                              food!.original_document.toString(),
                              "no_original");
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.07),
                          child: Icon(
                            Icons.remove_red_eye,
                            // size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  // _originalInvStatus(food,width),

                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.handshake_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Name of Provider',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.serviceProvider.toString() ==
                                                    ""
                                                ? " "
                                                : food!.serviceProvider
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04,
                          top: SizeVariables.getHeight(context) * 0.01,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Claim',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.238),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.calendar_month_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Doc. date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.claimDate.toString() == ""
                                                ? " "
                                                : food!.claimDate.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         child: Icon(Icons.account_balance_wallet_outlined),
                        //       ),
                        //       SizedBox(
                        //         width: SizeVariables.getWidth(context) * 0.01,
                        //       ),
                        //       Container(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Container(
                        //               child: FittedBox(
                        //                 fit: BoxFit.contain,
                        //                 child: Text(
                        //                   'Exchange rate',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText1!
                        //                       .copyWith(
                        //                           color: Colors.black,
                        //                           fontSize: 12),
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               child: FittedBox(
                        //                 fit: BoxFit.contain,
                        //                 child: Text(
                        //                   '2999999999',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .bodyText2!
                        //                       .copyWith(
                        //                           color: Colors.black,
                        //                           fontSize: 14),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'GST No',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.gstNo.toString() == ""
                                                ? " "
                                                : food!.gstNo.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'GST Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        controller: _gstAmtLocal,
                                        onChanged: (val) {
                                          if (_gstAmtLocal.text == '') {
                                            setState(() {
                                              _claimAmtLocal.text =
                                                  _basicAmtLocal.text;
                                            });
                                          } else {
                                            setState(() {
                                              _claimAmtLocal.text =
                                                  double.parse(
                                                          _gstAmtLocal.text)
                                                      .toString();
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                        // onChanged: (val) {
                                        //   setState(() {
                                        //     _gstAmtTravel.text = val;
                                        //   });
                                        // },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.219),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.currency_rupee_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Basic Amount',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.021,
                                        width: SizeVariables.getWidth(context) *
                                            0.18,
                                        child: TextFormField(
                                          controller: _basicAmtLocal,
                                          onChanged: (content) {
                                            if (_gstAmtLocal.text == '') {
                                              setState(() {
                                                _claimAmtLocal.text =
                                                    _basicAmtLocal.text;
                                              });
                                            } else {
                                              setState(() {
                                                _claimAmtLocal
                                                    .text = (double.parse(
                                                            _basicAmtLocal
                                                                .text) +
                                                        double.parse(
                                                            _gstAmtLocal.text))
                                                    .toString();
                                              });
                                            }
                                            setState(() {
                                              _limitManagerAcco(
                                                  _claimAmtLocal.text,
                                                  food,
                                                  _claimAmtLocal,
                                                  _gstAmtLocal,
                                                  _basicAmtLocal);
                                            });

                                            setState(() {
                                              //_final_amount = double.parse(tclaim_amount.text);

                                              _finalSum("local",
                                                  food!.paymentType.toString());
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Claim Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        controller: _claimAmtLocal,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.payment_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Payment type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            food!.paymentType.toString() == ""
                                                ? " "
                                                : food!.paymentType.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _approvar_remarks("local"),
        ],
      ),
    );
  }

  _incidentaltabManager(Accomodation? incidental) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: SizeVariables.getHeight(context) * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 3,
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: SizeVariables.getHeight(context) * 0.02,
                          left: SizeVariables.getWidth(context) * 0.054,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Incidental details',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _viewdocument(
                              context,
                              incidental!.document.toString(),
                              incidental!.original_document.toString(),
                              "no_original");
                        },
                        child: Container(
                          // color: Colors.amber,
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.07),
                          child: Icon(
                            Icons.remove_red_eye,
                            // size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),

                  // _originalInvStatus(incidental,width),

                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.handshake_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Name of Provider',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            incidental!.serviceProvider
                                                        .toString() ==
                                                    ""
                                                ? " "
                                                : incidental!.serviceProvider
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.handshake_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Purchase details',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            incidental!.paymentDetails
                                                        .toString() ==
                                                    ""
                                                ? " "
                                                : incidental!.paymentDetails
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04,
                          top: SizeVariables.getHeight(context) * 0.01,
                        ),
                        // color: Colors.amber,
                        child: Text(
                          'Claim',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.246),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.calendar_month_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Doc. date',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            incidental!.claimDate.toString() ==
                                                    ""
                                                ? " "
                                                : incidental!.claimDate
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'GST No',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            incidental!.gstNo.toString() == ""
                                                ? " "
                                                : incidental!.gstNo.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'GST Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        controller: _gstAmtIncidental,
                                        onChanged: (val) {
                                          if (_gstAmtIncidental.text == '') {
                                            setState(() {
                                              _claimAmtIncidental.text =
                                                  _basicAmtIncidental.text;
                                            });
                                          } else {
                                            setState(() {
                                              _claimAmtIncidental
                                                  .text = double.parse(
                                                      _gstAmtIncidental.text)
                                                  .toString();
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.219),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.currency_rupee_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Basic Amount',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.021,
                                        width: SizeVariables.getWidth(context) *
                                            0.18,
                                        child: TextFormField(
                                          controller: _basicAmtIncidental,
                                          onChanged: (_) {
                                            if (_gstAmtIncidental.text == '') {
                                              setState(() {
                                                _claimAmtIncidental.text =
                                                    _basicAmtIncidental.text;
                                              });
                                            } else {
                                              setState(() {
                                                _claimAmtIncidental
                                                    .text = (double.parse(
                                                            _basicAmtIncidental
                                                                .text) +
                                                        double.parse(
                                                            _gstAmtIncidental
                                                                .text))
                                                    .toString();
                                              });
                                            }
                                            setState(() {
                                              _limitManagerAcco(
                                                  _claimAmtIncidental.text,
                                                  incidental,
                                                  _claimAmtIncidental,
                                                  _gstAmtIncidental,
                                                  _basicAmtIncidental);
                                            });
                                            setState(() {
                                              _finalSum(
                                                  "incidental",
                                                  incidental!.paymentType
                                                      .toString());
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Claim Amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.021,
                                      width: SizeVariables.getWidth(context) *
                                          0.18,
                                      child: TextFormField(
                                        controller: _claimAmtIncidental,
                                        // onChanged: (val){
                                        //
                                        // },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.payment_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Payment type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            incidental!.paymentType
                                                        .toString() ==
                                                    ""
                                                ? " "
                                                : incidental!.paymentType
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _approvar_remarks("incidental"),
        ],
      ),
    );
  }

  _popupApprove(String type, BuildContext context) {
    TextEditingController remarks = new TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Give Remarks",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
              ),
              TextFormField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Remarks",
                  hintStyle: TextStyle(color: Colors.grey),
                  // prefixIcon: Icon(
                  //   Icons.info,
                  //   color: Colors.white,
                  // ),
                ),
                style: Theme.of(context).textTheme.bodyText1,
                validator: (val) => val!.isEmpty ? 'Enter Remarks' : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(168, 94, 92, 92),
                      ),
                      onPressed: () {
                        Map data = {
                          "doc_no": widget.arguments["doc"],
                          "status": widget.arguments["status"],
                          "remarks": remarks.text,
                        };
                        Provider.of<TravelViewModel>(context, listen: false)
                            .postManagerApprove(context, data);
                      },
                      child: Text('Approve',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  )),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(168, 94, 92, 92),
                      ),
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,
                      // padding: const EdgeInsets.all(12),
                      // textColor: Color(0xffF59F23),
                      // : Color.fromARGB(168, 81, 80, 80),
                      onPressed: () {
                        Map data = {
                          "doc_no": widget.arguments["doc"],
                          "status": "999999",
                          "remarks": remarks.text,
                        };
                        Provider.of<TravelViewModel>(context, listen: false)
                            .postManagerApprove(context, data);
                        Navigator.pop(context);
                      },
                      child: Text('Reject',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _popupAmmend(Map data, BuildContext context) {
    TextEditingController remarks = new TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Give Remarks",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
              ),
              TextFormField(
                controller: remarks,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Remarks",
                  hintStyle: TextStyle(color: Colors.grey),
                  // prefixIcon: Icon(
                  //   Icons.info,
                  //   color: Colors.white,
                  // ),
                ),
                style: Theme.of(context).textTheme.bodyText1,
                validator: (val) => val!.isEmpty ? 'Enter Remarks' : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(168, 94, 92, 92),
                      ),
                      onPressed: () {
                        data.addAll({"remarks": remarks.text.toString()});
                        // Map data = {
                        //   "doc_no": widget.arguments["doc"],
                        //   "status": widget.arguments["status"],
                        //   "remarks": remarks.text,
                        // };
                        Provider.of<TravelViewModel>(context, listen: false)
                            .postManagerPartial(context, data);
                      },
                      child: Text('Approve',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  )),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(168, 94, 92, 92),
                      ),
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,
                      // padding: const EdgeInsets.all(12),
                      // textColor: Color(0xffF59F23),
                      // : Color.fromARGB(168, 81, 80, 80),
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Text('Cancel',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _finalSum(String type, String paytype) {
    if (type == "travel") {
      if (paytype == "Paid by self") {
        if (_claimAmtTravel.text == "") {
          _final_amount = 0.0 +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else if (paytype == "Paid by company") {
        _final_amount = double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "accomodation") {
      if (paytype == "Paid by self") {
        if (_claimAmtAccomodation.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "food") {
      if (paytype == "Paid by self") {
        if (_claimAmtFood.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtFood.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "local") {
      if (paytype == "Paid by self") {
        if (_claimAmtLocal.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtLocal.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "incidental") {
      if (paytype == "Paid by self") {
        if (_claimAmtIncidental.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text);
        } else {
          _final_amount = double.parse(_claimAmtIncidental.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text);
      }
    }
  }

  void _limitManager(
      String val,
      Travel data,
      TextEditingController claimController,
      TextEditingController gstAmt,
      TextEditingController basicAmt) {
    if (double.parse(val) > double.parse(data!.claimAmount.toString())) {
      claimController.text = data!.claimAmount.toString();
      gstAmt.text = data!.gstAmount.toString();
      basicAmt.text = data!.basicAmount.toString();
      Flushbar(
        message: "You can't exceed claim amount!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }

  void _limitManagerAcco(
      String val,
      Accomodation data,
      TextEditingController claimController,
      TextEditingController gstAmt,
      TextEditingController basicAmt) {
    if (double.parse(val) > double.parse(data!.claimAmount.toString())) {
      claimController.text = data!.claimAmount.toString();
      gstAmt.text = data!.gstAmount.toString();
      basicAmt.text = data!.basicAmount.toString();
      Flushbar(
        message: "You can't exceed claim amount!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }

  _originalInvStatus(dynamic? type, double width) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.06,
      color: Color.fromARGB(255, 239, 232, 169),
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.00,
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            color: Colors.amber,
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Original invoice :',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: SizeVariables.getWidth(context) * 0.05,
          ),
          type!.original_document_status.toString() == "1"
              ? Container(
                  width: width > 400
                      ? 7.w
                      : width < 300
                          ? 8.w
                          : 8.w,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black)),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.download_done,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(
                  width: width > 400
                      ? 7.w
                      : width < 300
                          ? 8.w
                          : 8.w,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _approvar_remarks(String type) {
    var remarks = "";
    if (type == "travel") {
      remarks = remarks_travel;
    }
    if (type == "acco") {
      remarks = remarks_acco;
    }
    if (type == "food") {
      remarks = remarks_food;
    }
    if (type == "incidental") {
      remarks = remarks_incidental;
    }
    if (type == "local") {
      remarks = remarks_local;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "REMARKS",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.007,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                remarks.toString() == "null"
                    ? "No Remarks Available"
                    : remarks.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_viewdocument(BuildContext context, link, original, String type) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color.fromARGB(255, 103, 103, 101),
      title: Container(
        child: Column(
          children: [
            Container(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'View your document',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 18),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                // left: SizeVariables.getWidth(context) * 0.1,
                top: SizeVariables.getHeight(context) * 0.06,
                bottom: SizeVariables.getHeight(context) * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    InkWell(
                      onTap: () {
                        print('link : $link');
                        bool searchpdf = link
                            .toString()
                            .toLowerCase()
                            .split(".")
                            .toSet()
                            .contains("pdf");
                        print(searchpdf.toString());

                        searchpdf
                            ? openFile(url: link, fileName: 'download.pdf')
                            : showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                    child: Container(
                                        height: 300,
                                        child: PhotoView(
                                          imageProvider: NetworkImage(link),
                                        ))),
                              );
                      },
                      child: Container(
                        child: Icon(
                          Icons.download,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Invoice',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                  type != "no_original"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(children: [
                            InkWell(
                              onTap: () {
                                // original = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
                                print('link : $original');
                                bool searchpdf = original
                                    .toString()
                                    .toLowerCase()
                                    .split(".")
                                    .toSet()
                                    .contains("pdf");
                                print(searchpdf.toString());

                                searchpdf
                                    ? openFile(
                                        url: original,
                                        fileName: 'original_inv.pdf')
                                    : showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                            child: Container(
                                                height: 300,
                                                child: PhotoView(
                                                  imageProvider:
                                                      NetworkImage(original),
                                                ))),
                                      );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.file_download_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  ' Org. invoice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future openFile({required String url, required String? fileName}) async {
  final file = await downloadFile(url, fileName!);
  if (file == null) return;

  print('Path: ${file.path}');

  OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String fileName) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  final appStorage = await getApplicationDocumentsDirectory();
  final file = File('${appStorage.path}/$fileName');

  try {
    final response = await Dio().get(url,
        options: Options(
            responseType: ResponseType.bytes,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${localStorage.getString('token')}'
            },
            followRedirects: false,
            receiveTimeout: 0));

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  } catch (e) {
    return null;
    // return null;
  }
}



// List<TimelineCard> _getCard() {
//   List<TimelineCard> timelineCard = [];

//   timelineCard.add(TimelineCard("₹ 25,000","", Icons.download_done));
//   timelineCard.add(TimelineCard("₹ 25,000","", Icons.download_done));

// }
 