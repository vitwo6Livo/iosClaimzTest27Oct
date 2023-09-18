import 'dart:io';

import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClaimzlistShow extends StatefulWidget {
  Map<String, dynamic> arguments;
  ClaimzlistShow(Map<String, dynamic> this.arguments);

  // const ClaimzlistShow({Key? key}) : super(key: key);

  @override
  State<ClaimzlistShow> createState() => _ClaimzlistShowState();
}

class _ClaimzlistShowState extends State<ClaimzlistShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // height: SizeVariables.getHeight(context)*2,
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: ListView(
          children: [
            Container(
              height: SizeVariables.getHeight(context) * 0.07,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02,
                        left: SizeVariables.getWidth(context) * 0.01),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Travel Claimz Details',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.017,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          Icons.flight_takeoff_outlined,
                          color: const Color(0xffF59F23),
                          size: 27,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeVariables.getWidth(context) * 0.008,
                    ),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Itinerary Details',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontStyle: FontStyle.italic, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  height: SizeVariables.getHeight(context) * 0.001,
                  width: SizeVariables.getWidth(context) * 0.6,
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.026,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'DOC No:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments["doc_no"].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Mode of travel:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['mod_of_travel'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Way of Trip:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['trip_way'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Visit From:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['from_place'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'visit To:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['to_place'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Accomodation:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['mod_of_acco'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.06,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          Icons.file_present_outlined,
                          size: 27,
                          color: const Color(0xffF59F23),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeVariables.getWidth(context) * 0.007,
                    ),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claims Details',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontStyle: FontStyle.italic, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  height: SizeVariables.getHeight(context) * 0.001,
                  width: SizeVariables.getWidth(context) * 0.6,
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.026,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'GST No:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['gst_no'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'GST Amount:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['gst_amount'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Basic Amount:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['basic_amount'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim Amount:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['claim_amount'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Payment Type:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['payment_type'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Exchnage Rate:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['exchange_rate'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'From Date:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['from_date'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'To Date:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['to_date'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'From Time:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['from_time'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'To Time:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['to_time'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim Date:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['date'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Name of Service Provider:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['service_provider'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.06,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: FittedBox(
                        child: Icon(
                          Icons.handshake_outlined,
                          size: 27,
                          color: const Color(0xffF59F23),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeVariables.getWidth(context) * 0.007,
                    ),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Metting Details',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontStyle: FontStyle.italic, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  height: SizeVariables.getHeight(context) * 0.001,
                  width: SizeVariables.getWidth(context) * 0.6,
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.026,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Met Whom:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['met_whom'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Purpose:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['purpose_of_visit'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Feedback:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color.fromARGB(255, 225, 184, 59)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.1),
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments['feedback'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.08,
            ),
            Center(
              child: AppButtonStyle(
                label: 'Download Doc',
                onPressed: () async {
                  // openFile(
                  //   url: widget.arguments['document'].toString(),
                  //   fileName:widget.arguments['document'].toString(), );

                  // final externalDir = await getExternalStorageDirectory();
                  // final taskId = await FlutterDownloader.enqueue(
                  //   url: widget.arguments['document'],
                  //   // savedDir: 'the path of directory where you want to save downloaded files',
                  //   showNotification: true, // show download progress in status bar (for Android)
                  //   openFileFromNotification: true,
                  //   savedDir: externalDir!.path, // click on notification to open downloaded file (for Android)
                  // );

                  // Map<Permission, PermissionStatus> statuses = await [
                  //   Permission.storage,
                  //   //add more permission to request here.
                  // ].request();
                  //
                  // if(statuses[Permission.storage]!.isGranted){
                  //   var dir = await DownloadsPathProvider.downloadsDirectory;
                  //   if(dir != null){
                  //     String savename = "file.pdf";
                  //     String savePath = dir.path + "/$savename";
                  //     print(savePath);
                  //     //output:  /storage/emulated/0/Download/banner.png
                  //
                  //     try {
                  //       await Dio().download(
                  //           widget.arguments['document'].toString(),
                  //           savePath,
                  //           onReceiveProgress: (received, total) {
                  //             if (total != -1) {
                  //               print((received / total * 100).toStringAsFixed(0) + "%");
                  //               //you can build progressbar feature too
                  //             }
                  //           });
                  //       print("File is saved to download folder.");
                  //     } on DioError catch (e) {
                  //       print(e.message);
                  //     }
                  //   }
                  // }else{
                  //   print("No permission to read and write.");
                  // }
                  //
                },
              ),
              // InkWell(
              //   onTap: () async {
              //     final externalDir = await getExternalStorageDirectory();
              //     final taskId = await FlutterDownloader.enqueue(
              //       url: widget.arguments['document'],
              //       // savedDir: 'the path of directory where you want to save downloaded files',
              //       showNotification: true, // show download progress in status bar (for Android)
              //       openFileFromNotification: true,
              //       savedDir: externalDir!.path, // click on notification to open downloaded file (for Android)
              //     );
              //   },
              //   child: AppButtonStyle(
              //     label: 'Download Doc',
              //     onPressed: () {
              //       openFile(
              //         url: widget.arguments['document'].toString(),
              //         fileName:widget.arguments['document'].toString(), );
              //     },
              //   ),
              // ),
            ),
            Container(
              height: SizeVariables.getHeight(context) * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Future openFile({required String url, required String fileName}) async {
    final file = await downloadFile(url, fileName);
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
      throw e;
      // return null;
    }
  }
}
