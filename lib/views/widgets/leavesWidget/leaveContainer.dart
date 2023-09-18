import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../viewModel/leaveListViewModel.dart';
import '../../../data/response/status.dart';
import 'package:lottie/lottie.dart';
import '../../screens/leaveScreenShimmer.dart';

class LeaveContainer extends StatefulWidget {
  // const LeaveContainer({Key? key}) : super(key: key);

  @override
  State<LeaveContainer> createState() => _LeaveContainerState();
}

class _LeaveContainerState extends State<LeaveContainer> {
  LeaveListViewModel leaveListViewModel = LeaveListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    leaveListViewModel.getLeaveList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 0.709,
      // color: Colors.amber,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.005,
          top: SizeVariables.getHeight(context) * 0.005,
          right: SizeVariables.getWidth(context) * 0.005),
      child: ChangeNotifierProvider<LeaveListViewModel>(
        create: (context) => leaveListViewModel,
        child: Consumer<LeaveListViewModel>(builder: (context, value, child) {
          switch (value.leaveList.status) {
            case Status.LOADING:
              return LeaveScreenShimmer();
            case Status.ERROR:
              return Center(
                child: Lottie.asset('assets/json/ToDo.json',
                    height: 250, width: 250),
              );
            case Status.COMPLETED:
              return ListView.builder(
                itemBuilder: (context, index) => value
                        .leaveList.data!.data!.isEmpty
                    ? Center(
                        child: Lottie.asset('assets/json/ToDo.json'),
                      )
                    : Column(
                        children: [
                          value.leaveList.data!.data![index].dates!.isEmpty
                              ? Container()
                              : ContainerStyle(
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
                                          fit: FlexFit.loose,
                                          child: Container(
                                            // width: 1,
                                            height: double.infinity,
                                            // color: Colors.red,
                                            padding: EdgeInsets.only(
                                                left: SizeVariables.getWidth(
                                                        context) *
                                                    0.05),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          64, 255, 254, 254),
                                                  radius: 25,
                                                  child: Text(
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
                                                      value
                                                                  .leaveList
                                                                  .data!
                                                                  .data![index]
                                                                  .dates!
                                                                  .length ==
                                                              1
                                                          ? '1'
                                                          : (DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(value.leaveList.data!.data![index].dates!.last)))
                                                                      .difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                                                          value.leaveList.data!.data![index].dates![
                                                                              0]))))
                                                                      .inDays +
                                                                  1)
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 26.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: Container(
                                            height: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.leaveList.data!
                                                      .data![index].leaveType
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.004,
                                                ),
                                                Text(
                                                  'Day(s)',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 12),
                                                ),

                                                // Text(
                                                //   value
                                                //               .leaveList
                                                //               .data!
                                                //               .data![index]
                                                //               .dates!
                                                //               .length ==
                                                //           1
                                                //       ? value
                                                //           .leaveList
                                                //           .data!
                                                //           .data![index]
                                                //           .dates![0]
                                                //           .toString()
                                                //       : value
                                                //           .leaveList
                                                //           .data!
                                                //           .data![index]
                                                //           .dates!
                                                //           .last,
                                                //   // value.leaveList.data!
                                                //   //     .data![index].dates!.last,
                                                //   style: Theme.of(context)
                                                //       .textTheme
                                                //       .bodyText1!
                                                //       .copyWith(
                                                //           color: const Color
                                                //                   .fromARGB(
                                                //               255,
                                                //               248,
                                                //               112,
                                                //               78)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.033,
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
                                                Column(
                                                  children: [
                                                    Text(
                                                      // value.leaveList.data!
                                                      //     .data![index].dates![0],
                                                      value
                                                          .leaveList
                                                          .data!
                                                          .data![index]
                                                          .dates![0]
                                                          .toString(),
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
                                                    Text(
                                                      value
                                                                  .leaveList
                                                                  .data!
                                                                  .data![index]
                                                                  .dates!
                                                                  .length ==
                                                              1
                                                          ? value
                                                              .leaveList
                                                              .data!
                                                              .data![index]
                                                              .dates![0]
                                                              .toString()
                                                          : value
                                                              .leaveList
                                                              .data!
                                                              .data![index]
                                                              .dates!
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
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.05,
                                        ),
                                        Container(
                                          height: 22,
                                          // height: double.infinity,
                                          // color: Colors.blue,
                                          child: Center(
                                            child: value.leaveList.data!
                                                        .data![index].status ==
                                                    1
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Color.fromARGB(
                                                          255, 103, 122, 114),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5.0,
                                                              top: 2.5,
                                                              bottom: 2.5),
                                                      child: Center(
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(
                                                            'Approved',
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
                                                                            143),
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : value
                                                            .leaveList
                                                            .data!
                                                            .data![index]
                                                            .status ==
                                                        2
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color:
                                                              Color(0xffffeded),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5.0,
                                                                  right: 5.0,
                                                                  top: 2.5,
                                                                  bottom: 2.5),
                                                          child: Center(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                'Rejected',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        color: Color(
                                                                            0xffff1414),
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    // const Icon(
                                                    //     Icons.close,
                                                    //     color:
                                                    //         Colors.red)
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color: Colors
                                                              .amberAccent,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5.0,
                                                                  right: 5.0,
                                                                  top: 2.5,
                                                                  bottom: 2.5),
                                                          child: Center(
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: Text(
                                                                "Pending",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .amber,
                                                                        fontSize:
                                                                            12),
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
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.02)
                        ],
                      ),
                itemCount: value.leaveList.data!.data!.length,
              );
            default:
          }
          return Container();
        }),
      ),
    );
  }
}
