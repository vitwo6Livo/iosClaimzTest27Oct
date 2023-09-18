import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/views/screens/leaveScreenShimmer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../data/response/status.dart';
import '../../res/components/containerStyle.dart';
import '../../viewModel/leaveListViewModel.dart';
import '../config/mediaQuery.dart';
import '../widgets/leavesWidget/horizontalPayslip.dart';
import '../widgets/leavesWidget/leaveHeader.dart';
import 'requestLeaveScreen.dart';

class LeaveScreen extends StatefulWidget {
  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  LeaveListViewModel leaveListViewModel = LeaveListViewModel();
  String? text;

  @override
  void initState() {
    // TODO: implement initState
    leaveListViewModel.getLeaveList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: Column(
          children: [
            LeaveHeader(),
            HorizontalPayslip(),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.02,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: (themeProvider.darkTheme)
                        ? const Color.fromARGB(238, 34, 33, 33)
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: SizeVariables.getHeight(context) * 0.709,
                    // color: Colors.amber,
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.005,
                        top: SizeVariables.getHeight(context) * 0.005,
                        right: SizeVariables.getWidth(context) * 0.005),
                    child: ChangeNotifierProvider<LeaveListViewModel>(
                      create: (context) => leaveListViewModel,
                      child: Consumer<LeaveListViewModel>(
                          builder: (context, value, child) {
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
                              itemBuilder: (context, index) {
                                if (value.leaveList.data!.data![index].dates!
                                    .isEmpty) {
                                  print('');
                                } else if (value.leaveList.data!.data![index]
                                        .dates!.length ==
                                    1) {
                                  text = method(
                                      value.leaveList.data!.data![index].dates!
                                          .last,
                                      value.leaveList.data!.data![index].dates!
                                          .last);
                                } else {
                                  text = method(
                                      value.leaveList.data!.data![index]
                                          .dates![0],
                                      value.leaveList.data!.data![index].dates!
                                          .last);
                                }
                                return value.leaveList.data!.data!.isEmpty
                                    ? Center(
                                        child: Lottie.asset(
                                            'assets/json/ToDo.json'),
                                      )
                                    : Column(
                                        children: [
                                          value.leaveList.data!.data![index]
                                                  .dates!.isEmpty
                                              ? Container()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: (themeProvider
                                                            .darkTheme)
                                                        ? []
                                                        : [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 0,
                                                              blurRadius: 7,
                                                              //offset: Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],
                                                  ),
                                                  child: ContainerStyle(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.12,
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
                                                              height: double
                                                                  .infinity,
                                                              // color: Colors.red,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.05,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                // crossAxisAlignment:
                                                                //     CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    width: width >
                                                                            400
                                                                        ? 7.w
                                                                        : width <
                                                                                300
                                                                            ? 8.w
                                                                            : 8.w,
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      10,
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            2,
                                                                        color: const Color
                                                                            .fromARGB(
                                                                          255,
                                                                          165,
                                                                          157,
                                                                          157,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child: value
                                                                              .leaveList
                                                                              .data!
                                                                              .data![index]
                                                                              .dates!
                                                                              .isEmpty
                                                                          ? Text(
                                                                              '0',
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                                    fontSize: 18.sp,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            )
                                                                          : Text(
                                                                              // value.leaveList.data!.data![index].dateCount.toString(),
                                                                              value.leaveList.data!.data![index].dates!.length.toString(),
                                                                              // value.leaveList.data!.data![index].dates!.length ==
                                                                              //         1
                                                                              //     ? '1'
                                                                              //     : (DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(value.leaveList.data!.data![index].dates!.last))).difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(value.leaveList.data!.data![index].dates![0])))).inDays + 1)
                                                                              //         .toString(),
                                                                              // text!,
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                                    fontSize: 18.sp,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.02,
                                                          ),
                                                          Container(
                                                            // color: Colors.red,
                                                            child: Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.loose,
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width: 80,
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .leaveList
                                                                              .data!
                                                                              .data![index]
                                                                              .leaveType
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(
                                                                                color: Colors.white,
                                                                                fontSize: 18,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.006,
                                                                    ),
                                                                    Text(
                                                                      'Day(s)',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2!
                                                                          .copyWith(
                                                                              fontSize: 12,
                                                                              color: Colors.grey),
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
                                                          ),
                                                          SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.036,
                                                          ),
                                                          Container(
                                                            // color: Colors.amber,
                                                            width: 184,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .loose,
                                                                  child:
                                                                      Container(
                                                                    height: double
                                                                        .infinity,
                                                                    // color: Colors.green,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Text(
                                                                              // value.leaveList.data!
                                                                              //     .data![index].dates![0],
                                                                              value.leaveList.data!.data![index].dates![0].toString(),
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                    color: const Color.fromARGB(
                                                                                      255,
                                                                                      127,
                                                                                      182,
                                                                                      129,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: SizeVariables.getHeight(context) * 0.01,
                                                                            ),
                                                                            Text(
                                                                              value.leaveList.data!.data![index].dates!.length == 1 ? value.leaveList.data!.data![index].dates![0].toString() : value.leaveList.data!.data![index].dates!.last,
                                                                              // value.leaveList.data!
                                                                              //     .data![index].dates!.last,
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                    color: const Color.fromARGB(255, 248, 112, 78),
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 22,
                                                                  // height: double.infinity,
                                                                  // color: Colors.blue,
                                                                  child: Center(
                                                                    child: value.leaveList.data!.data![index].status ==
                                                                            1
                                                                        ? Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5.0),
                                                                              color: Color.fromARGB(255, 103, 122, 114),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                              child: Center(
                                                                                child: FittedBox(
                                                                                  fit: BoxFit.contain,
                                                                                  child: Text(
                                                                                    'Approved',
                                                                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                          color: const Color.fromARGB(255, 109, 247, 143),
                                                                                          fontSize: 18.sp,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : value.leaveList.data!.data![index].status ==
                                                                                2
                                                                            ? Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  color: const Color(0xffffeded),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                  child: Center(
                                                                                    child: FittedBox(
                                                                                      fit: BoxFit.contain,
                                                                                      child: Text(
                                                                                        'Rejected',
                                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                              color: const Color(0xffff1414),
                                                                                              fontSize: 18.sp,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            // const Icon(
                                                                            //     Icons.close,
                                                                            //     color:
                                                                            //         Colors.red)
                                                                            : InkWell(
                                                                                onTap: () => Navigator.of(context).push(
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => RequestLeave(
                                                                                      1,
                                                                                      value.leaveList.data!.data![index].dates,
                                                                                      value.leaveList.data!.data![index].subject!,
                                                                                      value.leaveList.data!.data![index].description!,
                                                                                      value.leaveList.data!.data![index].leaveId!,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                                    color: const Color.fromARGB(112, 241, 210, 100),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                    child: Center(
                                                                                      child: FittedBox(
                                                                                        fit: BoxFit.contain,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "Pending",
                                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                                    color: Colors.amber,
                                                                                                    fontSize: 18.sp,
                                                                                                  ),
                                                                                            ),
                                                                                            const Icon(Icons.edit, color: Colors.white)
                                                                                          ],
                                                                                        ),
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
                                                          // SizedBox(
                                                          //   width: SizeVariables
                                                          //           .getWidth(
                                                          //               context) *
                                                          //       0.06,
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02)
                                        ],
                                      );
                              },
                              itemCount: value.leaveList.data!.data!.length,
                            );
                          default:
                        }
                        return Container();
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String method(String start, String end) {
  int a = 1;
  int total = 0;
  DateTime startDate = DateTime.parse(start);
  DateTime endDate = DateTime.parse(end);

  while (startDate.isBefore(endDate)) {
    startDate = startDate.add(const Duration(days: 1));
    if (startDate.weekday != DateTime.saturday &&
        startDate.weekday != DateTime.sunday) {
      a++;
    }
  }
  print('COUNT: $start :: $end $a');

  return a.toString();
}
