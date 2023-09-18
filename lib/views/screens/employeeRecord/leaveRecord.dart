import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../res/components/containerStyle.dart';
import '../../../viewModel/leaveRequestViewModel.dart';
import '../../../viewModel/reportingTreeViewModel.dart';
import '../../config/mediaQuery.dart';

class EmployeeLeaveReport extends StatefulWidget {
  final bool fromLeaveScreen;
  final String fromDate;
  final String toDate;

  EmployeeLeaveReport(this.fromLeaveScreen, this.fromDate, this.toDate);

  @override
  State<EmployeeLeaveReport> createState() => _EmployeeLeaveReportState();
}

class _EmployeeLeaveReportState extends State<EmployeeLeaveReport> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportingTreeViewModel>(context).report;
    final leaveProvider =
        Provider.of<ReportingTreeViewModel>(context).allLeaves;
    final providerTwo =
        Provider.of<LeaveRequestViewModel>(context).pendingLeaves;
    final themeProvider = Provider.of<ThemeProvider>(context);

    print('PROVIDER: $provider');

    print('PROVIDER TWO: $providerTwo');

    @override
    void dispose() {
      super.dispose();
    }

    // TODO: implement build
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              // color: Colors.red,
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                        width: SizeVariables.getWidth(context) * 0.33,
                        margin: EdgeInsets.only(
                            right: SizeVariables.getWidth(context) * 0.05),
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
                              height: SizeVariables.getHeight(context) * 0.16,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          // color: Colors.red,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: SizeVariables.getWidth(
                                                        context) *
                                                    0.04),
                                            child: Text(
                                                provider['leave_balance'][index]
                                                    ['leave_types'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(fontSize: 18)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.016,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.04),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              '${provider['leave_balance'][index]['number']} Day(s)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                  itemCount: provider['leave_balance'].length),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              // color: Colors.green,
              padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.05,
                  right: SizeVariables.getWidth(context) * 0.05),
              child: ListView.builder(
                itemBuilder: (context, index) => leaveProvider.isEmpty
                    ? Center(
                        child: Lottie.asset('assets/json/ToDo.json'),
                      )
                    : Column(
                        children: [
                          leaveProvider[index]['dates'].isEmpty
                              ? Container()
                              : InkWell(
                                  onTap:
                                      widget.fromLeaveScreen == false ||
                                              leaveProvider[index]['status'] !=
                                                  0
                                          ? () {}
                                          : () => showDialog(
                                                barrierColor: Colors.black87
                                                    .withOpacity(0.9),
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    content: Container(
                                                      // height:
                                                      //     SizeVariables.getHeight(context) *
                                                      //         0.22,

                                                      // color: Colors.amber,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'From: ',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                      Text(
                                                                        leaveProvider[index]
                                                                            [
                                                                            'dates'][0],
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'To: ',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                      Text(
                                                                        leaveProvider[index]['dates']
                                                                            .last,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.02,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  'Applied On: '),
                                                              Text(leaveProvider[
                                                                      index][
                                                                  'created_at'])
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 10.sp),
                                                          Container(
                                                            child: Text(
                                                              "Reason",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                          Text(
                                                            leaveProvider[index]
                                                                ['description'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    // fontSize: 20,
                                                                    color: Colors
                                                                        .black),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(context)
                                                            //     .pop();

                                                            var response = Provider.of<
                                                                        LeaveRequestViewModel>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .manageRejectLeave(
                                                                    leaveProvider[
                                                                            index]
                                                                        [
                                                                        'leave_id'],
                                                                    2,
                                                                    context,
                                                                    // providerTwo[
                                                                    //     index]
                                                                    leaveProvider[
                                                                        index],
                                                                    widget
                                                                        .fromDate,
                                                                    widget
                                                                        .toDate);
                                                            // Navigator.of(context)
                                                            //     .pop();
                                                          },
                                                          child: Text(
                                                            'Reject',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          )),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Navigator.of(context).pop();

                                                          var response = Provider.of<
                                                                      LeaveRequestViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .manageApproveLeave(
                                                                  leaveProvider[
                                                                          index]
                                                                      [
                                                                      'leave_id'],
                                                                  1,
                                                                  context,
                                                                  leaveProvider[
                                                                      index],
                                                                  // providerTwo[index],
                                                                  widget
                                                                      .fromDate,
                                                                  widget
                                                                      .toDate);
                                                          // Navigator.of(context).pop();
                                                        },
                                                        child: Text(
                                                          'Approve',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                  child: ContainerStyle(
                                    height:
                                        SizeVariables.getHeight(context) * 0.12,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Container(
                                              height: double.infinity,
                                              // color: Colors.red,
                                              padding: EdgeInsets.only(
                                                  left: SizeVariables.getWidth(
                                                          context) *
                                                      0.05),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    leaveProvider[index]
                                                        ['leave_type'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: 16),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        // value.leaveList.data!
                                                        //     .data![index].dates![0],
                                                        leaveProvider[index]
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
                                                                    129)),
                                                      ),
                                                      // Text(
                                                      //   '-',
                                                      //   style: Theme.of(context).textTheme.bodyText1,
                                                      // ),
                                                      Text(
                                                        leaveProvider[index][
                                                                        'dates']
                                                                    .length ==
                                                                1
                                                            ? leaveProvider[
                                                                    index]
                                                                ['dates'][0]
                                                            : leaveProvider[
                                                                        index]
                                                                    ['dates']
                                                                .last,
                                                        // value.leaveList.data!
                                                        //     .data![index].dates!.last,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    248,
                                                                    112,
                                                                    78)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.loose,
                                            child: Container(
                                              height: double.infinity,
                                              // color: Colors.green,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
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
                                                            // value
                                                            //     .leaveList
                                                            //     .data!
                                                            //     .data![index]
                                                            //     .dates!
                                                            //     .length
                                                            //     .toString(),
                                                            // value
                                                            //     .leaveList
                                                            //     .data!
                                                            //     .data![index]
                                                            //     .dates!
                                                            //     .length
                                                            //     .toString(),
                                                            leaveProvider[index]
                                                                            [
                                                                            'dates']
                                                                        .length ==
                                                                    1
                                                                ? '1'
                                                                : (DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(leaveProvider[index]['dates'][1]))).difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(leaveProvider[index]['dates'][0])))).inDays +
                                                                        1)
                                                                    .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                    fontSize:
                                                                        30,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                        SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01),
                                                        Column(
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
                                                      ])
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
                                              child: Center(
                                                  child: leaveProvider[index]
                                                              ['status'] ==
                                                          1
                                                      ? const Icon(Icons.check,
                                                          color: Colors.green)
                                                      : leaveProvider[index]
                                                                  ['status'] ==
                                                              2
                                                          ? const Icon(
                                                              Icons.close,
                                                              color: Colors.red)
                                                          : const Icon(
                                                              Icons.timer,
                                                              color: Colors
                                                                  .amber)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.02)
                        ],
                      ),
                itemCount: leaveProvider.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}











// ListView.builder(
//                 itemBuilder: (context, index) => provider['leave'].isEmpty
//                     ? Center(
//                         child: Lottie.asset('assets/json/ToDo.json'),
//                       )
//                     : Column(
//                         children: [
//                           provider['leave'][index]['dates'].isEmpty
//                               ? Container()
//                               : InkWell(
//                                   onTap: fromLeaveScreen == false ||
//                                           provider['leave'][index]['status'] !=
//                                               0
//                                       ? () {}
//                                       : () => showDialog(
//                                           barrierColor:
//                                               Colors.black87.withOpacity(0.9),
//                                           context: context,
//                                           builder: (context) {
//                                             return CupertinoAlertDialog(
//                                               content: Container(
//                                                 // height:
//                                                 //     SizeVariables.getHeight(context) *
//                                                 //         0.22,

//                                                 // color: Colors.amber,
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Container(
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Container(
//                                                             child: Row(
//                                                               children: [
//                                                                 Text(
//                                                                   'From: ',
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .bodyText1!
//                                                                       .copyWith(
//                                                                           color:
//                                                                               Colors.black),
//                                                                 ),
//                                                                 Text(
//                                                                   provider['leave']
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       'dates'][0],
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .bodyText2!
//                                                                       .copyWith(
//                                                                           color:
//                                                                               Colors.black),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                             child: Row(
//                                                               children: [
//                                                                 Text(
//                                                                   'To: ',
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .bodyText1!
//                                                                       .copyWith(
//                                                                           color:
//                                                                               Colors.black),
//                                                                 ),
//                                                                 Text(
//                                                                   provider['leave']
//                                                                               [
//                                                                               index]
//                                                                           [
//                                                                           'dates']
//                                                                       .last,
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .bodyText2!
//                                                                       .copyWith(
//                                                                           color:
//                                                                               Colors.black),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: SizeVariables
//                                                               .getHeight(
//                                                                   context) *
//                                                           0.02,
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         const Text(
//                                                             'Applied On: '),
//                                                         Text(provider['leave']
//                                                                 [index]
//                                                             ['created_at'])
//                                                       ],
//                                                     ),
//                                                     SizedBox(height: 10.sp),
//                                                     Container(
//                                                       child: Text(
//                                                         "Reason",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText2!
//                                                             .copyWith(
//                                                                 color: Colors
//                                                                     .black),
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       provider['leave'][index]
//                                                           ['description'],
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText1!
//                                                           .copyWith(
//                                                               // fontSize: 20,
//                                                               color:
//                                                                   Colors.black),
//                                                       textAlign:
//                                                           TextAlign.start,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               actions: <Widget>[
//                                                 TextButton(
//                                                     onPressed: () {
//                                                       var response = Provider
//                                                               .of<LeaveRequestViewModel>(
//                                                                   context,
//                                                                   listen: false)
//                                                           .manageLeaves(
//                                                               provider['leave']
//                                                                       [index]
//                                                                   ['leave_id'],
//                                                               2,
//                                                               context,
//                                                               // providerTwo[
//                                                               //     index]
//                                                               provider['leave']
//                                                                   [index],
//                                                               fromDate,
//                                                               toDate);
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     },
//                                                     child: Text(
//                                                       'Reject',
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText1!
//                                                           .copyWith(
//                                                               color:
//                                                                   Colors.black),
//                                                     )),
//                                                 TextButton(
//                                                   onPressed: () {
//                                                     var response = Provider.of<
//                                                                 LeaveRequestViewModel>(
//                                                             context,
//                                                             listen: false)
//                                                         .manageLeaves(
//                                                             provider['leave']
//                                                                     [index]
//                                                                 ['leave_id'],
//                                                             1,
//                                                             context,
//                                                             provider['leave']
//                                                                 [index],
//                                                             // providerTwo[index],
//                                                             fromDate,
//                                                             toDate);
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                   child: Text(
//                                                     'Approve',
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                 )
//                                               ],
//                                             );
//                                           }),
//                                   child: ContainerStyle(
//                                     height:
//                                         SizeVariables.getHeight(context) * 0.12,
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: double.infinity,
//                                       // color: Colors.red,
//                                       child: Row(
//                                         children: [
//                                           Flexible(
//                                             flex: 1,
//                                             fit: FlexFit.tight,
//                                             child: Container(
//                                               height: double.infinity,
//                                               // color: Colors.red,
//                                               padding: EdgeInsets.only(
//                                                   left: SizeVariables.getWidth(
//                                                           context) *
//                                                       0.05),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     provider['leave'][index]
//                                                         ['leave_type'],
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             color: Colors.grey,
//                                                             fontSize: 16),
//                                                   ),
//                                                   Column(
//                                                     children: [
//                                                       Text(
//                                                         // value.leaveList.data!
//                                                         //     .data![index].dates![0],
//                                                         provider['leave'][index]
//                                                             ['dates'][0],

//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText1!
//                                                             .copyWith(
//                                                                 color: const Color
//                                                                         .fromARGB(
//                                                                     255,
//                                                                     127,
//                                                                     182,
//                                                                     129)),
//                                                       ),
//                                                       // Text(
//                                                       //   '-',
//                                                       //   style: Theme.of(context).textTheme.bodyText1,
//                                                       // ),
//                                                       Text(
//                                                         provider['leave'][index]
//                                                                         [
//                                                                         'dates']
//                                                                     .length ==
//                                                                 1
//                                                             ? provider['leave']
//                                                                     [index]
//                                                                 ['dates'][0]
//                                                             : provider['leave']
//                                                                         [index]
//                                                                     ['dates']
//                                                                 .last,
//                                                         // value.leaveList.data!
//                                                         //     .data![index].dates!.last,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText1!
//                                                             .copyWith(
//                                                                 color: const Color
//                                                                         .fromARGB(
//                                                                     255,
//                                                                     248,
//                                                                     112,
//                                                                     78)),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           Flexible(
//                                             flex: 1,
//                                             fit: FlexFit.loose,
//                                             child: Container(
//                                               height: double.infinity,
//                                               // color: Colors.green,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         // Text('|',
//                                                         //     style: Theme.of(context)
//                                                         //         .textTheme
//                                                         //         .bodyText2),
//                                                         // SizedBox(
//                                                         //     width:
//                                                         //         SizeVariables.getWidth(context) *
//                                                         //             0.005),
//                                                         Text(
//                                                             // value
//                                                             //     .leaveList
//                                                             //     .data!
//                                                             //     .data![index]
//                                                             //     .dates!
//                                                             //     .length
//                                                             //     .toString(),
//                                                             // value
//                                                             //     .leaveList
//                                                             //     .data!
//                                                             //     .data![index]
//                                                             //     .dates!
//                                                             //     .length
//                                                             //     .toString(),
//                                                             provider['leave'][index]
//                                                                             [
//                                                                             'dates']
//                                                                         .length ==
//                                                                     1
//                                                                 ? '1'
//                                                                 : (DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(provider['leave'][index]['dates'][1]))).difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(provider['leave'][index]['dates'][0])))).inDays +
//                                                                         1)
//                                                                     .toString(),
//                                                             style: Theme.of(
//                                                                     context)
//                                                                 .textTheme
//                                                                 .bodyText2!
//                                                                 .copyWith(
//                                                                     fontSize:
//                                                                         30,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .normal)),
//                                                         SizedBox(
//                                                             width: SizeVariables
//                                                                     .getWidth(
//                                                                         context) *
//                                                                 0.01),
//                                                         Column(
//                                                           children: [
//                                                             Text(
//                                                               'Day(s)',
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .bodyText2!
//                                                                   .copyWith(
//                                                                       fontSize:
//                                                                           12),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       ])
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           Flexible(
//                                             flex: 1,
//                                             fit: FlexFit.tight,
//                                             child: Container(
//                                               height: double.infinity,
//                                               // color: Colors.blue,
//                                               child: Center(
//                                                   child: provider['leave']
//                                                                   [index]
//                                                               ['status'] ==
//                                                           1
//                                                       ? const Icon(Icons.check,
//                                                           color: Colors.green)
//                                                       : provider['leave'][index]
//                                                                   ['status'] ==
//                                                               2
//                                                           ? const Icon(
//                                                               Icons.close,
//                                                               color: Colors.red)
//                                                           : const Icon(
//                                                               Icons.timer,
//                                                               color: Colors
//                                                                   .amber)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                           SizedBox(
//                               height: SizeVariables.getHeight(context) * 0.02)
//                         ],
//                       ),
//                 itemCount: provider['leave'].length,
//               )