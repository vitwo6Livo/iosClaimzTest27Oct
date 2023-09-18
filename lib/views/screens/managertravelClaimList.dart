// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:claimz/views/screens/travelClaimListShimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../res/appUrl.dart';
import '../../res/components/containerStyle.dart';
import '../config/mediaQuery.dart';

class ManagerTravelClaimList extends StatefulWidget {
  // const ManagerTravelClaimList({Key? key}) : super(key: key);

  @override
  State<ManagerTravelClaimList> createState() => _ManagerTravelClaimListState();
}

class _ManagerTravelClaimListState extends State<ManagerTravelClaimList> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, 4, 1),
    end: DateTime(DateTime.now().year + 1, 3, 31),
  );
  TravelViewModel _travelList = new TravelViewModel();
  int _selection = 0;
  String approval_status = "";
  var _userid = "";

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    final start = dateRange.start;
    final end = dateRange.end;
    _getApproval(start, end);
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: ListView(
          children: [
            Container(
              // height: SizeVariables.getHeight(context) * 0.07,
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             CustomBottomNavigation(0)));
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
                        'Travel Claim List',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.amber,
                  width: SizeVariables.getWidth(context) * 0.7,
                  child: DateRangePicker(
                    onPressed: pickDateRange,
                    end: end,
                    start: start,
                    // width: 1,
                  ),
                ),
                Container(
                  // color: Colors.green,
                  child: InkWell(
                    onTap: () => openDialogBox(),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      // height: SizeVariables.getHeight(context) * 0.03,
                      // width: SizeVariables.getWidth(context) * 0.17,
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: _selection == 0
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.white,
                        ),
                        child:
                            Text('All', style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
                          String approval =
                              localStorage.getString('approval').toString();

                          setState(() {
                            _selection = 0;
                            Map data = {
                              "month": "",
                              "type": "",
                              "year": "",
                              "user_id": "",
                              "all": "0", //manager
                              "status": approval
                            };
                            _travelList.postTravelList(data, context);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: _selection == 1
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.white,
                        ),
                        child: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Domestic',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
                          String approval =
                              localStorage.getString('approval').toString();

                          setState(() {
                            _selection = 1;
                            Map data = {
                              "month": "",
                              "type": "domestic",
                              "year": "",
                              "user_id": "",
                              "all": "0", //manager
                              "status": approval,
                            };

                            _travelList.postTravelList(data, context);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: _selection == 2
                              ? Theme.of(context).colorScheme.onPrimary
                              : Colors.white,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'International',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
                          String approval =
                              localStorage.getString('approval').toString();

                          setState(() {
                            _selection = 2;

                            Map data = {
                              "month": "",
                              "type": "international",
                              "year": "",
                              "user_id": "",
                              "all": "0", //manager
                              "status": approval
                            };
                            _travelList.postTravelList(data, context);
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            // SizedBox(
            //   height: SizeVariables.getHeight(context) * 0.02,
            // ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //   topRight: Radius.circular(20),
                  //   topLeft: Radius.circular(20),
                  //   // bottomLeft: Radius.circular(40),
                  //   // bottomRight: Radius.circular(40),
                  // ),
                  color: (themeProvider.darkTheme)
                      ? Colors.black
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
                child: ChangeNotifierProvider<TravelViewModel>(
                    create: (BuildContext context) => _travelList,
                    child: Consumer<TravelViewModel>(
                        builder: (context, value, child) {
                      switch (value.travelList.status) {
                        case Status.ERROR:
                          return Center(
                            child: Text(value.travelList.message.toString()),
                          );
                        case Status.LOADING:
                          return TravellistShimmer()
                              // CircularProgressIndicator(),
                              ;
                        case Status.COMPLETED:
                          if (value.travelList.data!.data!.isEmpty) {
                            return Center(
                              child: Container(
                                width: 250,
                                height: 250,
                                // color: Colors.green,
                                child: Lottie.asset('assets/json/ToDo.json'),
                              ),
                            );
                          } else {
                            return Container(
                              height: SizeVariables.getHeight(context) * 0.75,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: value.travelList.data!.data!.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteNames.managerapproveclaims,
                                        arguments: {
                                          "status": approval_status,
                                          "all": "0",
                                          "doc": value.travelList.data!
                                              .data![index].dataList!.docNo
                                              .toString()
                                        });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: SizeVariables.getHeight(context) *
                                          0.02,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: (themeProvider.darkTheme)
                                            ? []
                                            : [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 7,
                                                  //offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                      ),
                                      child: ContainerStyle(
                                        height: height > 750
                                            ? 29.h
                                            : height < 650
                                                ? 17.h
                                                : 15.h,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: SizeVariables.getWidth(
                                                    context) *
                                                0.04,
                                            right: SizeVariables.getWidth(
                                                    context) *
                                                0.04,
                                            top: SizeVariables.getHeight(
                                                    context) *
                                                0.015,
                                            bottom: SizeVariables.getHeight(
                                                    context) *
                                                0.015,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        // profile photo////////////////////
                                                        backgroundImage:
                                                            NetworkImage(
                                                          value
                                                              .travelList
                                                              .data!
                                                              .data![index]
                                                              .dataList!
                                                              .profilePhoto
                                                              .toString(),
                                                        ),
                                                        radius: 18,
                                                      ),
                                                      SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.008,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              // emp name //////////////////////////
                                                              value
                                                                          .travelList
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .dataList!
                                                                          .empName
                                                                          .toString()
                                                                          .length <=
                                                                      16
                                                                  ? value
                                                                      .travelList
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .dataList!
                                                                      .empName
                                                                      .toString()
                                                                  : value
                                                                      .travelList
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .dataList!
                                                                      .empName
                                                                      .toString()
                                                                      .replaceRange(
                                                                          16,
                                                                          value
                                                                              .travelList
                                                                              .data!
                                                                              .data![index]
                                                                              .dataList!
                                                                              .empName
                                                                              .toString()
                                                                              .length,
                                                                          ".."),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                            ),
                                                          ),
                                                          FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              // emp code ///////////////////////////////////
                                                              value
                                                                  .travelList
                                                                  .data!
                                                                  .data![index]
                                                                  .dataList!
                                                                  .empCode
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        10,
                                                                  )
                                                                  .copyWith(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      // ststus//////////////////////////////////
                                                      value
                                                          .travelList
                                                          .data!
                                                          .data![index]
                                                          .dataList!
                                                          .status
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            color: const Color
                                                                .fromARGB(
                                                              255,
                                                              109,
                                                              247,
                                                              143,
                                                            ),
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.012,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.message,
                                                        color: Colors.amber,
                                                        size: 18,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          // doc number////////////////////////////
                                                          value
                                                              .travelList
                                                              .data!
                                                              .data![index]
                                                              .dataList!
                                                              .docNo
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .amber,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black,
                                                      radius: 11,
                                                      child: Text(
                                                        // no of claim/////////////////////
                                                        value
                                                            .travelList
                                                            .data!
                                                            .data![index]
                                                            .dataList!
                                                            .noOfClaim
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.012,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Purchase: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Container(
                                                      width: 180,
                                                      child: Text(
                                                        //purpose//////////////////////
                                                        value
                                                                    .travelList
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .dataList!
                                                                    .purpose
                                                                    .toString()
                                                                    .length <=
                                                                33
                                                            ? value
                                                                .travelList
                                                                .data!
                                                                .data![index]
                                                                .dataList!
                                                                .purpose
                                                                .toString()
                                                            : value
                                                                .travelList
                                                                .data!
                                                                .data![index]
                                                                .dataList!
                                                                .purpose
                                                                .toString()
                                                                .replaceRange(
                                                                    33,
                                                                    value
                                                                        .travelList
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .dataList!
                                                                        .purpose
                                                                        .toString()
                                                                        .length,
                                                                    "..."),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 12)
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.012,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      // date/////////////////////////
                                                      value
                                                          .travelList
                                                          .data!
                                                          .data![index]
                                                          .dataList!
                                                          .date
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      // amount//////////////////////////////////
                                                      '\₹' +
                                                          double.parse(value
                                                                  .travelList
                                                                  .data!
                                                                  .data![index]
                                                                  .dataList!
                                                                  .amount!)
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.amber),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.012,
                                              ),

                                              value
                                                      .travelList
                                                      .data!
                                                      .data![index]
                                                      .approvalLog!
                                                      .isEmpty
                                                  ? Container()
                                                  : Container(
                                                      width: double.infinity,
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.1,
                                                      // color: Colors.red,
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          for (int i = 0;
                                                              i <
                                                                  value
                                                                      .travelList
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .approvalLog!
                                                                      .length;
                                                              i++)
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.green,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                        ),
                                                                        child: value.travelList.data!.data![index].approvalLog![i].profilePhoto == '' ||
                                                                                value.travelList.data!.data![index].approvalLog![i].profilePhoto == null
                                                                            ? CircleAvatar(
                                                                                radius: SizeVariables.getWidth(context) * 0.04,
                                                                                backgroundColor: Colors.green,
                                                                                backgroundImage: const AssetImage('assets/img/profilePic.jpg'),
                                                                                // child: const Icon(Icons.account_box, color: Colors.white),
                                                                              )
                                                                            : CachedNetworkImage(
                                                                                imageUrl: value.travelList.data!.data![index].approvalLog![i].profilePhoto!,
                                                                                imageBuilder: (context, imageProvider) => Container(
                                                                                  height: SizeVariables.getHeight(context) * 0.08,
                                                                                  width: SizeVariables.getHeight(context) * 0.08,
                                                                                  decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: BoxFit.contain)),
                                                                                ),
                                                                                placeholder: (context, url) => Container(
                                                                                    height: SizeVariables.getHeight(context) * 0.06,
                                                                                    child: Shimmer.fromColors(
                                                                                      baseColor: Colors.grey[400]!,
                                                                                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                                                                                      child: const CircleAvatar(
                                                                                        radius: 2,
                                                                                        backgroundColor: Colors.green,
                                                                                        child: Center(
                                                                                          child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                                                                                        ),
                                                                                      ),
                                                                                    )),
                                                                              )
                                                                        //     CircleAvatar(
                                                                        //   radius: SizeVariables
                                                                        //           .getWidth(
                                                                        //               context) *
                                                                        //       0.04,
                                                                        //   backgroundColor:
                                                                        //       Colors
                                                                        //           .green,
                                                                        //   backgroundImage:
                                                                        //       const AssetImage(
                                                                        //     'assets/img/profilePic.jpg',
                                                                        //   ),
                                                                        //   // child: const Icon(Icons.account_box, color: Colors.white),
                                                                        // ),
                                                                        ),
                                                                    SizedBox(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.002,
                                                                    ),
                                                                    Container(
                                                                      width: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.1,
                                                                      child:
                                                                          Text(
                                                                        value
                                                                            .travelList
                                                                            .data!
                                                                            .data![index]
                                                                            .approvalLog![i]
                                                                            .empName!,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                              fontSize: 10,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.002,
                                                                    ),
                                                                    Text(
                                                                      DateFormat('yyyy-MM-dd').format(DateTime.parse(value
                                                                          .travelList
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .approvalLog![
                                                                              i]
                                                                          .createdAt!)),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                            fontSize:
                                                                                10,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                value
                                                                            .travelList
                                                                            .data!
                                                                            .data![index]
                                                                            .approvalLog!
                                                                            .length ==
                                                                        1
                                                                    ? Container()
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          bottom:
                                                                              20,
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              37,
                                                                          height:
                                                                              4,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      )
                                                              ],
                                                            ),
                                                          // Padding(
                                                          //       padding:
                                                          //           const EdgeInsets
                                                          //               .only(
                                                          //         bottom: 20,
                                                          //       ),
                                                          //       child: Container(
                                                          //         width: 37,
                                                          //         height: 4,
                                                          //         color: Colors.grey,
                                                          //       ),
                                                          //     ),
                                                        ],
                                                      ),
                                                    ),

                                              // SingleChildScrollView(
                                              //   scrollDirection:
                                              //       Axis.horizontal,
                                              //   child: Row(
                                              //     // mainAxisAlignment:
                                              //     //     MainAxisAlignment.spaceBetween,
                                              //     children: <Widget>[
                                              //       Column(
                                              //         children: [
                                              //           Container(
                                              //             width: 50,
                                              //             height: 50,
                                              //             decoration:
                                              //                 BoxDecoration(
                                              //               shape:
                                              //                   BoxShape.circle,
                                              //               border: Border.all(
                                              //                 color:
                                              //                     Colors.green,
                                              //                 width: 3,
                                              //               ),
                                              //             ),
                                              //             child: CircleAvatar(
                                              //               radius: SizeVariables
                                              //                       .getWidth(
                                              //                           context) *
                                              //                   0.04,
                                              //               backgroundColor:
                                              //                   Colors.green,
                                              //               backgroundImage:
                                              //                   const AssetImage(
                                              //                 'assets/img/profilePic.jpg',
                                              //               ),
                                              //               // child: const Icon(Icons.account_box, color: Colors.white),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Container(
                                              //             width: SizeVariables
                                              //                     .getWidth(
                                              //                         context) *
                                              //                 0.1,
                                              //             child: Text(
                                              //               'Shaikh salim Akhtar',
                                              //               overflow:
                                              //                   TextOverflow
                                              //                       .ellipsis,
                                              //               style: Theme.of(
                                              //                       context)
                                              //                   .textTheme
                                              //                   .bodyText1!
                                              //                   .copyWith(
                                              //                     fontSize: 10,
                                              //                   ),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Text(
                                              //             '2023-05-08',
                                              //             style:
                                              //                 Theme.of(context)
                                              //                     .textTheme
                                              //                     .bodyText1!
                                              //                     .copyWith(
                                              //                       fontSize:
                                              //                           10,
                                              //                     ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       Padding(
                                              //         padding:
                                              //             const EdgeInsets.only(
                                              //           bottom: 20,
                                              //         ),
                                              //         child: Container(
                                              //           width: 37,
                                              //           height: 4,
                                              //           color: Colors.grey,
                                              //         ),
                                              //       ),
                                              //       Column(
                                              //         children: [
                                              //           Container(
                                              //             width: 50,
                                              //             height: 50,
                                              //             decoration:
                                              //                 BoxDecoration(
                                              //               shape:
                                              //                   BoxShape.circle,
                                              //               border: Border.all(
                                              //                 color:
                                              //                     Colors.amber,
                                              //                 width: 3,
                                              //               ),
                                              //             ),
                                              //             child: CircleAvatar(
                                              //               radius: SizeVariables
                                              //                       .getWidth(
                                              //                           context) *
                                              //                   0.01,
                                              //               backgroundColor:
                                              //                   Colors.green,
                                              //               backgroundImage:
                                              //                   const AssetImage(
                                              //                 'assets/img/profilePic.jpg',
                                              //               ),
                                              //               // child: const Icon(Icons.account_box, color: Colors.white),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Container(
                                              //             width: SizeVariables
                                              //                     .getWidth(
                                              //                         context) *
                                              //                 0.1,
                                              //             child: Text(
                                              //               '..........................................',
                                              //               overflow:
                                              //                   TextOverflow
                                              //                       .ellipsis,
                                              //               style: Theme.of(
                                              //                       context)
                                              //                   .textTheme
                                              //                   .bodyText1!
                                              //                   .copyWith(
                                              //                     fontSize: 10,
                                              //                   ),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Text(
                                              //             '--/--/--',
                                              //             style:
                                              //                 Theme.of(context)
                                              //                     .textTheme
                                              //                     .bodyText1!
                                              //                     .copyWith(
                                              //                       fontSize:
                                              //                           10,
                                              //                     ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       Padding(
                                              //         padding:
                                              //             const EdgeInsets.only(
                                              //           bottom: 20,
                                              //         ),
                                              //         child: Container(
                                              //           width: 37,
                                              //           height: 4,
                                              //           color: Colors.grey,
                                              //         ),
                                              //       ),
                                              //       Column(
                                              //         children: [
                                              //           Container(
                                              //             width: 50,
                                              //             height: 50,
                                              //             decoration:
                                              //                 BoxDecoration(
                                              //               shape:
                                              //                   BoxShape.circle,
                                              //               border: Border.all(
                                              //                 color:
                                              //                     Colors.grey,
                                              //                 width: 3,
                                              //               ),
                                              //             ),
                                              //             child: CircleAvatar(
                                              //               radius: SizeVariables
                                              //                       .getWidth(
                                              //                           context) *
                                              //                   0.01,
                                              //               backgroundColor:
                                              //                   Colors.green,
                                              //               backgroundImage:
                                              //                   const AssetImage(
                                              //                 'assets/img/profilePic.jpg',
                                              //               ),
                                              //               // child: const Icon(Icons.account_box, color: Colors.white),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Container(
                                              //             width: SizeVariables
                                              //                     .getWidth(
                                              //                         context) *
                                              //                 0.1,
                                              //             child: Text(
                                              //               '.....................',
                                              //               overflow:
                                              //                   TextOverflow
                                              //                       .ellipsis,
                                              //               style: Theme.of(
                                              //                       context)
                                              //                   .textTheme
                                              //                   .bodyText1!
                                              //                   .copyWith(
                                              //                     fontSize: 10,
                                              //                   ),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Text(
                                              //             '--/--/--',
                                              //             style:
                                              //                 Theme.of(context)
                                              //                     .textTheme
                                              //                     .bodyText1!
                                              //                     .copyWith(
                                              //                       fontSize:
                                              //                           10,
                                              //                     ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       Padding(
                                              //         padding:
                                              //             const EdgeInsets.only(
                                              //           bottom: 20,
                                              //         ),
                                              //         child: Container(
                                              //           width: 37,
                                              //           height: 4,
                                              //           color: Colors.grey,
                                              //         ),
                                              //       ),
                                              //       Column(
                                              //         children: [
                                              //           Container(
                                              //             width: 50,
                                              //             height: 50,
                                              //             decoration:
                                              //                 BoxDecoration(
                                              //               shape:
                                              //                   BoxShape.circle,
                                              //               border: Border.all(
                                              //                 color:
                                              //                     Colors.grey,
                                              //                 width: 3,
                                              //               ),
                                              //             ),
                                              //             child: CircleAvatar(
                                              //               radius: SizeVariables
                                              //                       .getWidth(
                                              //                           context) *
                                              //                   0.01,
                                              //               backgroundColor:
                                              //                   Colors.green,
                                              //               backgroundImage:
                                              //                   const AssetImage(
                                              //                 'assets/img/profilePic.jpg',
                                              //               ),
                                              //               // child: const Icon(Icons.account_box, color: Colors.white),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Container(
                                              //             width: SizeVariables
                                              //                     .getWidth(
                                              //                         context) *
                                              //                 0.1,
                                              //             child: Text(
                                              //               '..................................',
                                              //               overflow:
                                              //                   TextOverflow
                                              //                       .ellipsis,
                                              //               style: Theme.of(
                                              //                       context)
                                              //                   .textTheme
                                              //                   .bodyText1!
                                              //                   .copyWith(
                                              //                     fontSize: 10,
                                              //                   ),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Text(
                                              //             '--/--/--',
                                              //             style:
                                              //                 Theme.of(context)
                                              //                     .textTheme
                                              //                     .bodyText1!
                                              //                     .copyWith(
                                              //                       fontSize:
                                              //                           10,
                                              //                     ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       Padding(
                                              //         padding:
                                              //             const EdgeInsets.only(
                                              //           bottom: 20,
                                              //         ),
                                              //         child: Container(
                                              //           width: 37,
                                              //           height: 4,
                                              //           color: Colors.grey,
                                              //         ),
                                              //       ),
                                              //       Column(
                                              //         children: [
                                              //           Container(
                                              //             width: 50,
                                              //             height: 50,
                                              //             decoration:
                                              //                 BoxDecoration(
                                              //               shape:
                                              //                   BoxShape.circle,
                                              //               border: Border.all(
                                              //                 color:
                                              //                     Colors.grey,
                                              //                 width: 3,
                                              //               ),
                                              //             ),
                                              //             child: CircleAvatar(
                                              //               radius: SizeVariables
                                              //                       .getWidth(
                                              //                           context) *
                                              //                   0.01,
                                              //               backgroundColor:
                                              //                   Colors.green,
                                              //               backgroundImage:
                                              //                   const AssetImage(
                                              //                 'assets/img/profilePic.jpg',
                                              //               ),
                                              //               // child: const Icon(Icons.account_box, color: Colors.white),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Container(
                                              //             width: SizeVariables
                                              //                     .getWidth(
                                              //                         context) *
                                              //                 0.1,
                                              //             child: Text(
                                              //               '.................................',
                                              //               overflow:
                                              //                   TextOverflow
                                              //                       .ellipsis,
                                              //               style: Theme.of(
                                              //                       context)
                                              //                   .textTheme
                                              //                   .bodyText1!
                                              //                   .copyWith(
                                              //                     fontSize: 10,
                                              //                   ),
                                              //             ),
                                              //           ),
                                              //           SizedBox(
                                              //             height: SizeVariables
                                              //                     .getHeight(
                                              //                         context) *
                                              //                 0.002,
                                              //           ),
                                              //           Text(
                                              //             '--/--/--',
                                              //             style:
                                              //                 Theme.of(context)
                                              //                     .textTheme
                                              //                     .bodyText1!
                                              //                     .copyWith(
                                              //                       fontSize:
                                              //                           10,
                                              //                     ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      }
                      return Container();
                    })),
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.002,
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.002,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getApproval(DateTime start, DateTime end) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String approval = localStorage.getString('approval').toString();
    approval_status = approval;

    if (kDebugMode) {
      print("APPROVAL " + approval.toString());
    }
    Map data = {
      "from_date": dateRange.start.toString().split(" ")[0].toString(),
      "to_date": dateRange.end.toString().split(" ")[0].toString(),
      "month": "",
      "type": "",
      "year": "",
      "emp_id": _userid,
      "all": "0", //manager
      "status": approval.toString()
    };

    print('Manager Travel List Data: $data');

    _travelList.postTravelList(data, context);
  }

  void openDialogBox() {
    ClaimzHistoryViewModel searchUserData = ClaimzHistoryViewModel();
    Map data = {
      "keyword": "",
    };
    searchUserData.postSearchUser(context, data);
    TextEditingController _searchUser = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 99, 97, 97),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Employee',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        content: Container(
          // color: Colors.black,
          height: SizeVariables.getHeight(context) * 0.58,
          width: SizeVariables.getWidth(context) * 0.8,
          child: Column(
            children: [
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                child: TextField(
                  onSubmitted: (value) {
                    Map data = {
                      "keyword": value.toString(),
                    };
                    searchUserData.postSearchUser(context, data);
                  },
                  textInputAction: TextInputAction.search,
                  controller: _searchUser,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'Search',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey),
                    filled: true,
                    fillColor: Color.fromARGB(255, 76, 75, 75),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              ChangeNotifierProvider<ClaimzHistoryViewModel>(
                create: (context) => searchUserData,
                child: Consumer<ClaimzHistoryViewModel>(
                  builder: (context, value, child) {
                    switch (value.searchUserRecord.status) {
                      case Status.ERROR:
                        return Center(
                          child:
                              Text(value.searchUserRecord.message.toString()),
                        );
                      // case Status.LOADING:
                      //   return Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        return Container(
                          height: SizeVariables.getHeight(context) * 0.43,
                          width: SizeVariables.getWidth(context) * 0.6,
                          // color: Colors.red,
                          child: ListView(
                            children: [
                              Container(
                                height: 400,
                                // width: SizeVariables.getWidth(context) * 0.4,
                                // color: Colors.amber,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      value.searchUserRecord.data!.data!.length,
                                  itemBuilder: (context, index) =>
                                      ContainerStyle(
                                    height:
                                        SizeVariables.getHeight(context) * 0.07,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () async {
                                          SharedPreferences localStorage =
                                              await SharedPreferences
                                                  .getInstance();
                                          String approval = localStorage
                                              .getString('approval')
                                              .toString();
                                          _userid = value.searchUserRecord.data!
                                              .data![index].id
                                              .toString();

                                          print("USER-ID>>> " +
                                              _userid.toString());
                                          setState(() {
                                            Map data = {
                                              "month": "",
                                              "type": "",
                                              "year": "",
                                              "emp_id": _userid,
                                              "all": "0", //manager
                                              "status": approval
                                            };

                                            _travelList.postTravelList(
                                                data, context);
                                          });

                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: value
                                                              .searchUserRecord
                                                              .data!
                                                              .data![index]
                                                              .profilePhoto ==
                                                          '${AppUrl.baseUrl}/profile_photo/' ||
                                                      value
                                                              .searchUserRecord
                                                              .data!
                                                              .data![index]
                                                              .profilePhoto ==
                                                          null
                                                  ? CircleAvatar(
                                                      radius: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.07,
                                                      backgroundColor:
                                                          Colors.green,
                                                      backgroundImage:
                                                          const AssetImage(
                                                              'assets/img/profilePic.jpg'),
                                                      // child: const Icon(Icons.account_box, color: Colors.white),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: value
                                                          .searchUserRecord
                                                          .data!
                                                          .data![index]
                                                          .profilePhoto,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.07,
                                                        width: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.07,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .contain)),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Container(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.06,
                                                              child: Shimmer
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
                                                                child:
                                                                    const CircleAvatar(
                                                                  radius: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  child: Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .camera_alt_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20),
                                                                  ),
                                                                ),
                                                              )),
                                                    ),
                                            ),
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                value.searchUserRecord.data!
                                                    .data![index].empName
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                    return Container();
                  },
                  // child: Container(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        saveText: 'SET',
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xffF59F23),
                  surface: Colors.grey,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: const Color.fromARGB(255, 91, 91, 91),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      // print("START>>"+dateRange.start.toString());
      // print("END>>"+dateRange.end.toString());

      String approval = localStorage.getString('approval').toString();
      Map data = {
        "from_date": dateRange.start.toString().split(" ")[0].toString(),
        "to_date": dateRange.end.toString().split(" ")[0].toString(),
        "month": "",
        "type": "",
        "year": "",
        "emp_id": _userid,
        "all": "0", //manager
        "status": approval.toString()
      };
      _travelList.postTravelList(data, context);
    });
    print('dateRange: $dateRange');
    return dateRange;
  }
}




// // ignore_for_file: use_build_context_synchronously

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:claimz/data/response/status.dart';
// import 'package:claimz/provider/theme_provider.dart';
// import 'package:claimz/res/components/bottomNavigationBar.dart';
// import 'package:claimz/res/components/buttonStyle.dart';
// import 'package:claimz/res/components/date_range_picker.dart';
// import 'package:claimz/utils/routes/routeNames.dart';
// import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
// import 'package:claimz/viewModel/travelViewModel.dart';
// import 'package:claimz/views/screens/travelClaimListShimmer.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sizer/sizer.dart';

// import '../../res/appUrl.dart';
// import '../../res/components/containerStyle.dart';
// import '../config/mediaQuery.dart';

// class ManagerTravelClaimList extends StatefulWidget {
//   // const ManagerTravelClaimList({Key? key}) : super(key: key);

//   @override
//   State<ManagerTravelClaimList> createState() => _ManagerTravelClaimListState();
// }

// class _ManagerTravelClaimListState extends State<ManagerTravelClaimList> {
//   DateTimeRange dateRange = DateTimeRange(
//     start: DateTime(DateTime.now().year, 4, 1),
//     end: DateTime(DateTime.now().year + 1, 3, 31),
//   );
//   TravelViewModel _travelList = new TravelViewModel();
//   int _selection = 0;
//   String approval_status = "";
//   var _userid = "";
//   bool isLoading = true;

//   @override
//   initState() {
//     // TODO: implement initState
//     super.initState();
//     final start = dateRange.start;
//     final end = dateRange.end;
//     _getApproval(start, end).then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final start = dateRange.start;
//     final end = dateRange.end;
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     final provider = Provider.of<TravelViewModel>(context).travellist;


//     // TODO: implement build

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Container(
//         padding: EdgeInsets.only(
//           left: SizeVariables.getWidth(context) * 0.025,
//           right: SizeVariables.getWidth(context) * 0.025,
//         ),
//         child: ListView(
//           children: [
//             Container(
//               // height: SizeVariables.getHeight(context) * 0.07,
//               width: double.infinity,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: SizeVariables.getHeight(context) * 0.02),
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             // Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         CustomBottomNavigation(0)));
//                           },
//                           child: SvgPicture.asset(
//                             "assets/icons/back button.svg",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: SizeVariables.getHeight(context) * 0.02,
//                         left: SizeVariables.getWidth(context) * 0.01),
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: Text(
//                         'Travel Claim Listtt',
//                         style: Theme.of(context).textTheme.caption,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // color: Colors.amber,
//                   width: SizeVariables.getWidth(context) * 0.7,
//                   child: DateRangePicker(
//                     onPressed: pickDateRange,
//                     end: end,
//                     start: start,
//                     // width: 1,
//                   ),
//                 ),
//                 Container(
//                   // color: Colors.green,
//                   child: InkWell(
//                     onTap: () => openDialogBox(),
//                     child: Container(
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(width: 2, color: Colors.white),
//                       ),
//                       // height: SizeVariables.getHeight(context) * 0.03,
//                       // width: SizeVariables.getWidth(context) * 0.17,
//                       child: Icon(
//                         Icons.person,
//                         color: Theme.of(context).colorScheme.primaryVariant,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: _selection == 0
//                               ? Theme.of(context).colorScheme.primaryVariant
//                               : Colors.white,
//                         ),
//                         child:
//                             Text('All', style: TextStyle(color: Colors.black)),
//                         onPressed: () async {
//                           SharedPreferences localStorage =
//                               await SharedPreferences.getInstance();
//                           String approval =
//                               localStorage.getString('approval').toString();

                              

//                           setState(() {
//                             _selection = 0;

//                             isLoading = true;

//                             Map data = {
//                               "month": "",
//                               "type": "",
//                               "year": "",
//                               "user_id": "",
//                               "all": "0", //manager
//                               "status": approval
//                             };
//                             // _travelList.postTravelList(data, context);
//                             Provider.of<TravelViewModel>(context, listen: false).postTravelList(data, context).then((value) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             });
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: _selection == 1
//                               ? Theme.of(context).colorScheme.primaryVariant
//                               : Colors.white,
//                         ),
//                         child: const FittedBox(
//                           fit: BoxFit.contain,
//                           child: Text(
//                             'Domestic',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                         onPressed: () async {
//                           SharedPreferences localStorage =
//                               await SharedPreferences.getInstance();
//                           String approval =
//                               localStorage.getString('approval').toString();

//                           setState(() {
//                             _selection = 1;

//                             isLoading = true;

//                             Map data = {
//                               "month": "",
//                               "type": "domestic",
//                               "year": "",
//                               "user_id": "",
//                               "all": "0", //manager
//                               "status": approval,
//                             };

//                             // _travelList.postTravelList(data, context);
//                             Provider.of<TravelViewModel>(context, listen: false).postTravelList(data, context).then((value) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             });
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: _selection == 2
//                               ? Theme.of(context).colorScheme.primaryVariant
//                               : Colors.white,
//                         ),
//                         child: FittedBox(
//                           fit: BoxFit.contain,
//                           child: Text(
//                             'International',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                         onPressed: () async {
//                           SharedPreferences localStorage =
//                               await SharedPreferences.getInstance();
//                           String approval =
//                               localStorage.getString('approval').toString();

//                           setState(() {
//                             _selection = 2;

//                             isLoading = true;

//                             Map data = {
//                               "month": "",
//                               "type": "international",
//                               "year": "",
//                               "user_id": "",
//                               "all": "0", //manager
//                               "status": approval
//                             };
//                             // _travelList.postTravelList(data, context);

//                             Provider.of<TravelViewModel>(context, listen: false).postTravelList(data, context).then((value) {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             });
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             // SizedBox(
//             //   height: SizeVariables.getHeight(context) * 0.02,
//             // ),
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               child: Container(
//                 decoration: BoxDecoration(
//                   // borderRadius: BorderRadius.only(
//                   //   topRight: Radius.circular(20),
//                   //   topLeft: Radius.circular(20),
//                   //   // bottomLeft: Radius.circular(40),
//                   //   // bottomRight: Radius.circular(40),
//                   // ),
//                   color: (themeProvider.darkTheme)
//                       ? Colors.black
//                       : Theme.of(context).scaffoldBackgroundColor,
//                 ),
//                 child: ChangeNotifierProvider<TravelViewModel>(
//                     create: (BuildContext context) => _travelList,
//                     child: Consumer<TravelViewModel>(
//                         builder: (context, value, child) {
//                       switch (value.travelList.status) {
//                         // case Status.ERROR:
//                         //   return Center(
//                         //     child: Text(value.travelList.message.toString()),
//                         //   );
//                         // case Status.LOADING:
//                         //   return TravellistShimmer()
//                         //       // CircularProgressIndicator(),
//                         //       ;
//                         case Status.COMPLETED:
//                           if (
//                             // value.travelList.data!.data!.isEmpty
//                             provider['data'].isEmpty
//                             ) {
//                             return Center(
//                               child: Container(
//                                 width: 250,
//                                 height: 250,
//                                 // color: Colors.green,
//                                 child: Lottie.asset('assets/json/ToDo.json'),
//                               ),
//                             );
//                           } else {
//                             return Container(
//                               height: SizeVariables.getHeight(context) * 0.75,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: provider['data'].length,
//                                 // value.travelList.data!.data!.length,
//                                 itemBuilder: (context, index) => InkWell(
//                                   onTap: () {
//                                     Navigator.pushNamed(context,
//                                         RouteNames.managerapproveclaims,
//                                         arguments: {
//                                           "status": approval_status,
//                                           "all": "0",
//                                           "doc": provider['data'][index]['data_list']['doc_no'].toString()
//                                           // value.travelList.data!
//                                           //     .data![index].dataList!.docNo
//                                           //     .toString()
//                                         });
//                                   },
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                       bottom: SizeVariables.getHeight(context) *
//                                           0.02,
//                                     ),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         boxShadow: (themeProvider.darkTheme)
//                                             ? []
//                                             : [
//                                                 BoxShadow(
//                                                   color: Colors.grey
//                                                       .withOpacity(0.5),
//                                                   spreadRadius: 0,
//                                                   blurRadius: 7,
//                                                   //offset: Offset(0, 3), // changes position of shadow
//                                                 ),
//                                               ],
//                                       ),
//                                       child: ContainerStyle(
//                                         height: height > 750
//                                             ? 29.h
//                                             : height < 650
//                                                 ? 17.h
//                                                 : 15.h,
//                                         child: Container(
//                                           padding: EdgeInsets.only(
//                                             left: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.04,
//                                             right: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.04,
//                                             top: SizeVariables.getHeight(
//                                                     context) *
//                                                 0.015,
//                                             bottom: SizeVariables.getHeight(
//                                                     context) *
//                                                 0.015,
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         // profile photo////////////////////
//                                                         backgroundImage:
//                                                             NetworkImage(
//                                                           // value
//                                                           //     .travelList
//                                                           //     .data!
//                                                           //     .data![index]
//                                                           //     .dataList!
//                                                           //     .profilePhoto
//                                                           provider['data'][index]['data_list']['profile_photo']
//                                                               .toString(),
//                                                         ),
//                                                         radius: 18,
//                                                       ),
//                                                       SizedBox(
//                                                         width: SizeVariables
//                                                                 .getWidth(
//                                                                     context) *
//                                                             0.008,
//                                                       ),
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           FittedBox(
//                                                             fit: BoxFit.contain,
//                                                             child: Text(
//                                                               // emp name //////////////////////////
//                                                               // value
//                                                               //             .travelList
//                                                               //             .data!
//                                                               //             .data![
//                                                               //                 index]
//                                                               //             .dataList!
//                                                               //             .empName
//                                                               provider['data'][index]['data_list']['emp_name']
//                                                                           .toString()
//                                                                           .length <=
//                                                                       16
//                                                                   ? 
//                                                                   // value
//                                                                   //     .travelList
//                                                                   //     .data!
//                                                                   //     .data![
//                                                                   //         index]
//                                                                   //     .dataList!
//                                                                   //     .empName
//                                                                   provider['data'][index]['data_list']['emp_name']
//                                                                       .toString()
//                                                                   : 
//                                                                   // value
//                                                                   //     .travelList
//                                                                   //     .data!
//                                                                   //     .data![
//                                                                   //         index]
//                                                                   //     .dataList!
//                                                                   //     .empName
//                                                                   provider['data'][index]['data_list']['emp_name']
//                                                                       .toString()
//                                                                       .replaceRange(
//                                                                           16,
//                                                                           // value
//                                                                           //     .travelList
//                                                                           //     .data!
//                                                                           //     .data![index]
//                                                                           //     .dataList!
//                                                                           //     .empName
//                                                                           provider['data'][index]['data_list']['emp_name']
//                                                                               .toString()
//                                                                               .length,
//                                                                           ".."),
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .bodyText1!
//                                                                   .copyWith(
//                                                                     fontSize:
//                                                                         14,
//                                                                     color: Colors
//                                                                         .grey,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                           FittedBox(
//                                                             fit: BoxFit.contain,
//                                                             child: Text(
//                                                               // emp code ///////////////////////////////////
//                                                               // value
//                                                               //     .travelList
//                                                               //     .data!
//                                                               //     .data![index]
//                                                               //     .dataList!
//                                                               //     .empCode
//                                                               provider['data'][index]['data_list']['emp_code']
//                                                                   .toString(),
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .bodyText1!
//                                                                   .copyWith(
//                                                                     fontSize:
//                                                                         10,
//                                                                   )
//                                                                   .copyWith(
//                                                                     fontStyle:
//                                                                         FontStyle
//                                                                             .italic,
//                                                                     color: Colors
//                                                                         .amber,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   FittedBox(
//                                                     fit: BoxFit.contain,
//                                                     child: Text(
//                                                       // ststus//////////////////////////////////
//                                                       // value
//                                                       //     .travelList
//                                                       //     .data!
//                                                       //     .data![index]
//                                                       //     .dataList!
//                                                       //     .status
//                                                       provider['data'][index]['data_list']['status']
//                                                           .toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText1!
//                                                           .copyWith(
//                                                             color: const Color
//                                                                 .fromARGB(
//                                                               255,
//                                                               109,
//                                                               247,
//                                                               143,
//                                                             ),
//                                                             fontSize: 12,
//                                                           ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: SizeVariables.getHeight(
//                                                         context) *
//                                                     0.012,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       const Icon(
//                                                         Icons.message,
//                                                         color: Colors.amber,
//                                                         size: 18,
//                                                       ),
//                                                       FittedBox(
//                                                         fit: BoxFit.contain,
//                                                         child: Text(
//                                                           // doc number////////////////////////////
//                                                           // value
//                                                           //     .travelList
//                                                           //     .data!
//                                                           //     .data![index]
//                                                           //     .dataList!
//                                                           //     .docNo
//                                                           provider['data'][index]['data_list']['doc_no']
//                                                               .toString(),
//                                                           style:
//                                                               Theme.of(context)
//                                                                   .textTheme
//                                                                   .bodyText1!
//                                                                   .copyWith(
//                                                                     color: Colors
//                                                                         .amber,
//                                                                     fontSize:
//                                                                         12,
//                                                                   ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   CircleAvatar(
//                                                     radius: 12,
//                                                     backgroundColor:
//                                                         Colors.grey,
//                                                     child: CircleAvatar(
//                                                       backgroundColor:
//                                                           Colors.black,
//                                                       radius: 11,
//                                                       child: Text(
//                                                         // no of claim/////////////////////
//                                                         // value
//                                                         //     .travelList
//                                                         //     .data!
//                                                         //     .data![index]
//                                                         //     .dataList!
//                                                         //     .noOfClaim
//                                                         provider['data'][index]['data_list']['no_of_claim']
//                                                             .toString(),
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText2!
//                                                             .copyWith(
//                                                               color:
//                                                                   Colors.white,
//                                                               fontSize: 13,
//                                                             ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: SizeVariables.getHeight(
//                                                         context) *
//                                                     0.012,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     'Purchase: ',
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1,
//                                                   ),
//                                                   FittedBox(
//                                                     fit: BoxFit.contain,
//                                                     child: Container(
//                                                       width: 180,
//                                                       child: Text(
//                                                         //purpose//////////////////////
//                                                         // value
//                                                         //             .travelList
//                                                         //             .data!
//                                                         //             .data![
//                                                         //                 index]
//                                                         //             .dataList!
//                                                         //             .purpose
//                                                         provider['data'][index]['data_list']['purpose']
//                                                                     .toString()
//                                                                     .length <=
//                                                                 33
//                                                             ? 
//                                                             // value
//                                                             //     .travelList
//                                                             //     .data!
//                                                             //     .data![index]
//                                                             //     .dataList!
//                                                             //     .purpose
//                                                             provider['data'][index]['data_list']['purpose']
//                                                                 .toString()
//                                                             : value
//                                                                 .travelList
//                                                                 .data!
//                                                                 .data![index]
//                                                                 .dataList!
//                                                                 .purpose
//                                                                 .toString()
//                                                                 .replaceRange(
//                                                                     33,
//                                                                     value
//                                                                         .travelList
//                                                                         .data!
//                                                                         .data![
//                                                                             index]
//                                                                         .dataList!
//                                                                         .purpose
//                                                                         .toString()
//                                                                         .length,
//                                                                     "..."),
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText1!
//                                                             .copyWith(
//                                                                 fontSize: 12)
//                                                             .copyWith(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.grey,
//                                                             ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: SizeVariables.getHeight(
//                                                         context) *
//                                                     0.012,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   FittedBox(
//                                                     fit: BoxFit.contain,
//                                                     child: Text(
//                                                       // date/////////////////////////
//                                                       value
//                                                           .travelList
//                                                           .data!
//                                                           .data![index]
//                                                           .dataList!
//                                                           .date
//                                                           .toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText1!
//                                                           .copyWith(
//                                                             fontSize: 12,
//                                                           ),
//                                                     ),
//                                                   ),
//                                                   FittedBox(
//                                                     fit: BoxFit.contain,
//                                                     child: Text(
//                                                       // amount//////////////////////////////////
//                                                       '\₹' +
//                                                           double.parse(value
//                                                                   .travelList
//                                                                   .data!
//                                                                   .data![index]
//                                                                   .dataList!
//                                                                   .amount!)
//                                                               .toStringAsFixed(
//                                                                   2),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText1!
//                                                           .copyWith(
//                                                               fontSize: 16,
//                                                               color:
//                                                                   Colors.amber),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: SizeVariables.getHeight(
//                                                         context) *
//                                                     0.012,
//                                               ),

//                                               value
//                                                       .travelList
//                                                       .data!
//                                                       .data![index]
//                                                       .approvalLog!
//                                                       .isEmpty
//                                                   ? Container()
//                                                   : Container(
//                                                       width: double.infinity,
//                                                       height: SizeVariables
//                                                               .getHeight(
//                                                                   context) *
//                                                           0.1,
//                                                       // color: Colors.red,
//                                                       child: ListView(
//                                                         scrollDirection:
//                                                             Axis.horizontal,
//                                                         children: [
//                                                           for (int i = 0;
//                                                               i <
//                                                                   value
//                                                                       .travelList
//                                                                       .data!
//                                                                       .data![
//                                                                           index]
//                                                                       .approvalLog!
//                                                                       .length;
//                                                               i++)
//                                                             Row(
//                                                               children: [
//                                                                 Column(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     Container(
//                                                                         width:
//                                                                             50,
//                                                                         height:
//                                                                             50,
//                                                                         decoration:
//                                                                             BoxDecoration(
//                                                                           shape:
//                                                                               BoxShape.circle,
//                                                                           border:
//                                                                               Border.all(
//                                                                             color:
//                                                                                 Colors.green,
//                                                                             width:
//                                                                                 3,
//                                                                           ),
//                                                                         ),
//                                                                         child: value.travelList.data!.data![index].approvalLog![i].profilePhoto == '' ||
//                                                                                 value.travelList.data!.data![index].approvalLog![i].profilePhoto == null
//                                                                             ? CircleAvatar(
//                                                                                 radius: SizeVariables.getWidth(context) * 0.04,
//                                                                                 backgroundColor: Colors.green,
//                                                                                 backgroundImage: const AssetImage('assets/img/profilePic.jpg'),
//                                                                                 // child: const Icon(Icons.account_box, color: Colors.white),
//                                                                               )
//                                                                             : CachedNetworkImage(
//                                                                                 imageUrl: value.travelList.data!.data![index].approvalLog![i].profilePhoto!,
//                                                                                 imageBuilder: (context, imageProvider) => Container(
//                                                                                   height: SizeVariables.getHeight(context) * 0.08,
//                                                                                   width: SizeVariables.getHeight(context) * 0.08,
//                                                                                   decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: BoxFit.contain)),
//                                                                                 ),
//                                                                                 placeholder: (context, url) => Container(
//                                                                                     height: SizeVariables.getHeight(context) * 0.06,
//                                                                                     child: Shimmer.fromColors(
//                                                                                       baseColor: Colors.grey[400]!,
//                                                                                       highlightColor: const Color.fromARGB(255, 120, 120, 120),
//                                                                                       child: const CircleAvatar(
//                                                                                         radius: 2,
//                                                                                         backgroundColor: Colors.green,
//                                                                                         child: Center(
//                                                                                           child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
//                                                                                         ),
//                                                                                       ),
//                                                                                     )),
//                                                                               )
//                                                                         //     CircleAvatar(
//                                                                         //   radius: SizeVariables
//                                                                         //           .getWidth(
//                                                                         //               context) *
//                                                                         //       0.04,
//                                                                         //   backgroundColor:
//                                                                         //       Colors
//                                                                         //           .green,
//                                                                         //   backgroundImage:
//                                                                         //       const AssetImage(
//                                                                         //     'assets/img/profilePic.jpg',
//                                                                         //   ),
//                                                                         //   // child: const Icon(Icons.account_box, color: Colors.white),
//                                                                         // ),
//                                                                         ),
//                                                                     SizedBox(
//                                                                       height: SizeVariables.getHeight(
//                                                                               context) *
//                                                                           0.002,
//                                                                     ),
//                                                                     Container(
//                                                                       width: SizeVariables.getWidth(
//                                                                               context) *
//                                                                           0.1,
//                                                                       child:
//                                                                           Text(
//                                                                         value
//                                                                             .travelList
//                                                                             .data!
//                                                                             .data![index]
//                                                                             .approvalLog![i]
//                                                                             .empName!,
//                                                                         overflow:
//                                                                             TextOverflow.ellipsis,
//                                                                         style: Theme.of(context)
//                                                                             .textTheme
//                                                                             .bodyText1!
//                                                                             .copyWith(
//                                                                               fontSize: 10,
//                                                                             ),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height: SizeVariables.getHeight(
//                                                                               context) *
//                                                                           0.002,
//                                                                     ),
//                                                                     Text(
//                                                                       DateFormat('yyyy-MM-dd').format(DateTime.parse(value
//                                                                           .travelList
//                                                                           .data!
//                                                                           .data![
//                                                                               index]
//                                                                           .approvalLog![
//                                                                               i]
//                                                                           .createdAt!)),
//                                                                       style: Theme.of(
//                                                                               context)
//                                                                           .textTheme
//                                                                           .bodyText1!
//                                                                           .copyWith(
//                                                                             fontSize:
//                                                                                 10,
//                                                                           ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 value
//                                                                             .travelList
//                                                                             .data!
//                                                                             .data![index]
//                                                                             .approvalLog!
//                                                                             .length ==
//                                                                         1
//                                                                     ? Container()
//                                                                     : Padding(
//                                                                         padding:
//                                                                             const EdgeInsets.only(
//                                                                           bottom:
//                                                                               20,
//                                                                         ),
//                                                                         child:
//                                                                             Container(
//                                                                           width:
//                                                                               37,
//                                                                           height:
//                                                                               4,
//                                                                           color:
//                                                                               Colors.grey,
//                                                                         ),
//                                                                       )
//                                                               ],
//                                                             ),
//                                                           // Padding(
//                                                           //       padding:
//                                                           //           const EdgeInsets
//                                                           //               .only(
//                                                           //         bottom: 20,
//                                                           //       ),
//                                                           //       child: Container(
//                                                           //         width: 37,
//                                                           //         height: 4,
//                                                           //         color: Colors.grey,
//                                                           //       ),
//                                                           //     ),
//                                                         ],
//                                                       ),
//                                                     ),

//                                               // SingleChildScrollView(
//                                               //   scrollDirection:
//                                               //       Axis.horizontal,
//                                               //   child: Row(
//                                               //     // mainAxisAlignment:
//                                               //     //     MainAxisAlignment.spaceBetween,
//                                               //     children: <Widget>[
//                                               //       Column(
//                                               //         children: [
//                                               //           Container(
//                                               //             width: 50,
//                                               //             height: 50,
//                                               //             decoration:
//                                               //                 BoxDecoration(
//                                               //               shape:
//                                               //                   BoxShape.circle,
//                                               //               border: Border.all(
//                                               //                 color:
//                                               //                     Colors.green,
//                                               //                 width: 3,
//                                               //               ),
//                                               //             ),
//                                               //             child: CircleAvatar(
//                                               //               radius: SizeVariables
//                                               //                       .getWidth(
//                                               //                           context) *
//                                               //                   0.04,
//                                               //               backgroundColor:
//                                               //                   Colors.green,
//                                               //               backgroundImage:
//                                               //                   const AssetImage(
//                                               //                 'assets/img/profilePic.jpg',
//                                               //               ),
//                                               //               // child: const Icon(Icons.account_box, color: Colors.white),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Container(
//                                               //             width: SizeVariables
//                                               //                     .getWidth(
//                                               //                         context) *
//                                               //                 0.1,
//                                               //             child: Text(
//                                               //               'Shaikh salim Akhtar',
//                                               //               overflow:
//                                               //                   TextOverflow
//                                               //                       .ellipsis,
//                                               //               style: Theme.of(
//                                               //                       context)
//                                               //                   .textTheme
//                                               //                   .bodyText1!
//                                               //                   .copyWith(
//                                               //                     fontSize: 10,
//                                               //                   ),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Text(
//                                               //             '2023-05-08',
//                                               //             style:
//                                               //                 Theme.of(context)
//                                               //                     .textTheme
//                                               //                     .bodyText1!
//                                               //                     .copyWith(
//                                               //                       fontSize:
//                                               //                           10,
//                                               //                     ),
//                                               //           ),
//                                               //         ],
//                                               //       ),
//                                               //       Padding(
//                                               //         padding:
//                                               //             const EdgeInsets.only(
//                                               //           bottom: 20,
//                                               //         ),
//                                               //         child: Container(
//                                               //           width: 37,
//                                               //           height: 4,
//                                               //           color: Colors.grey,
//                                               //         ),
//                                               //       ),
//                                               //       Column(
//                                               //         children: [
//                                               //           Container(
//                                               //             width: 50,
//                                               //             height: 50,
//                                               //             decoration:
//                                               //                 BoxDecoration(
//                                               //               shape:
//                                               //                   BoxShape.circle,
//                                               //               border: Border.all(
//                                               //                 color:
//                                               //                     Colors.amber,
//                                               //                 width: 3,
//                                               //               ),
//                                               //             ),
//                                               //             child: CircleAvatar(
//                                               //               radius: SizeVariables
//                                               //                       .getWidth(
//                                               //                           context) *
//                                               //                   0.01,
//                                               //               backgroundColor:
//                                               //                   Colors.green,
//                                               //               backgroundImage:
//                                               //                   const AssetImage(
//                                               //                 'assets/img/profilePic.jpg',
//                                               //               ),
//                                               //               // child: const Icon(Icons.account_box, color: Colors.white),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Container(
//                                               //             width: SizeVariables
//                                               //                     .getWidth(
//                                               //                         context) *
//                                               //                 0.1,
//                                               //             child: Text(
//                                               //               '..........................................',
//                                               //               overflow:
//                                               //                   TextOverflow
//                                               //                       .ellipsis,
//                                               //               style: Theme.of(
//                                               //                       context)
//                                               //                   .textTheme
//                                               //                   .bodyText1!
//                                               //                   .copyWith(
//                                               //                     fontSize: 10,
//                                               //                   ),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Text(
//                                               //             '--/--/--',
//                                               //             style:
//                                               //                 Theme.of(context)
//                                               //                     .textTheme
//                                               //                     .bodyText1!
//                                               //                     .copyWith(
//                                               //                       fontSize:
//                                               //                           10,
//                                               //                     ),
//                                               //           ),
//                                               //         ],
//                                               //       ),
//                                               //       Padding(
//                                               //         padding:
//                                               //             const EdgeInsets.only(
//                                               //           bottom: 20,
//                                               //         ),
//                                               //         child: Container(
//                                               //           width: 37,
//                                               //           height: 4,
//                                               //           color: Colors.grey,
//                                               //         ),
//                                               //       ),
//                                               //       Column(
//                                               //         children: [
//                                               //           Container(
//                                               //             width: 50,
//                                               //             height: 50,
//                                               //             decoration:
//                                               //                 BoxDecoration(
//                                               //               shape:
//                                               //                   BoxShape.circle,
//                                               //               border: Border.all(
//                                               //                 color:
//                                               //                     Colors.grey,
//                                               //                 width: 3,
//                                               //               ),
//                                               //             ),
//                                               //             child: CircleAvatar(
//                                               //               radius: SizeVariables
//                                               //                       .getWidth(
//                                               //                           context) *
//                                               //                   0.01,
//                                               //               backgroundColor:
//                                               //                   Colors.green,
//                                               //               backgroundImage:
//                                               //                   const AssetImage(
//                                               //                 'assets/img/profilePic.jpg',
//                                               //               ),
//                                               //               // child: const Icon(Icons.account_box, color: Colors.white),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Container(
//                                               //             width: SizeVariables
//                                               //                     .getWidth(
//                                               //                         context) *
//                                               //                 0.1,
//                                               //             child: Text(
//                                               //               '.....................',
//                                               //               overflow:
//                                               //                   TextOverflow
//                                               //                       .ellipsis,
//                                               //               style: Theme.of(
//                                               //                       context)
//                                               //                   .textTheme
//                                               //                   .bodyText1!
//                                               //                   .copyWith(
//                                               //                     fontSize: 10,
//                                               //                   ),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Text(
//                                               //             '--/--/--',
//                                               //             style:
//                                               //                 Theme.of(context)
//                                               //                     .textTheme
//                                               //                     .bodyText1!
//                                               //                     .copyWith(
//                                               //                       fontSize:
//                                               //                           10,
//                                               //                     ),
//                                               //           ),
//                                               //         ],
//                                               //       ),
//                                               //       Padding(
//                                               //         padding:
//                                               //             const EdgeInsets.only(
//                                               //           bottom: 20,
//                                               //         ),
//                                               //         child: Container(
//                                               //           width: 37,
//                                               //           height: 4,
//                                               //           color: Colors.grey,
//                                               //         ),
//                                               //       ),
//                                               //       Column(
//                                               //         children: [
//                                               //           Container(
//                                               //             width: 50,
//                                               //             height: 50,
//                                               //             decoration:
//                                               //                 BoxDecoration(
//                                               //               shape:
//                                               //                   BoxShape.circle,
//                                               //               border: Border.all(
//                                               //                 color:
//                                               //                     Colors.grey,
//                                               //                 width: 3,
//                                               //               ),
//                                               //             ),
//                                               //             child: CircleAvatar(
//                                               //               radius: SizeVariables
//                                               //                       .getWidth(
//                                               //                           context) *
//                                               //                   0.01,
//                                               //               backgroundColor:
//                                               //                   Colors.green,
//                                               //               backgroundImage:
//                                               //                   const AssetImage(
//                                               //                 'assets/img/profilePic.jpg',
//                                               //               ),
//                                               //               // child: const Icon(Icons.account_box, color: Colors.white),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Container(
//                                               //             width: SizeVariables
//                                               //                     .getWidth(
//                                               //                         context) *
//                                               //                 0.1,
//                                               //             child: Text(
//                                               //               '..................................',
//                                               //               overflow:
//                                               //                   TextOverflow
//                                               //                       .ellipsis,
//                                               //               style: Theme.of(
//                                               //                       context)
//                                               //                   .textTheme
//                                               //                   .bodyText1!
//                                               //                   .copyWith(
//                                               //                     fontSize: 10,
//                                               //                   ),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Text(
//                                               //             '--/--/--',
//                                               //             style:
//                                               //                 Theme.of(context)
//                                               //                     .textTheme
//                                               //                     .bodyText1!
//                                               //                     .copyWith(
//                                               //                       fontSize:
//                                               //                           10,
//                                               //                     ),
//                                               //           ),
//                                               //         ],
//                                               //       ),
//                                               //       Padding(
//                                               //         padding:
//                                               //             const EdgeInsets.only(
//                                               //           bottom: 20,
//                                               //         ),
//                                               //         child: Container(
//                                               //           width: 37,
//                                               //           height: 4,
//                                               //           color: Colors.grey,
//                                               //         ),
//                                               //       ),
//                                               //       Column(
//                                               //         children: [
//                                               //           Container(
//                                               //             width: 50,
//                                               //             height: 50,
//                                               //             decoration:
//                                               //                 BoxDecoration(
//                                               //               shape:
//                                               //                   BoxShape.circle,
//                                               //               border: Border.all(
//                                               //                 color:
//                                               //                     Colors.grey,
//                                               //                 width: 3,
//                                               //               ),
//                                               //             ),
//                                               //             child: CircleAvatar(
//                                               //               radius: SizeVariables
//                                               //                       .getWidth(
//                                               //                           context) *
//                                               //                   0.01,
//                                               //               backgroundColor:
//                                               //                   Colors.green,
//                                               //               backgroundImage:
//                                               //                   const AssetImage(
//                                               //                 'assets/img/profilePic.jpg',
//                                               //               ),
//                                               //               // child: const Icon(Icons.account_box, color: Colors.white),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Container(
//                                               //             width: SizeVariables
//                                               //                     .getWidth(
//                                               //                         context) *
//                                               //                 0.1,
//                                               //             child: Text(
//                                               //               '.................................',
//                                               //               overflow:
//                                               //                   TextOverflow
//                                               //                       .ellipsis,
//                                               //               style: Theme.of(
//                                               //                       context)
//                                               //                   .textTheme
//                                               //                   .bodyText1!
//                                               //                   .copyWith(
//                                               //                     fontSize: 10,
//                                               //                   ),
//                                               //             ),
//                                               //           ),
//                                               //           SizedBox(
//                                               //             height: SizeVariables
//                                               //                     .getHeight(
//                                               //                         context) *
//                                               //                 0.002,
//                                               //           ),
//                                               //           Text(
//                                               //             '--/--/--',
//                                               //             style:
//                                               //                 Theme.of(context)
//                                               //                     .textTheme
//                                               //                     .bodyText1!
//                                               //                     .copyWith(
//                                               //                       fontSize:
//                                               //                           10,
//                                               //                     ),
//                                               //           ),
//                                               //         ],
//                                               //       ),
//                                               //     ],
//                                               //   ),
//                                               // ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                       }
//                       return Container();
//                     })),
//               ),
//             ),
//             SizedBox(
//               height: SizeVariables.getHeight(context) * 0.002,
//             ),
//             SizedBox(
//               height: SizeVariables.getHeight(context) * 0.002,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _getApproval(DateTime start, DateTime end) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     String approval = localStorage.getString('approval').toString();
//     approval_status = approval;

//     if (kDebugMode) {
//       print("APPROVAL " + approval.toString());
//     }
//     Map data = {
//       "from_date": dateRange.start.toString().split(" ")[0].toString(),
//       "to_date": dateRange.end.toString().split(" ")[0].toString(),
//       "month": "",
//       "type": "",
//       "year": "",
//       "emp_id": _userid,
//       "all": "0", //manager
//       "status": approval.toString()
//     };

//     print('Manager Travel List Data: $data');

//     // _travelList.postTravelList(data, context);

//     Provider.of<TravelViewModel>(context, listen: false).postTravelList(data, context);
//   }

//   void openDialogBox() {
//     ClaimzHistoryViewModel searchUserData = ClaimzHistoryViewModel();
//     Map data = {
//       "keyword": "",
//     };
//     searchUserData.postSearchUser(context, data);
//     TextEditingController _searchUser = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color.fromARGB(255, 99, 97, 97),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Select Employee',
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ],
//         ),
//         content: Container(
//           // color: Colors.black,
//           height: SizeVariables.getHeight(context) * 0.58,
//           width: SizeVariables.getWidth(context) * 0.8,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: SizeVariables.getHeight(context) * 0.02,
//               ),
//               Container(
//                 child: TextField(
//                   onSubmitted: (value) {
//                     Map data = {
//                       "keyword": value.toString(),
//                     };
//                     searchUserData.postSearchUser(context, data);
//                   },
//                   textInputAction: TextInputAction.search,
//                   controller: _searchUser,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.search_outlined,
//                       color: Colors.grey,
//                     ),
//                     hintText: 'Search',
//                     hintStyle: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(color: Colors.grey),
//                     filled: true,
//                     fillColor: Color.fromARGB(255, 76, 75, 75),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   cursorColor: Colors.white,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ),
//               SizedBox(
//                 height: SizeVariables.getHeight(context) * 0.01,
//               ),
//               ChangeNotifierProvider<ClaimzHistoryViewModel>(
//                 create: (context) => searchUserData,
//                 child: Consumer<ClaimzHistoryViewModel>(
//                   builder: (context, value, child) {
//                     switch (value.searchUserRecord.status) {
//                       case Status.ERROR:
//                         return Center(
//                           child:
//                               Text(value.searchUserRecord.message.toString()),
//                         );
//                       // case Status.LOADING:
//                       //   return Center(child: CircularProgressIndicator());
//                       case Status.COMPLETED:
//                         return Container(
//                           height: SizeVariables.getHeight(context) * 0.43,
//                           width: SizeVariables.getWidth(context) * 0.6,
//                           // color: Colors.red,
//                           child: ListView(
//                             children: [
//                               Container(
//                                 height: 400,
//                                 // width: SizeVariables.getWidth(context) * 0.4,
//                                 // color: Colors.amber,
//                                 child: GridView.builder(
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisSpacing: 15,
//                                     mainAxisSpacing: 10,
//                                     crossAxisCount: 2,
//                                   ),
//                                   itemCount:
//                                       value.searchUserRecord.data!.data!.length,
//                                   itemBuilder: (context, index) =>
//                                       ContainerStyle(
//                                     height:
//                                         SizeVariables.getHeight(context) * 0.07,
//                                     child: Center(
//                                       child: InkWell(
//                                         onTap: () async {
//                                           SharedPreferences localStorage =
//                                               await SharedPreferences
//                                                   .getInstance();
//                                           String approval = localStorage
//                                               .getString('approval')
//                                               .toString();
//                                           _userid = value.searchUserRecord.data!
//                                               .data![index].id
//                                               .toString();

//                                           print("USER-ID>>> " +
//                                               _userid.toString());
//                                           setState(() {
//                                             Map data = {
//                                               "month": "",
//                                               "type": "",
//                                               "year": "",
//                                               "emp_id": _userid,
//                                               "all": "0", //manager
//                                               "status": approval
//                                             };

//                                             _travelList.postTravelList(
//                                                 data, context);
//                                           });

//                                           Navigator.pop(context);
//                                         },
//                                         child: Column(
//                                           children: [
//                                             SizedBox(
//                                               height: SizeVariables.getHeight(
//                                                       context) *
//                                                   0.01,
//                                             ),
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: value
//                                                               .searchUserRecord
//                                                               .data!
//                                                               .data![index]
//                                                               .profilePhoto ==
//                                                           '${AppUrl.baseUrl}/profile_photo/' ||
//                                                       value
//                                                               .searchUserRecord
//                                                               .data!
//                                                               .data![index]
//                                                               .profilePhoto ==
//                                                           null
//                                                   ? CircleAvatar(
//                                                       radius: SizeVariables
//                                                               .getWidth(
//                                                                   context) *
//                                                           0.07,
//                                                       backgroundColor:
//                                                           Colors.green,
//                                                       backgroundImage:
//                                                           const AssetImage(
//                                                               'assets/img/profilePic.jpg'),
//                                                       // child: const Icon(Icons.account_box, color: Colors.white),
//                                                     )
//                                                   : CachedNetworkImage(
//                                                       imageUrl: value
//                                                           .searchUserRecord
//                                                           .data!
//                                                           .data![index]
//                                                           .profilePhoto,
//                                                       imageBuilder: (context,
//                                                               imageProvider) =>
//                                                           Container(
//                                                         height: SizeVariables
//                                                                 .getHeight(
//                                                                     context) *
//                                                             0.07,
//                                                         width: SizeVariables
//                                                                 .getHeight(
//                                                                     context) *
//                                                             0.07,
//                                                         decoration: BoxDecoration(
//                                                             shape:
//                                                                 BoxShape.circle,
//                                                             image: DecorationImage(
//                                                                 image:
//                                                                     imageProvider,
//                                                                 fit: BoxFit
//                                                                     .contain)),
//                                                       ),
//                                                       placeholder: (context,
//                                                               url) =>
//                                                           Container(
//                                                               height: SizeVariables
//                                                                       .getHeight(
//                                                                           context) *
//                                                                   0.06,
//                                                               child: Shimmer
//                                                                   .fromColors(
//                                                                 baseColor:
//                                                                     Colors.grey[
//                                                                         400]!,
//                                                                 highlightColor:
//                                                                     const Color
//                                                                             .fromARGB(
//                                                                         255,
//                                                                         120,
//                                                                         120,
//                                                                         120),
//                                                                 child:
//                                                                     const CircleAvatar(
//                                                                   radius: 2,
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .green,
//                                                                   child: Center(
//                                                                     child: Icon(
//                                                                         Icons
//                                                                             .camera_alt_outlined,
//                                                                         color: Colors
//                                                                             .white,
//                                                                         size:
//                                                                             20),
//                                                                   ),
//                                                                 ),
//                                                               )),
//                                                     ),
//                                             ),
//                                             SizedBox(
//                                               height: SizeVariables.getHeight(
//                                                       context) *
//                                                   0.01,
//                                             ),
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: Text(
//                                                 value.searchUserRecord.data!
//                                                     .data![index].empName
//                                                     .toString(),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                         color: Colors.white),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                     }
//                     return Container();
//                   },
//                   // child: Container(),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                     right: SizeVariables.getWidth(context) * 0.05),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                       width: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future pickDateRange() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     DateTimeRange? newDateRange = await showDateRangePicker(
//         context: context,
//         saveText: 'SET',
//         builder: (context, child) => Theme(
//               data: ThemeData().copyWith(
//                 colorScheme: const ColorScheme.dark(
//                   primary: Color(0xffF59F23),
//                   surface: Colors.grey,
//                   onSurface: Colors.white,
//                 ),
//                 dialogBackgroundColor: const Color.fromARGB(255, 91, 91, 91),
//               ),
//               child: child!,
//             ),
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2100),
//         initialDateRange: dateRange);

//     if (newDateRange == null) return;

//     setState(() {
//       dateRange = newDateRange;
//       // print("START>>"+dateRange.start.toString());
//       // print("END>>"+dateRange.end.toString());

//       String approval = localStorage.getString('approval').toString();
//       Map data = {
//         "from_date": dateRange.start.toString().split(" ")[0].toString(),
//         "to_date": dateRange.end.toString().split(" ")[0].toString(),
//         "month": "",
//         "type": "",
//         "year": "",
//         "emp_id": _userid,
//         "all": "0", //manager
//         "status": approval.toString()
//       };
//       _travelList.postTravelList(data, context);
//     });
//     print('dateRange: $dateRange');
//     return dateRange;
//   }
// }
