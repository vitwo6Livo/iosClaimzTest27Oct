import 'dart:convert';

import 'package:claimz/models/ticket.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/custom_page_route.dart';
import 'package:claimz/views/screens/ticketScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class TicketHistroy extends StatefulWidget {
  // const TicketHistroy({Key? key}) : super(key: key);
  List ticketList = [];

  TicketHistroy(this.ticketList);

  @override
  State<TicketHistroy> createState() => _TicketHistroyState();
}

class _TicketHistroyState extends State<TicketHistroy> {
  List<Ticket> _allticketList = [];
  bool _isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _getAllTickets().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  // Future<dynamic> _getAllTickets() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var response = await http.post(
  //     Uri.parse('http://claimz.vitwo.in/api/get-ticket'),
  //     headers: {
  //       'Authorization': 'Bearer ${localStorage.getString('token')}',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     var responseBody = json.decode(response.body);
  //     //print('responseBody: $responseBody');
  //     //print('responseBody[data] : ${responseBody['data']}');
  //     List ticketList = responseBody['data'];
  //     if (ticketList.isEmpty || ticketList.length == 0) {
  //       setState(() {
  //         _allticketList = [];
  //       });
  //     } else {
  //       setState(() {
  //         _allticketList = ticketList
  //             .map(
  //               (item) => Ticket(
  //                 description: item['description'],
  //                 id: item['ticket_unique_id'],
  //                 status: item['status'],
  //                 title: item['title'],
  //                 createDate: item['create_date'],
  //                 createdDate: item['created_at'],
  //                 doneDate: item['done_date'],
  //                 ongoingDate: item['ongoing_date'],
  //                 priority: item['priority'],
  //               ),
  //             )
  //             .toList();
  //       });
  //     }
  //     //print(ticketList);

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('ticket-list: ${widget.ticketList}');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: [
        Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.of(context).push(CustomPageRoute(
          //         child: TicketScreen(), direction: AxisDirection.up));
          //   },
          //   backgroundColor: Colors.amberAccent,
          //   child: Icon(
          //     Icons.add,
          //     color: Colors.black,
          //   ),
          // ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                // Row(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //         top: SizeVariables.getHeight(context) * 0.02,
                //       ),
                //       child: InkWell(
                //         onTap: () {
                //           // Navigator.of(context).pop();
                //           Navigator.pushNamed(context, RouteNames.ticketmanu);
                //         },
                //         child: SvgPicture.asset(
                //           "assets/icons/back button.svg",
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(
                //           top: SizeVariables.getHeight(context) * 0.024,
                //           left: SizeVariables.getWidth(context) * 0.01),
                //       child: FittedBox(
                //         fit: BoxFit.contain,
                //         child: Text(
                //           'Ticket History',
                //           style: Theme.of(context).textTheme.caption,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  width: double.infinity,
                  height: SizeVariables.getHeight(context) * 0.9,
                  // color: Colors.amber,
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.02,
                    top: SizeVariables.getHeight(context) * 0.02,
                    right: SizeVariables.getWidth(context) * 0.02,
                  ),
                  child: ListView.builder(
                    itemCount: widget.ticketList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: SizeVariables.getHeight(context) * 0.02,
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // Future.delayed(const Duration(seconds: 8),
                              //     () => Navigator.of(context).pop());
                              return CupertinoAlertDialog(
                                content: Container(
                                  // height: SizeVariables.getHeight(context)*0.3,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.message_outlined,
                                                    color: Color.fromARGB(
                                                        255, 88, 87, 87),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      widget
                                                          .ticketList[index].id,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.low_priority_outlined,
                                                    color: Color.fromARGB(
                                                        255, 70, 69, 69),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      widget.ticketList[index]
                                                          .priority
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
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
                                            SizeVariables.getHeight(context) *
                                                0.02,
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        // height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          widget.ticketList[index].description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.black),
                                          textAlign: TextAlign.start,
                                          // overflow: TextOverflow.ellipsis,
                                          // maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
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
                            },
                          );
                        },
                        child: Container(
                          // color: Colors.amber,
                          child: ContainerStyle(
                            height: height > 750
                                ? 22.h
                                : height < 650
                                    ? 31.h
                                    : 27.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.message_outlined,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  widget.ticketList[index].id,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.low_priority_outlined,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  widget.ticketList[index]
                                                      .priority
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // color: Colors.amber,
                                    height: 40,
                                    width: double.infinity,
                                    child: Text(
                                      widget.ticketList[index].description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: (widget.ticketList[index]
                                                          .createDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .ongoingDate ==
                                                      null &&
                                                  widget.ticketList[index]
                                                          .doneDate ==
                                                      null)
                                              ? EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5)
                                              : null,
                                          decoration: (widget.ticketList[index]
                                                          .createDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .ongoingDate ==
                                                      null &&
                                                  widget.ticketList[index]
                                                          .doneDate ==
                                                      null)
                                              ? BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 103, 122, 114),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 109, 247, 143),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                )
                                              : BoxDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Container(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "Open",
                                                      style: (widget.ticketList[index].createDate != null &&
                                                              widget
                                                                      .ticketList[
                                                                          index]
                                                                      .ongoingDate ==
                                                                  null &&
                                                              widget
                                                                      .ticketList[
                                                                          index]
                                                                      .doneDate ==
                                                                  null)
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        109,
                                                                        247,
                                                                        143),
                                                              )
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              (widget.ticketList[index]
                                                          .createDate ==
                                                      null)
                                                  ? Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '-- --',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(DateTime.parse(widget
                                                                      .ticketList[
                                                                          index]
                                                                      .createDate!)),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .blue),
                                                            ),
                                                            Text(
                                                              DateFormat.Hms().format(
                                                                  DateTime.parse(widget
                                                                      .ticketList[
                                                                          index]
                                                                      .createDate!)),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .blue),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: (widget.ticketList[index]
                                                          .createDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .ongoingDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .doneDate ==
                                                      null)
                                              ? EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5)
                                              : null,
                                          decoration: (widget.ticketList[index]
                                                          .createDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .ongoingDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .doneDate ==
                                                      null)
                                              ? BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 103, 122, 114),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 109, 247, 143),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                )
                                              : BoxDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Container(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "In Progress",
                                                      style: (widget.ticketList[index].createDate != null &&
                                                              widget
                                                                      .ticketList[
                                                                          index]
                                                                      .ongoingDate !=
                                                                  null &&
                                                              widget
                                                                      .ticketList[
                                                                          index]
                                                                      .doneDate ==
                                                                  null)
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          109,
                                                                          247,
                                                                          143))
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              (widget.ticketList[index]
                                                          .ongoingDate ==
                                                      null)
                                                  ? Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '-- --',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .amber),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          widget
                                                                  .ticketList[index]
                                                                  .ongoingDate!
                                                                  .split(' ')[0]
                                                              as String,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          109,
                                                                          247,
                                                                          143)),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: (widget.ticketList[index]
                                                          .createDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .ongoingDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .doneDate !=
                                                      null)
                                              ? EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 5)
                                              : null,
                                          decoration: (widget.ticketList[index]
                                                          .createDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .ongoingDate !=
                                                      null &&
                                                  widget.ticketList[index]
                                                          .doneDate !=
                                                      null)
                                              ? BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 103, 122, 114),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 109, 247, 143),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                )
                                              : BoxDecoration(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Container(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      "Close",
                                                      style: (widget.ticketList[index].createDate != null &&
                                                              widget
                                                                      .ticketList[
                                                                          index]
                                                                      .ongoingDate !=
                                                                  null &&
                                                              widget
                                                                      .ticketList[
                                                                          index]
                                                                      .doneDate !=
                                                                  null)
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        109,
                                                                        247,
                                                                        143),
                                                              )
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              (widget.ticketList[index]
                                                          .doneDate ==
                                                      null)
                                                  ? Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '-- --',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          widget
                                                                  .ticketList[index]
                                                                  .doneDate!
                                                                  .split(' ')[0]
                                                              as String,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            109,
                                                                            247,
                                                                            143),
                                                                  ),
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
