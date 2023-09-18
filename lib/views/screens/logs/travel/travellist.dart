import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/viewModel/logsViewModel.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/travelClaimListShimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class TravelList extends StatefulWidget {
  // const TravelList({Key? key}) : super(key: key);

  @override
  State<TravelList> createState() => _TravelListState();
}

class _TravelListState extends State<TravelList> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );
  LogsViewModel _travelList = new LogsViewModel();
  int _selection = 0;
  String approval_status = "";

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
                        SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.4,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Travel Claim Logs',
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
                child: ChangeNotifierProvider<LogsViewModel>(
                    create: (BuildContext context) => _travelList,
                    child: Consumer<LogsViewModel>(
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
                                    Navigator.pushNamed(
                                        context, RouteNames.travelviewlog,
                                        arguments: {
                                          "status": approval_status,
                                          "all": "0",
                                          "doc": value.travelList!.data!
                                              .data![index]!.docNo
                                              .toString()
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.25,
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
                                                        // profile photo //////////////////////////////////
                                                        backgroundImage:
                                                            NetworkImage(value
                                                                .travelList!
                                                                .data!
                                                                .data![index]!
                                                                .profilePhoto
                                                                .toString()),
                                                        radius: 20,
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
                                                              //emp name /////////////////////////////
                                                              value
                                                                          .travelList!
                                                                          .data!
                                                                          .data![
                                                                              index]!
                                                                          .empName
                                                                          .toString()
                                                                          .length <=
                                                                      16
                                                                  ? value
                                                                      .travelList!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .empName
                                                                      .toString()
                                                                  : value
                                                                      .travelList!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .empName
                                                                      .toString()
                                                                      .replaceRange(
                                                                          16,
                                                                          value
                                                                              .travelList!
                                                                              .data!
                                                                              .data![index]!
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
                                                              // emp come //////////////////////////
                                                              value
                                                                  .travelList!
                                                                  .data!
                                                                  .data![index]!
                                                                  .empCode
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          10)
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
                                                      // ststus /////////////////////////////
                                                      value.travelList!.data!
                                                          .data![index]!.status
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
                                                            fontSize: 14,
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
                                                          // doc number ///////////////////////////
                                                          value
                                                              .travelList!
                                                              .data!
                                                              .data![index]!
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
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Container(
                                                      width: 180,
                                                      child: Text(
                                                        // purpose ////////////////////////////////
                                                        value
                                                                    .travelList!
                                                                    .data!
                                                                    .data![
                                                                        index]!
                                                                    .remarks
                                                                    .toString()
                                                                    .length <=
                                                                10
                                                            ? value
                                                                .travelList!
                                                                .data!
                                                                .data![index]!
                                                                .remarks
                                                                .toString()
                                                            : value
                                                                .travelList!
                                                                .data!
                                                                .data![index]!
                                                                .remarks
                                                                .toString()
                                                                .replaceRange(
                                                                    10,
                                                                    value
                                                                        .travelList!
                                                                        .data!
                                                                        .data![
                                                                            index]!
                                                                        .remarks
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
                                                      // date /////////////////////////
                                                      value
                                                          .travelList!
                                                          .data!
                                                          .data![index]!
                                                          .approvedAt
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
                                                      //amount ////////////////////////////
                                                      '\₹' +
                                                          value
                                                              .travelList!
                                                              .data!
                                                              .data![index]!
                                                              .sum
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 16,
                                                            color: Colors.amber,
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
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.green,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.04,
                                                            backgroundColor:
                                                                Colors.green,
                                                            backgroundImage:
                                                                const AssetImage(
                                                              'assets/img/profilePic.jpg',
                                                            ),
                                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.1,
                                                          child: Text(
                                                            'Shaikh salim Akhtar',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize: 10,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Text(
                                                          '2023-05-08',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Container(
                                                        width: 37,
                                                        height: 4,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.amber,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01,
                                                            backgroundColor:
                                                                Colors.green,
                                                            backgroundImage:
                                                                const AssetImage(
                                                              'assets/img/profilePic.jpg',
                                                            ),
                                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.1,
                                                          child: Text(
                                                            '..........................................',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize: 10,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Text(
                                                          '--/--/--',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Container(
                                                        width: 37,
                                                        height: 4,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01,
                                                            backgroundColor:
                                                                Colors.green,
                                                            backgroundImage:
                                                                const AssetImage(
                                                              'assets/img/profilePic.jpg',
                                                            ),
                                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.1,
                                                          child: Text(
                                                            '.....................',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize: 10,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Text(
                                                          '--/--/--',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Container(
                                                        width: 37,
                                                        height: 4,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01,
                                                            backgroundColor:
                                                                Colors.green,
                                                            backgroundImage:
                                                                const AssetImage(
                                                              'assets/img/profilePic.jpg',
                                                            ),
                                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.1,
                                                          child: Text(
                                                            '..................................',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize: 10,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Text(
                                                          '--/--/--',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Container(
                                                        width: 37,
                                                        height: 4,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01,
                                                            backgroundColor:
                                                                Colors.green,
                                                            backgroundImage:
                                                                const AssetImage(
                                                              'assets/img/profilePic.jpg',
                                                            ),
                                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Container(
                                                          width: SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.1,
                                                          child: Text(
                                                            '.................................',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize: 10,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.002,
                                                        ),
                                                        Text(
                                                          '--/--/--',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
      "status": "",
    };
    _travelList.postTravelLogslist(data);
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
      // print("START>>"+dateRange.start.toString());
      // print("END>>"+dateRange.end.toString());

      String approval = localStorage.getString('approval').toString();
      Map data = {
        "from_date": dateRange.start.toString().split(" ")[0].toString(),
        "to_date": dateRange.end.toString().split(" ")[0].toString(),
        "status": "",
      };

      _travelList.postTravelLogslist(data);
    });
    print('dateRange: $dateRange');

    return dateRange;
  }
}
