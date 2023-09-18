import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/main.dart';
import 'package:claimz/models/claimz_HistoryModel.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/viewModel/logsViewModel.dart';
import 'package:claimz/views/widgets/clamizHistroyWidget/clamizStyle.dart';
import 'package:claimz/views/widgets/managerScreenWidgets/claimManager/claimManagerContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../../res/appUrl.dart';
import '../../../config/mediaQuery.dart';

class ConveyanceLogListScreen extends StatefulWidget {
  @override
  State<ConveyanceLogListScreen> createState() =>
      _ConveyanceLogListScreenState();
}

class _ConveyanceLogListScreenState extends State<ConveyanceLogListScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );
  var myYears = "2022";
  List<String> year = ["2022", "2021", "2020", "2019", "2018"];
  var current_mon = "";
  DateFormat dateFormat = DateFormat('yyyy');
  LogsViewModel conveyance_list = LogsViewModel();

  var _status = "Pending for Submission";

  List<String> _status_list = [
    "Pending for Submission",
    "Pending for Approval",
    "Pending for Payment",
    "Paid",
    "Rejected",
  ];

  var _userid = "";

  @override
  void initState() {
    // TODO: implement initState
    var now = new DateTime.now();
    // current_mon = now.month.toString();
    final start = dateRange.start;
    final end = dateRange.end;
    _callListApi(context, start, end);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            Container(
                              width: SizeVariables.getWidth(context) * 0.4,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Conveynance list Log',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.amber,
                        width: SizeVariables.getWidth(context) * 0.3,
                        height: SizeVariables.getHeight(context) * 0.05,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: DateRangePicker(
                            onPressed: pickDateRange,
                            end: end,
                            start: start,
                            // width: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // child: Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: SvgPicture.asset(
                  //         "assets/icons/back button.svg",
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8),
                  //       child: FittedBox(
                  //         fit: BoxFit.contain,
                  //         child: Text(
                  //           'Conveynance list Log',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .caption!
                  //               .copyWith(fontSize: 20),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                // HorizontalHisWidget(),

                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.03,
                ),
                ChangeNotifierProvider<LogsViewModel>(
                  lazy: true,
                  create: (context) => conveyance_list,
                  child: Consumer<LogsViewModel>(
                    builder: (context, value, child) {
                      switch (value.conyenanceList.status) {
                        case Status.ERROR:
                          return Center(
                            child:
                                Text(value.conyenanceList.message.toString()),
                          );
                        case Status.LOADING:
                          return Center(child: CircularProgressIndicator());
                        case Status.COMPLETED:
                          if (value.conyenanceList.data!.data!.isEmpty) {
                            return Center(
                              child: Lottie.asset('assets/json/ToDo.json',
                                  width: 300),
                            );
                          } else {
                            return Container(
                              padding: const EdgeInsets.all(5),
                              child: ExpandedTileList.builder(
                                itemCount:
                                    value.conyenanceList.data!.data!.length,
                                maxOpened: 1,
                                reverse: true,
                                itemBuilder: (context, index, controller) {
                                  return ExpandedTile(
                                    contentseparator: 0,
                                    trailing: null,
                                    theme: const ExpandedTileThemeData(
                                      // headerColor: Colors.green,
                                      headerRadius: 0,
                                      // headerPadding: EdgeInsets.all(24.0),
                                      headerColor: Colors.transparent,
                                      headerPadding: EdgeInsets.all(0.0),
                                      titlePadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      // leadingPadding: EdgeInsets.symmetric(horizontal: 0),
                                      trailingPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      headerSplashColor: Colors.grey,
                                      //

                                      contentBackgroundColor:
                                          Colors.transparent,
                                      contentPadding: EdgeInsets.all(0.0),

                                      contentRadius: 0,
                                    ),
                                    controller: index == 2
                                        ? controller.copyWith(isExpanded: true)
                                        : controller,
                                    title: Column(
                                      children: [
                                        Container(
                                          // color: Colors.blue,
                                          margin: EdgeInsets.only(
                                              top: SizeVariables.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Row(
                                            children: [
                                              value
                                                              .conyenanceList
                                                              .data!
                                                              .data![index]
                                                              .profilePhoto ==
                                                          null ||
                                                      value
                                                              .conyenanceList
                                                              .data!
                                                              .data![index]
                                                              .profilePhoto ==
                                                          '${AppUrl.baseUrl}/profile_photo/'
                                                  // provider['data'][index]
                                                  //                 ['profile_photo'] ==
                                                  //             null ||
                                                  //         provider['data'][index]
                                                  //                 ['profile_photo'] ==
                                                  //             'https://claimz.vitwo.in/profile_photo/'
                                                  ? CircleAvatar(
                                                      radius: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.04,
                                                      backgroundColor:
                                                          Colors.green,
                                                      backgroundImage:
                                                          const AssetImage(
                                                              'assets/img/profilePic.jpg'),
                                                      // child: const Icon(Icons.account_box, color: Colors.white),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl:
                                                          '${value.conyenanceList.data!.data![index].profilePhoto}',
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          CircleAvatar(
                                                        radius: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.04,
                                                        backgroundColor:
                                                            Colors.green,
                                                        backgroundImage:
                                                            imageProvider,
                                                        // child: const Icon(Icons.account_box, color: Colors.white),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[400]!,
                                                        highlightColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                120, 120, 120),
                                                        child: CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.08),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          CircleAvatar(
                                                        radius: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.08,
                                                        backgroundColor:
                                                            Colors.green,
                                                        backgroundImage:
                                                            const AssetImage(
                                                                'assets/img/profilePic.jpg'),
                                                        // child: const Icon(Icons.account_box, color: Colors.white),
                                                      ),
                                                    ),
                                              SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.02),
                                              Text(value.conyenanceList.data!
                                                  .data![index].empName)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          // height: 25,
                                          // color: const Color.fromARGB(255, 107, 106, 106),
                                          child: Row(
                                            children: [
                                              Text(
                                                  '${value.conyenanceList!.data!.data![index].approvedAt} |'),
                                              Text(value.conyenanceList!.data!
                                                  .data![index].docNo
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                        Card(
                                          elevation: 20,
                                          child: Container(
                                            // width: double.infinity,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: (themeProvider.darkTheme)
                                                    ? const Color.fromARGB(
                                                        255, 72, 70, 70)
                                                    : Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            // child: Row(
                                            //   children: [
                                            //     Text('${_items[index]['date']} |'),
                                            //     Text(_items[index]['docId']),
                                            //   ],
                                            // ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.pink,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            value
                                                                .conyenanceList
                                                                .data!
                                                                .data![index]
                                                                .tStartOriginAddress
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        232,
                                                                        175,
                                                                        175),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                        Text(
                                                            value
                                                                .conyenanceList
                                                                .data!
                                                                .data![index]
                                                                .travelStartTime
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    //                 color: const Color.fromARGB(
                                                                    // 255, 232, 175, 175),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.bike_scooter,
                                                            color: Colors.amber,
                                                            size: 20),
                                                        Container(
                                                          height: 20,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white)),
                                                          child: Center(
                                                              child: Text(
                                                                  value
                                                                      .conyenanceList
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .actualDuration
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                          //                 color: const Color.fromARGB(
                                                                          // 255, 232, 175, 175),
                                                                          fontWeight:
                                                                              FontWeight.normal))),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('₹',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        //                 color: const Color.fromARGB(
                                                                        // 255, 232, 175, 175),
                                                                        color: Colors
                                                                            .amber,
                                                                        fontWeight:
                                                                            FontWeight.normal)),
                                                            Text(
                                                                value
                                                                    .conyenanceList
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .amount
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        //                 color: const Color.fromARGB(
                                                                        // 255, 232, 175, 175),
                                                                        fontWeight:
                                                                            FontWeight.normal)),
                                                          ],
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
                                                    // color: Colors.orange,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            value
                                                                .conyenanceList
                                                                .data!
                                                                .data![index]
                                                                .tEndOriginAddress
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        164,
                                                                        236,
                                                                        166),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                        Text(
                                                            value
                                                                .conyenanceList
                                                                .data!
                                                                .data![index]
                                                                .travelEndTime
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    //                 color: const Color.fromARGB(
                                                                    // 255, 232, 175, 175),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    content: InkWell(
                                        onTap: () {
                                          Map<String, dynamic> data = {
                                            "doc_no": value.conyenanceList.data!
                                                .data![index].docNo
                                                .toString(),
                                            "from": value
                                                .conyenanceList
                                                .data!
                                                .data![index]
                                                .tStartOriginAddress
                                                .toString(),
                                            "date": value.conyenanceList.data!
                                                .data![index].travelStartDate
                                                .toString(),
                                            "to": value.conyenanceList.data!
                                                .data![index].tEndOriginAddress
                                                .toString(),
                                            'flag': 0
                                          };

                                          print('DATAAAAA: $data');

                                          // Navigator.pop(context);
                                          Navigator.pushNamed(context,
                                              RouteNames.conveyanceviewlog,
                                              arguments: data);

                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             TravelHistoryForm(data)));
                                        },
                                        child: Card(
                                          elevation: 20,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: Stack(
                                            children: [
                                              Container(
                                                  // height: 150,
                                                  padding: const EdgeInsets.all(
                                                      10),
                                                  // color: const Color.fromARGB(
                                                  //           255, 72, 70, 70),
                                                  decoration: BoxDecoration(
                                                      color: (themeProvider
                                                              .darkTheme)
                                                          ? Color.fromARGB(
                                                              255, 72, 70, 70)
                                                          : Theme.of(context)
                                                              .scaffoldBackgroundColor,
                                                      // color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  // decoration: BoxDecoration(
                                                  //     // borderRadius: BorderRadius.only(
                                                  //     //   bottomLeft: Radius.circular(20),
                                                  //     //   bottomRight: Radius.circular(20),
                                                  //     // )
                                                  //     ),
                                                  child: Container(
                                                    // color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          flex: 1,
                                                          fit: FlexFit.tight,
                                                          child: Container(
                                                            // color: Colors.green,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .timer_outlined,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          167,
                                                                          146,
                                                                          81),
                                                                    ),
                                                                    Text(
                                                                        'Wait Time:',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // Text('Wait Time: ${_items[index]['waitTime']}'),
                                                                    Icon(
                                                                      Icons
                                                                          .handshake_outlined,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          167,
                                                                          146,
                                                                          81),
                                                                    ),
                                                                    Text(
                                                                        'Meeting Time:',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            167,
                                                                            146,
                                                                            81)),
                                                                    Text(
                                                                        'Suggested:',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            167,
                                                                            146,
                                                                            81)),
                                                                    Text(
                                                                        'Actual:',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .computer,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            167,
                                                                            146,
                                                                            81)),
                                                                    Text(
                                                                        'Intelligence:',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
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
                                                            // color: Colors.red,
                                                            height: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.15,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        value
                                                                            .conyenanceList
                                                                            .data!
                                                                            .data![index]
                                                                            .waitingTime,
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        value
                                                                            .conyenanceList
                                                                            .data!
                                                                            .data![index]
                                                                            .meetingTime,
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        '${value.conyenanceList.data!.data![index].suggestedDistance} || ${value.conyenanceList.data!.data![index].suggestedDuration}',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        '${value.conyenanceList.data!.data![index].actualDistance} || ${value.conyenanceList.data!.data![index].actualDuration}',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        '${value.conyenanceList.data!.data![index].intelligenceDistance} || ${value.conyenanceList.data!.data![index].intelligenceDuration}',
                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight: FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                    // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: value
                                                                        .conyenanceList
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .status ==
                                                                    'Pending for Submission'
                                                                ? Container(
                                                                    child: Center(
                                                                        child:
                                                                            // provider['data']
                                                                            //                 [
                                                                            //                 index]
                                                                            //             [
                                                                            //             'approval_status'] ==
                                                                            //         1
                                                                            //     ?
                                                                            InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        SharedPreferences
                                                                            localStorage =
                                                                            await SharedPreferences.getInstance();

                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            {
                                                                          "doc_no": value
                                                                              .conyenanceList
                                                                              .data!
                                                                              .data![index]
                                                                              .docNo
                                                                              .toString(),
                                                                          "from": value
                                                                              .conyenanceList
                                                                              .data!
                                                                              .data![index]
                                                                              .tStartOriginAddress
                                                                              .toString(),
                                                                          "date": value
                                                                              .conyenanceList
                                                                              .data!
                                                                              .data![index]
                                                                              .travelStartDate
                                                                              .toString(),
                                                                          "to": value
                                                                              .conyenanceList
                                                                              .data!
                                                                              .data![index]
                                                                              .tEndOriginAddress
                                                                              .toString(),
                                                                          'flag':
                                                                              0
                                                                        };

                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            RouteNames
                                                                                .conveyanceviewlog,
                                                                            arguments:
                                                                                data);
                                                                      },
                                                                      child: RippleAnimation(
                                                                          repeat: true,
                                                                          color: Colors.grey,
                                                                          minRadius: 30,
                                                                          ripplesCount: 2,
                                                                          child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              bottom: 10,
                                                                              left: 5,
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              height: SizeVariables.getHeight(context) * 0.05,
                                                                              width: SizeVariables.getWidth(context) * 0.1,
                                                                              child: Image.asset('assets/icons/claim_logo.png'),
                                                                            ),
                                                                          )),
                                                                    )),
                                                                  )
                                                                : value
                                                                            .conyenanceList
                                                                            .data!
                                                                            .data![index]
                                                                            .status ==
                                                                        'Pending for Approval'
                                                                    ? Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              SharedPreferences localStorage = await SharedPreferences.getInstance();

                                                                              Map<String, dynamic> data = {
                                                                                "doc_no": value.conyenanceList.data!.data![index].docNo.toString(),
                                                                                "from": value.conyenanceList.data!.data![index].tStartOriginAddress.toString(),
                                                                                "date": value.conyenanceList.data!.data![index].travelStartDate.toString(),
                                                                                "to": value.conyenanceList.data!.data![index].tEndOriginAddress.toString(),
                                                                                'flag': 0
                                                                              };

                                                                              Navigator.pushNamed(context, RouteNames.conveyanceviewlog, arguments: data);
                                                                            },
                                                                            child: RippleAnimation(
                                                                                repeat: true,
                                                                                color: Colors.grey,
                                                                                minRadius: 30,
                                                                                ripplesCount: 2,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                    bottom: 10,
                                                                                    left: 5,
                                                                                  ),
                                                                                  child: Container(
                                                                                    height: SizeVariables.getHeight(context) * 0.05,
                                                                                    width: SizeVariables.getWidth(context) * 0.1,
                                                                                    child: Image.asset('assets/icons/claim_logo.png'),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : FittedBox(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              SizeVariables.getHeight(context) * 0.07,
                                                                          width:
                                                                              SizeVariables.getWidth(context) * 0.15,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(value.conyenanceList.data!.data![index].status.toString(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 8))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ))
                                                      ],
                                                    ),
                                                  )),

                                              // Positioned(
                                              //     top: 0,
                                              //     right: 10,
                                              //     bottom: 0,
                                              //     child: value
                                              //                 .claimzhistory
                                              //                 .data!
                                              //                 .data![index]
                                              //                 .status ==
                                              //             'Pending for Submission'
                                              //         ? InkWell(
                                              //             onTap: () async {
                                              //               SharedPreferences
                                              //                   localStorage =
                                              //                   await SharedPreferences
                                              //                       .getInstance();

                                              //               Map<String, dynamic>
                                              //                   data = {
                                              //                 "doc_no": value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .docNo
                                              //                     .toString(),
                                              //                 "from": value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .tStartOriginAddress
                                              //                     .toString(),
                                              //                 "date": value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .travelStartDate
                                              //                     .toString(),
                                              //                 "to": value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .tEndOriginAddress
                                              //                     .toString(),
                                              //                 'flag': 0,
                                              //                 'remarks': value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .remarks
                                              //                     .toString(),
                                              //                 'status': value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .approvalStatus
                                              //               };

                                              //               Map<String, dynamic>
                                              //                   refreshData = {
                                              //                 "month": current_mon
                                              //                     .toString(),
                                              //                 "all": 0,
                                              //                 "year": myYears
                                              //                     .toString(),
                                              //                 "status": localStorage
                                              //                     .getString(
                                              //                         'approval'),
                                              //                 "user_id": _userid
                                              //                     .toString(),
                                              //               };
                                              //               // Navigator.of(context).push(
                                              //               //     MaterialPageRoute(
                                              //               //         builder: (context) =>
                                              //               //             TravelHistoryForm(
                                              //               //                 data)));

                                              //               Navigator.of(context).push(
                                              //                   MaterialPageRoute(
                                              //                       builder: (context) =>
                                              //                           ConvenyanceClaimFrom(
                                              //                               data,
                                              //                               refreshData,
                                              //                               false)));
                                              //             },
                                              //             child: RippleAnimation(
                                              //                 repeat: true,
                                              //                 color: Colors.grey,
                                              //                 minRadius: 30,
                                              //                 ripplesCount: 2,
                                              //                 child: Padding(
                                              //                   padding:
                                              //                       const EdgeInsets
                                              //                           .only(
                                              //                     bottom: 10,
                                              //                     left: 5,
                                              //                   ),
                                              //                   child: Container(
                                              //                     height: SizeVariables
                                              //                             .getHeight(
                                              //                                 context) *
                                              //                         0.05,
                                              //                     width: SizeVariables
                                              //                             .getWidth(
                                              //                                 context) *
                                              //                         0.1,
                                              //                     child: Image.asset(
                                              //                         'assets/icons/claim_logo.png'),
                                              //                   ),
                                              //                 )),
                                              //           )
                                              //         : value
                                              //                     .claimzhistory
                                              //                     .data!
                                              //                     .data![index]
                                              //                     .status ==
                                              //                 'Pending for Approval'
                                              //             ? InkWell(
                                              //                 onTap: () async {
                                              //                   SharedPreferences
                                              //                       localStorage =
                                              //                       await SharedPreferences
                                              //                           .getInstance();

                                              //                   Map<String,
                                              //                           dynamic>
                                              //                       data = {
                                              //                     "doc_no": value
                                              //                         .claimzhistory
                                              //                         .data!
                                              //                         .data![
                                              //                             index]
                                              //                         .docNo
                                              //                         .toString(),
                                              //                     "from": value
                                              //                         .claimzhistory
                                              //                         .data!
                                              //                         .data![
                                              //                             index]
                                              //                         .tStartOriginAddress
                                              //                         .toString(),
                                              //                     "date": value
                                              //                         .claimzhistory
                                              //                         .data!
                                              //                         .data![
                                              //                             index]
                                              //                         .travelStartDate
                                              //                         .toString(),
                                              //                     "to": value
                                              //                         .claimzhistory
                                              //                         .data!
                                              //                         .data![
                                              //                             index]
                                              //                         .tEndOriginAddress
                                              //                         .toString(),
                                              //                     'flag': 0,
                                              //                     'remarks': value
                                              //                         .claimzhistory
                                              //                         .data!
                                              //                         .data![
                                              //                             index]
                                              //                         .remarks
                                              //                         .toString(),
                                              //                     'status': value
                                              //                         .claimzhistory
                                              //                         .data!
                                              //                         .data![
                                              //                             index]
                                              //                         .approvalStatus
                                              //                   };

                                              //                   print(
                                              //                       'DATAAAAA: $data');

                                              //                   Map<String,
                                              //                           dynamic>
                                              //                       refreshData =
                                              //                       {
                                              //                     "month": current_mon
                                              //                         .toString(),
                                              //                     "all": 0,
                                              //                     "year": myYears
                                              //                         .toString(),
                                              //                     "status": localStorage
                                              //                         .getString(
                                              //                             'approval'),
                                              //                     "user_id": _userid
                                              //                         .toString(),
                                              //                   };

                                              //                   // Navigator.of(
                                              //                   //         context)
                                              //                   //     .push(MaterialPageRoute(
                                              //                   //         builder: (context) =>
                                              //                   //             TravelHistoryForm(
                                              //                   //                 data)));

                                              //                   // Navigator.pushNamed(
                                              //                   //     context,
                                              //                   //     RouteNames
                                              //                   //         .historyclaim,
                                              //                   //     arguments:
                                              //                   //         data);
                                              //                   Navigator.of(
                                              //                           context)
                                              //                       .push(MaterialPageRoute(
                                              //                           builder: (context) => ConvenyanceClaimFrom(
                                              //                               data,
                                              //                               refreshData,
                                              //                               false)));
                                              //                 },
                                              //                 child:
                                              //                     RippleAnimation(
                                              //                         repeat:
                                              //                             true,
                                              //                         color: Colors
                                              //                             .grey,
                                              //                         minRadius:
                                              //                             20,
                                              //                         ripplesCount:
                                              //                             2,
                                              //                         child:
                                              //                             Padding(
                                              //                           padding:
                                              //                               const EdgeInsets
                                              //                                   .only(
                                              //                             bottom:
                                              //                                 10,
                                              //                             left: 5,
                                              //                           ),
                                              //                           child:
                                              //                               Container(
                                              //                             height: SizeVariables.getHeight(context) *
                                              //                                 0.05,
                                              //                             width: SizeVariables.getWidth(context) *
                                              //                                 0.1,
                                              //                             child: Image.asset(
                                              //                                 'assets/icons/claim_logo.png'),
                                              //                           ),
                                              //                         )),
                                              //               )
                                              //             : FittedBox(
                                              //                 child: Container(
                                              //                   // color: Colors.red,
                                              //                   height: SizeVariables
                                              //                           .getHeight(
                                              //                               context) *
                                              //                       0.07,
                                              //                   width: SizeVariables
                                              //                           .getWidth(
                                              //                               context) *
                                              //                       0.15,
                                              //                   child: Column(
                                              //                     crossAxisAlignment:
                                              //                         CrossAxisAlignment
                                              //                             .end,
                                              //                     mainAxisAlignment:
                                              //                         MainAxisAlignment
                                              //                             .center,
                                              //                     children: [
                                              //                       Text(
                                              //                           value
                                              //                               .claimzhistory
                                              //                               .data!
                                              //                               .data![
                                              //                                   index]
                                              //                               .status
                                              //                               .toString(),
                                              //                           style: Theme.of(
                                              //                                   context)
                                              //                               .textTheme
                                              //                               .bodyText1!
                                              //                               .copyWith(
                                              //                                   fontSize: 8)),
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //               ))
                                            ],
                                          ),
                                        )
                                        // Card(
                                        //   elevation: 20,
                                        //   shape: const RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.only(
                                        //           bottomLeft: Radius.circular(10),
                                        //           bottomRight:
                                        //               Radius.circular(10))),
                                        //   child: Stack(
                                        //     children: [
                                        //       Container(
                                        //         // height: 150,
                                        //         padding: const EdgeInsets.all(10),
                                        //         // color: const Color.fromARGB(
                                        //         //           255, 72, 70, 70),
                                        //         decoration: BoxDecoration(
                                        //             color: (themeProvider
                                        //                     .darkTheme)
                                        //                 ? Color.fromARGB(
                                        //                     255, 72, 70, 70)
                                        //                 : Theme.of(context)
                                        //                     .scaffoldBackgroundColor,
                                        //             // color: Colors.red,
                                        //             borderRadius:
                                        //                 BorderRadius.only(
                                        //                     bottomLeft:
                                        //                         Radius.circular(
                                        //                             10),
                                        //                     bottomRight: Radius
                                        //                         .circular(10))),
                                        //         // decoration: BoxDecoration(
                                        //         //     // borderRadius: BorderRadius.only(
                                        //         //     //   bottomLeft: Radius.circular(20),
                                        //         //     //   bottomRight: Radius.circular(20),
                                        //         //     // )
                                        //         //     ),
                                        //         child: Column(
                                        //           children: [
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               children: [
                                        //                 Icon(
                                        //                   Icons.timer_outlined,
                                        //                   color: Color.fromARGB(
                                        //                       255, 167, 146, 81),
                                        //                 ),
                                        //                 Text(
                                        //                     'Wait Time: ${value.conyenanceList.data!.data![index].waitingTime}',
                                        //                     style: Theme.of(
                                        //                             context)
                                        //                         .textTheme
                                        //                         .bodyText1!
                                        //                         .copyWith(
                                        //                             //                 color: const Color.fromARGB(
                                        //                             // 255, 232, 175, 175),

                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .normal)),
                                        //                 // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                        //               ],
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               children: [
                                        //                 // Text('Wait Time: ${_items[index]['waitTime']}'),
                                        //                 Icon(
                                        //                   Icons
                                        //                       .handshake_outlined,
                                        //                   color: Color.fromARGB(
                                        //                       255, 167, 146, 81),
                                        //                 ),
                                        //                 Text(
                                        //                     'Meeting Time: ${value.conyenanceList.data!.data![index].meetingTime}',
                                        //                     style: Theme.of(
                                        //                             context)
                                        //                         .textTheme
                                        //                         .bodyText1!
                                        //                         .copyWith(
                                        //                             //                 color: const Color.fromARGB(
                                        //                             // 255, 232, 175, 175),

                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .normal)),
                                        //               ],
                                        //             ),

                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               children: [
                                        //                 Icon(Icons.star,
                                        //                     color: Color.fromARGB(
                                        //                         255,
                                        //                         167,
                                        //                         146,
                                        //                         81)),
                                        //                 Text(
                                        //                     'Suggested: ${value.conyenanceList.data!.data![index].suggestedDistance} || ${value.conyenanceList.data!.data![index].suggestedDuration}',
                                        //                     style: Theme.of(
                                        //                             context)
                                        //                         .textTheme
                                        //                         .bodyText1!
                                        //                         .copyWith(
                                        //                             //                 color: const Color.fromARGB(
                                        //                             // 255, 232, 175, 175),

                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .normal)),
                                        //                 // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                        //               ],
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               children: [
                                        //                 Icon(Icons.check,
                                        //                     color: Color.fromARGB(
                                        //                         255,
                                        //                         167,
                                        //                         146,
                                        //                         81)),
                                        //                 Text(
                                        //                     'Actual: ${value.conyenanceList.data!.data![index].actualDistance} || ${value.conyenanceList.data!.data![index].actualDuration}',
                                        //                     style: Theme.of(
                                        //                             context)
                                        //                         .textTheme
                                        //                         .bodyText1!
                                        //                         .copyWith(
                                        //                             //                 color: const Color.fromARGB(
                                        //                             // 255, 232, 175, 175),

                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .normal)),
                                        //                 // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                        //               ],
                                        //             ),
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.start,
                                        //               children: [
                                        //                 Icon(Icons.computer,
                                        //                     color: Color.fromARGB(
                                        //                         255,
                                        //                         167,
                                        //                         146,
                                        //                         81)),
                                        //                 Text(
                                        //                     'Intelligence: ${value.conyenanceList.data!.data![index].intelligenceDistance} || ${value.conyenanceList.data!.data![index].intelligenceDuration}',
                                        //                     style: Theme.of(
                                        //                             context)
                                        //                         .textTheme
                                        //                         .bodyText1!
                                        //                         .copyWith(
                                        //                             //                 color: const Color.fromARGB(
                                        //                             // 255, 232, 175, 175),

                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .normal)),
                                        //                 // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                        //               ],
                                        //             ),

                                        //             //Section For Managers

                                        //             // Container(
                                        //             //   height: 20,
                                        //             //   color: Colors.green,
                                        //             //   padding: EdgeInsets.only(
                                        //             //       right:
                                        //             //           SizeVariables.getWidth(
                                        //             //                   context) *
                                        //             //               0.02),
                                        //             //   child: Row(
                                        //             //     mainAxisAlignment:
                                        //             //         MainAxisAlignment.end,
                                        //             //     children: [
                                        //             //       // Transform.scale(
                                        //             //       //   scale: 1,
                                        //             //       //   child: Switch.adaptive(
                                        //             //       //       thumbColor:
                                        //             //       //           MaterialStateProperty.all(
                                        //             //       //               Colors.red),
                                        //             //       //       trackColor:
                                        //             //       //           MaterialStateProperty.all(
                                        //             //       //               const Color.fromARGB(
                                        //             //       //                   255,
                                        //             //       //                   248,
                                        //             //       //                   109,
                                        //             //       //                   109)),
                                        //             //       //       value: rejected,
                                        //             //       //       onChanged: (value) {
                                        //             //       //         // setState(() {
                                        //             //       //         //   // rejected = value;
                                        //             //       //         // });
                                        //             //       //         rejectAlert(
                                        //             //       //             value,
                                        //             //       //             provider[index]
                                        //             //       //                 ['doc_no'],
                                        //             //       //             provider[index]);
                                        //             //       //       }),
                                        //             //       // ),
                                        //             //       // const Text('Reject')
                                        //             //       InkWell(
                                        //             //         onTap: () {},
                                        //             //         child: const Icon(
                                        //             //             Icons.check_box,
                                        //             //             color: Colors
                                        //             //                 .orangeAccent,
                                        //             //             size: 30),
                                        //             //       ),
                                        //             //       InkWell(
                                        //             //           onTap: () {},
                                        //             //           child: const Icon(
                                        //             //               Icons.cancel,
                                        //             //               color: Colors
                                        //             //                   .orangeAccent,
                                        //             //               size: 30)),
                                        //             //     ],
                                        //             //   ),
                                        //             // )
                                        //           ],
                                        //         ),
                                        //       ),

                                        ),
                                    onTap: () {
                                      debugPrint("tapped!!");
                                    },
                                    onLongTap: () {
                                      debugPrint("looooooooooong tapped!!");
                                    },
                                  );
                                },
                              ),
                            );
                          }
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _ListRecord(Data claimData) {
    return ListWidget(
      height: SizeVariables.getHeight(context) * 0.29,
      child: InkWell(
        onTap: () {
          Map<String, dynamic> data = {
            "doc_no": claimData!.docNo.toString(),
            "from": claimData.tStartOriginAddress.toString(),
            "date": claimData.travelStartDate.toString(),
            "to": claimData.tEndOriginAddress.toString(),
            'flag': 1
          };

          Navigator.pushNamed(context, RouteNames.conveyanceviewlog,
              arguments: data);
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: SizeVariables.getHeight(context) * 0.013,
                              left: SizeVariables.getWidth(context) * 0.037),
                          width: SizeVariables.getWidth(context) * 0.65,
                          // color: Colors.red,
                          child: Row(
                            // newtown to soltlake
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      claimData!.tStartOriginAddress.toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 164, 236, 166),
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      claimData.travelStartTime.toString(),
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 113, 112, 112),
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Icon(
                                      Icons.motorcycle_outlined,
                                      color: Color.fromARGB(255, 167, 146, 81),
                                      size: 25,
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      claimData.empName.toString(),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      claimData.tEndOriginAddress.toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 232, 175, 175),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      claimData.travelEndTime.toString(),
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              221, 118, 114, 114),
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly, // 2:50  or button
                          children: [
                            Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.025,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const FittedBox(
                                        fit: BoxFit.contain,
                                        child: Icon(
                                          Icons.timer_outlined,
                                          color:
                                              Color.fromARGB(255, 167, 146, 81),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.03,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                            claimData.waitingTime.toString()),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.008),
                                  Row(
                                    children: [
                                      const FittedBox(
                                        fit: BoxFit.contain,
                                        child: Icon(
                                          Icons.handshake_outlined,
                                          color:
                                              Color.fromARGB(255, 167, 146, 81),
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.03,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                            claimData.meetingTime.toString()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.17,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.015,
                        ),
                        Container(
                          // color: Colors.amber,
                          padding: EdgeInsets.only(
                              top: SizeVariables.getHeight(context) * 0.013),
                          width: SizeVariables.getWidth(context) * 0.75,
                          // color: Colors.red,
                          child: Row(
                            //sug act
                            // mainAxisAlignment:
                            // MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02,
                                ),
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: SizeVariables.getWidth(
                                                    context) *
                                                0.01,
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Suggested',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.015),
                                          // color: Colors.red,
                                          child: Row(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  claimData.suggestedDistance
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(fontSize: 16),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'km',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.015),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              '||',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.015),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(claimData
                                                .suggestedDuration
                                                .toString()),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.01,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.04),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Actual',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.05),
                                          child: Row(
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  claimData.actualDistance
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(fontSize: 16),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'km',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.02),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              '||',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.015),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(claimData.actualDuration
                                                .toString()),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.01,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: SizeVariables
                                        //           .getWidth(
                                        //           context) *
                                        //           0.04),
                                        //   child: FittedBox(
                                        //     fit: BoxFit.contain,
                                        //     child: Text(
                                        //       'Intelligence',
                                        //       style: Theme.of(context)
                                        //           .textTheme
                                        //           .bodyText1,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   padding: EdgeInsets.only(
                                        //       left: SizeVariables
                                        //           .getWidth(
                                        //           context) *
                                        //           0.05),
                                        //   child: Row(
                                        //     children: [
                                        //       FittedBox(
                                        //         fit: BoxFit.contain,
                                        //         child: Text(
                                        //           claimData
                                        //               .intelligence_distance
                                        //               .toString(),
                                        //           style: Theme.of(
                                        //               context)
                                        //               .textTheme
                                        //               .bodyText1!
                                        //               .copyWith(
                                        //               fontSize:
                                        //               16),
                                        //         ),
                                        //       ),
                                        //       FittedBox(
                                        //         fit: BoxFit.contain,
                                        //         child: Text(
                                        //           'km',
                                        //           style: Theme.of(
                                        //               context)
                                        //               .textTheme
                                        //               .bodyText1!
                                        //               .copyWith(
                                        //               fontSize:
                                        //               10),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: SizeVariables
                                        //           .getWidth(
                                        //           context) *
                                        //           0.02),
                                        //   child: FittedBox(
                                        //     fit: BoxFit.contain,
                                        //     child: Text(
                                        //       '||',
                                        //       style: Theme.of(context)
                                        //           .textTheme
                                        //           .bodyText1,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   padding: EdgeInsets.only(
                                        //       left: SizeVariables
                                        //           .getWidth(
                                        //           context) *
                                        //           0.015),
                                        //   child: FittedBox(
                                        //     fit: BoxFit.contain,
                                        //     child: Text(
                                        //         claimData
                                        //             .intelligence_duration
                                        //             .toString()),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.green,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Row(
                                    children: [
                                      const FittedBox(
                                        fit: BoxFit.contain,
                                        child: Icon(
                                          Icons.currency_rupee_outlined,
                                          color: Color(0xffF59F23),
                                          size: 16,
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          claimData.amount.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 20),
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
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callListApi(BuildContext context, DateTime start, DateTime end) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    Map data = {
      "status": "",
      "from_date": dateRange.start.toString().split(" ")[0].toString(),
      "to_date": dateRange.end.toString().split(" ")[0].toString(),
    };

    print(data.toString());
    conveyance_list.postConyenanceList(context, data);
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        saveText: "SET",
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xffF59F23),
                  surface: Colors.black,
                  onSurface: Colors.grey,
                ),
                dialogBackgroundColor: Color.fromARGB(255, 91, 91, 91),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      Map data = {
        "from_date": dateRange.start.toString().split(" ")[0].toString(),
        "to_date": dateRange.end.toString().split(" ")[0].toString(),
        "status": "",
      };
      conveyance_list.postConyenanceList(context, data);
    });

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    print('dateRange: $dateRange');
    return dateRange;
  }
}
