import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../res/components/containerStyle.dart';
import '../../../viewModel/reportingTreeViewModel.dart';
import '../../config/mediaQuery.dart';

class EmployeeRegularisationReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportingTreeViewModel>(context).report;
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return Container(
        width: double.infinity,
        height: SizeVariables.getHeight(context) * 0.99,
        // color: Colors.amber,
        padding: EdgeInsets.only(
            left: SizeVariables.getWidth(context) * 0.02,
            top: SizeVariables.getHeight(context) * 0.02,
            right: SizeVariables.getWidth(context) * 0.02),
        child: provider['regularization'].isEmpty || provider == {}
            ? Center(
                child: Text('No Regularisations Raised For The Given Period',
                    style: Theme.of(context).textTheme.bodyText1),
              )
            : ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
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
                        height: SizeVariables.getHeight(context) * 0.12,
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
                                  //color: Colors.red,
                                  padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.05),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider['regularization'][index]
                                            ['name'],
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
                                            provider['regularization'][index]
                                                ['attendance_date'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 127, 182, 129)),
                                          ),
                                          // Text(
                                          //   '-',
                                          //   style: Theme.of(context).textTheme.bodyText1,
                                          // ),
                                          // Text(
                                          //   value.leaveList.regularization!
                                          //       .regularization![index].dates!.last,
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText1!
                                          //       .copyWith(
                                          //           color: const Color
                                          //                   .fromARGB(
                                          //               255, 248, 112, 78)),
                                          // ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Text('|',
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText2),
                                            // SizedBox(
                                            //     width:
                                            //         SizeVariables.getWidth(context) *
                                            //             0.005),
                                            // Text(
                                            //     // value
                                            //     //     .leaveList
                                            //     //     .regularization!
                                            //     //     .regularization![index]
                                            //     //     .dates!
                                            //     //     .length
                                            //     //     .toString(),
                                            //     '${DateFormat('yyyy-MM-dd').parse(value.leaveList.regularization!.regularization![index].dates![1]).difference(DateFormat('yyyy-MM-dd').parse(value.leaveList.regularization!.regularization![index].dates![0])).inDays + 1}',
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText2!
                                            //         .copyWith(
                                            //             fontSize: 30,
                                            //             fontWeight:
                                            //                 FontWeight
                                            //                     .normal)),
                                            Text(
                                                provider['regularization']
                                                    [index]['checkin'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: const Color
                                                            .fromARGB(255, 248,
                                                            112, 78))),

                                            // Column(
                                            //   children: [
                                            //     Text(
                                            //       'Day(s)',
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodyText2!
                                            //           .copyWith(
                                            //               fontSize: 12),
                                            //     ),
                                            //   ],
                                            // )
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Text('|',
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText2),
                                            // SizedBox(
                                            //     width:
                                            //         SizeVariables.getWidth(context) *
                                            //             0.005),
                                            // Text(
                                            //     // value
                                            //     //     .leaveList
                                            //     //     .regularization!
                                            //     //     .regularization![index]
                                            //     //     .dates!
                                            //     //     .length
                                            //     //     .toString(),
                                            //     '${DateFormat('yyyy-MM-dd').parse(value.leaveList.regularization!.regularization![index].dates![1]).difference(DateFormat('yyyy-MM-dd').parse(value.leaveList.regularization!.regularization![index].dates![0])).inDays + 1}',
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText2!
                                            //         .copyWith(
                                            //             fontSize: 30,
                                            //             fontWeight:
                                            //                 FontWeight
                                            //                     .normal)),
                                            Text(
                                                provider['regularization']
                                                    [index]['checkout'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: const Color
                                                            .fromARGB(255, 248,
                                                            112, 78))),

                                            // Column(
                                            //   children: [
                                            //     Text(
                                            //       'Day(s)',
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodyText2!
                                            //           .copyWith(
                                            //               fontSize: 12),
                                            //     ),
                                            //   ],
                                            // )
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
                                      child: provider['regularization'][index]
                                                  ['status'] ==
                                              1
                                          ? const Icon(Icons.check,
                                              color: Colors.green)
                                          : provider['regularization'][index]
                                                      ['status'] ==
                                                  2
                                              ? const Icon(Icons.close,
                                                  color: Colors.red)
                                              : const Icon(Icons.timer,
                                                  color: Colors.amber)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02)
                  ],
                ),
                itemCount: provider['regularization'].length,
              ));
  }
}
