import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/components/alert_dialog.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/leaveRequestViewModel.dart';
import '../../../config/mediaQuery.dart';
import '../../../screens/employeeRecord/viewEmployeeRecordScreen.dart';

class PendingLeaves extends StatefulWidget {
  final List<dynamic> list;
  final List<dynamic> listTwo;
  final String month;
  final String year;

  PendingLeaves(this.list, this.listTwo, this.month, this.year);

  PendingLeavesState createState() => PendingLeavesState();
}

class PendingLeavesState extends State<PendingLeaves> {
  DateFormat day = DateFormat('dd');
  DateFormat monthFormat = DateFormat('MMM');
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  var selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    print('PENDING LEAVES: ${widget.list}');
    print('PENDING LEAVES TWO: ${widget.listTwo}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    // final provider = Provider.of<LeaveRequestViewModel>(context).pendingLeaves;
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          top: SizeVariables.getHeight(context) * 0.01,
          right: SizeVariables.getWidth(context) * 0.025),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => Column(
                      children: [
                        InkWell(
                          onTap: () =>
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => CupertinoAlertDialog(
                              //           title: const Text('Reason',
                              //               style: TextStyle(fontSize: 20)),
                              //           content: Text(provider[index]['description']),
                              //           actions: [
                              //             TextButton(
                              //               onPressed: () {
                              //                 Navigator.pop(context); //close Dialog
                              //               },
                              //               child: Text(
                              //                 'Close',
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .bodyText1!
                              //                     .copyWith(color: Colors.black),
                              //               ),
                              //             )
                              //           ],
                              //         )),

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EmployeeRecordScreen(
                                              false,
                                              int.parse(
                                                  widget.list[index]['emp_id']),
                                              widget.listTwo[index],
                                              widget.month,
                                              widget.year,
                                              true,
                                              widget.list[index]['name'],
                                              true))),

                          //THIS HERE IS THE ORIGINAL CODE

                          // showDialog(
                          //     barrierColor: Colors.black87.withOpacity(0.9),
                          //     context: context,
                          //     builder: (context) {
                          //       return CupertinoAlertDialog(
                          //         content: Container(
                          //           // height:
                          //           //     SizeVariables.getHeight(context) *
                          //           //         0.22,

                          //           // color: Colors.amber,
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Container(
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment
                          //                           .spaceBetween,
                          //                   children: [
                          //                     Container(
                          //                       child: Row(
                          //                         children: [
                          //                           Text(
                          //                             'From: ',
                          //                             style: Theme.of(
                          //                                     context)
                          //                                 .textTheme
                          //                                 .bodyText1!
                          //                                 .copyWith(
                          //                                     color: Colors
                          //                                         .black),
                          //                           ),
                          //                           Text(
                          //                             widget.list[index]
                          //                                 ['dates'][0],
                          //                             style: Theme.of(
                          //                                     context)
                          //                                 .textTheme
                          //                                 .bodyText2!
                          //                                 .copyWith(
                          //                                     color: Colors
                          //                                         .black),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     Container(
                          //                       child: Row(
                          //                         children: [
                          //                           Text(
                          //                             'To: ',
                          //                             style: Theme.of(
                          //                                     context)
                          //                                 .textTheme
                          //                                 .bodyText1!
                          //                                 .copyWith(
                          //                                     color: Colors
                          //                                         .black),
                          //                           ),
                          //                           Text(
                          //                             widget
                          //                                 .list[index]
                          //                                     ['dates']
                          //                                 .last,
                          //                             style: Theme.of(
                          //                                     context)
                          //                                 .textTheme
                          //                                 .bodyText2!
                          //                                 .copyWith(
                          //                                     color: Colors
                          //                                         .black),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 height: SizeVariables.getHeight(
                          //                         context) *
                          //                     0.02,
                          //               ),
                          //               Row(
                          //                 children: [
                          //                   const Text('Applied On: '),
                          //                   Text(widget.list[index]
                          //                       ['created_at'])
                          //                 ],
                          //               ),
                          //               SizedBox(height: 10.sp),
                          //               Container(
                          //                 child: Text(
                          //                   "Reason",
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyText2!
                          //                       .copyWith(
                          //                           color: Colors.black),
                          //                 ),
                          //               ),
                          //               Text(
                          //                 widget.list[index]['description'],
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodyText1!
                          //                     .copyWith(
                          //                         // fontSize: 20,
                          //                         color: Colors.black),
                          //                 textAlign: TextAlign.start,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         actions: <Widget>[
                          //           TextButton(
                          //               onPressed: () {
                          //                 var response = Provider.of<
                          //                             LeaveRequestViewModel>(
                          //                         context,
                          //                         listen: false)
                          //                     .manageLeaves(
                          //                         widget.list[index]['id'],
                          //                         0,
                          //                         context,
                          //                         widget.list[index]);
                          //                 Navigator.of(context).pop();
                          //               },
                          //               child: Text(
                          //                 'Reject',
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodyText1!
                          //                     .copyWith(
                          //                         color: Colors.black),
                          //               )),
                          //           TextButton(
                          //             onPressed: () {
                          //               var response = Provider.of<
                          //                           LeaveRequestViewModel>(
                          //                       context,
                          //                       listen: false)
                          //                   .manageLeaves(
                          //                       widget.list[index]['id'],
                          //                       1,
                          //                       context,
                          //                       widget.list[index]);
                          //               Navigator.of(context).pop();
                          //             },
                          //             child: Text(
                          //               'Approve',
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .bodyText1!
                          //                   .copyWith(color: Colors.black),
                          //             ),
                          //           )
                          //         ],
                          //       );
                          //     }),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: (themeProvider.darkTheme)
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 7,
                                        //offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                            ),
                            child: ContainerStyle(
                              height: SizeVariables.getHeight(context) * 0.15,
                              child: Container(
                                height: double.infinity,
                                // color: Colors.green,
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        width: double.infinity,
                                        // color: Colors.red,
                                        // padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 5,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                height: double.infinity,
                                                // color: Colors.amber,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01),
                                                        child: widget.list[
                                                                        index][
                                                                    'profile_photo'] ==
                                                                null
                                                            ? CircleAvatar(
                                                                radius: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.08,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                backgroundImage:
                                                                    const AssetImage(
                                                                        'assets/img/profilePic.jpg'),
                                                                // child: const Icon(Icons.account_box, color: Colors.white),
                                                              )
                                                            : CachedNetworkImage(
                                                                imageUrl:
                                                                    '${widget.list[index]['profile_photo']}',
                                                                imageBuilder: (context,
                                                                        imageProvider) =>
                                                                    CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.08,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  backgroundImage:
                                                                      imageProvider,
                                                                  // child: const Icon(Icons.account_box, color: Colors.white),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Shimmer
                                                                        .fromColors(
                                                                  baseColor:
                                                                      Colors.grey[
                                                                          400]!,
                                                                  highlightColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          120,
                                                                          120,
                                                                          120),
                                                                  child: CircleAvatar(
                                                                      radius: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.08),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.08,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  backgroundImage:
                                                                      const AssetImage(
                                                                          'assets/img/profilePic.jpg'),
                                                                  // child: const Icon(Icons.account_box, color: Colors.white),
                                                                ),
                                                              )),
                                                    Expanded(
                                                      child: Container(
                                                        height: double.infinity,
                                                        // color: Colors.orange,
                                                        padding: EdgeInsets.only(
                                                            left: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.005,
                                                            top: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.008),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                widget.list[
                                                                        index]
                                                                    ['name'],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                            Text(
                                                              widget.list[index]
                                                                      [
                                                                      'emp_code']
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Flexible(
                                            //   flex: 1,
                                            //   fit: FlexFit.tight,
                                            //   child: Center(
                                            //     child: PopupMenuButton(
                                            //       icon: Icon(Icons.arrow_drop_down,
                                            //           color: Theme.of(context)
                                            //               .accentColor),
                                            //       // color: const Color.fromARGB(
                                            //       //     255, 77, 76, 76),
                                            //       color: Theme.of(context)
                                            //           .colorScheme
                                            //           .secondary,
                                            //       itemBuilder: (context) => [
                                            //         PopupMenuItem(
                                            //           value: 1,
                                            //           child: Text('Approve',
                                            //               style: Theme.of(context)
                                            //                   .textTheme
                                            //                   .bodyText1!
                                            //                   .copyWith(
                                            //                       color:
                                            //                           Colors.white)),
                                            //         ),
                                            //         PopupMenuItem(
                                            //           value: 0,
                                            //           child: Text('Reject',
                                            //               style: Theme.of(context)
                                            //                   .textTheme
                                            //                   .bodyText1!
                                            //                   .copyWith(
                                            //                       color:
                                            //                           Colors.white)),
                                            //         ),
                                            //       ],
                                            //       onSelected: (value) async {
                                            //         setState(() {
                                            //           selectedValue = value;
                                            //         });
                                            //         print('Selected Value: $value');

                                            //         // print('Selected Map: ${provider['data'][index]}');

                                            //         Provider.of<LeaveRequestViewModel>(
                                            //                 context,
                                            //                 listen: false)
                                            //             .manageLeaves(
                                            //                 provider[index]['id'],
                                            //                 selectedValue,
                                            //                 context,
                                            //                 provider[index]);
                                            //         //     .then((value) {
                                            //         //   // isLoading = true;
                                            //         //   // setState(() {
                                            //         //   //   Provider.of<LeaveRequestViewModel>(
                                            //         //   //           context,
                                            //         //   //           listen:
                                            //         //   //               false)
                                            //         //   //       .getLeaveRequest()
                                            //         //   //       .then(
                                            //         //   //           (value) {
                                            //         //   //     setState(() {
                                            //         //   //       isLoading =
                                            //         //   //           false;
                                            //         //   //     });
                                            //         //   //   });
                                            //         //   // });
                                            //         //   showDialog(
                                            //         //       context:
                                            //         //           context,
                                            //         //       builder: (context) => CustomDialog(
                                            //         //           title:
                                            //         //               '${value['data']}',
                                            //         //           subtitle: value
                                            //         //               .toString(),
                                            //         //           onOk: () =>
                                            //         //               Navigator.of(context)
                                            //         //                   .pop(),
                                            //         //           onCancel: () =>
                                            //         //               Navigator.of(context)
                                            //         //                   .pop()));
                                            //         // });
                                            //       },
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        width: double.infinity,
                                        // color: Colors.blue,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                height: double.infinity,
                                                // color: Colors.amber,
                                                padding: EdgeInsets.all(
                                                    SizeVariables.getWidth(
                                                            context) *
                                                        0.02),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        widget.list[index]
                                                            ['dates'][0],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    127,
                                                                    182,
                                                                    129))),
                                                    Text(
                                                        widget
                                                            .list[index]
                                                                ['dates']
                                                            .last,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    248,
                                                                    112,
                                                                    78)))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 4,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                height: double.infinity,
                                                // color: Colors.red,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Text('|',
                                                      //     style: Theme.of(context)
                                                      //         .textTheme
                                                      //         .bodyText2),
                                                      // SizedBox(
                                                      //     width:
                                                      //         SizeVariables.getWidth(context) *
                                                      //             0.005),
                                                      Text(
                                                          // provider[
                                                          //             index]
                                                          //         ['dates']
                                                          //     .length
                                                          //     .toString(),
                                                          // provider[index]
                                                          //             ['dates']
                                                          //         .isEmpty
                                                          //     ? '0'
                                                          //     : provider[index]
                                                          //             ['dates']
                                                          //         .length
                                                          //         .toString(),
                                                          widget.list[index]
                                                                  ['date_count']
                                                              .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                      SizedBox(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.01),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Day(s)',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Center(
                                                child: Text(
                                                  widget.list[index]
                                                              ['leave_type'] ==
                                                          '3'
                                                      ? 'PL'
                                                      : widget.list[index][
                                                                  'leave_type'] ==
                                                              '1'
                                                          ? 'CL'
                                                          : widget.list[index][
                                                                      'leave_type'] ==
                                                                  '2'
                                                              ? 'SL'
                                                              : 'CO',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
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
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        )
                      ],
                    ),
                itemCount: widget.list.length
                // provider['data'].length
                ),
          ),
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue,
                canvasColor: Colors.blue,
                colorScheme: const ColorScheme.light(primary: Colors.blue),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
    });

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    print('dateRange: $dateRange');
    return dateRange;
  }
}
