import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:claimz/views/screens/travelClaimListShimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import '../../res/appUrl.dart';
import '../../res/components/containerStyle.dart';
import '../config/mediaQuery.dart';

class TravelClaimList extends StatefulWidget {
  // const TravelClaimList({Key? key}) : super(key: key);
  // Map<String, dynamic> args;
  // TravelClaimList(this.args);

  @override
  State<TravelClaimList> createState() => _TravelClaimListState();
}

class _TravelClaimListState extends State<TravelClaimList> {
  int _selection = 0;
  TravelViewModel _travelList = new TravelViewModel();

  Map args = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map data = {
      "month": "",
      "type": "",
      "year": "",
      "user_id": "",
      "all": "1" //self
    };
    _travelList.postTravellist(data, context);
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final start = dateRange.start;
    final end = dateRange.end;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CustomBottomNavigation(0)));
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: RippleAnimation(
          repeat: true,
          color: (themeProvider.darkTheme)
              ? Colors.grey
              : Theme.of(context).colorScheme.onPrimary,
          minRadius: 33,
          ripplesCount: 2,
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: (themeProvider.darkTheme) ? Colors.white : Colors.black,
            ),
            backgroundColor: (themeProvider.darkTheme)
                ? Colors.grey
                : Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              args.addAll({"doc": null, 'status': 'Submit'});
              Navigator.pushNamed(context, RouteNames.travelClaimsForm,
                  arguments: args);
            },
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          padding: EdgeInsets.only(
            left: SizeVariables.getWidth(context) * 0.025,
            right: SizeVariables.getWidth(context) * 0.025,
          ),
          child: ListView(
            children: [
              Container(
                // color: Colors.red,
                // height: SizeVariables.getHeight(context) * 0.07,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeVariables.getHeight(context) * 0.02),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CustomBottomNavigation(0)));
                            },
                            child: SvgPicture.asset(
                              "assets/icons/back button.svg",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: SizeVariables.getHeight(context) * 0.01,
                              left: SizeVariables.getWidth(context) * 0.01,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Travel Claim List',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: SizeVariables.getWidth(context) * 0.45,
                      // height: SizeVariables.getHeight(context) * 0.05,
                      child: DateRangePicker(
                        onPressed: pickDateRange,
                        end: end,
                        start: start,
                        // width: double.infinity,
                      ),
                    ),
                  ],
                ),
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
                          child: Text(
                            'All',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              _selection = 0;

                              Map data = {
                                "month": "",
                                "type": "",
                                "year": "",
                                "user_id": "",
                                "all": "1" //self
                              };

                              _travelList.postTravellist(data, context);
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
                                ? Colors.amberAccent
                                : Colors.white,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Domestic',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _selection = 1;
                              Map data = {
                                "month": "",
                                "type": "domestic",
                                "year": "",
                                "user_id": "",
                                "all": "1" //self
                              };
                              _travelList.postTravellist(data, context);
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
                                ? Colors.amberAccent
                                : Colors.white,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'International',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _selection = 2;
                              Map data = {
                                "month": "",
                                "type": "international",
                                "year": "",
                                "user_id": "",
                                "all": "1" //self
                              };
                              _travelList.postTravellist(data, context);
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                      color: (themeProvider.darkTheme)
                          ? Colors.black
                          : Theme.of(context).scaffoldBackgroundColor),
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
                            return TravellistShimmer();
                          // CircularProgressIndicator();
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
                                // height: double.infinity,
                                height: SizeVariables.getHeight(context) * 0.82,
                                child: ListView.builder(
                                  itemCount:
                                      value.travelList.data!.data!.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      args.addAll({
                                        "doc": value.travelList!.data!
                                            .data![index].dataList!.docNo
                                            .toString(),
                                        "all": "1",
                                        'status': value.travelList.data!
                                            .data![index].dataList!.status
                                            .toString()
                                      });
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, RouteNames.travelClaimsForm,
                                          arguments: args);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            SizeVariables.getHeight(context) *
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
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: SizeVariables.getWidth(
                                                    context) *
                                                0.03,
                                          ),
                                          child: ContainerStyle(
                                            //Reinstate this height when approval API comes

                                            height: height > 750
                                                ? 30.h
                                                : height < 650
                                                    ? 33.h
                                                    : 31.h,
                                            // height: height > 750
                                            //     ? 22.h
                                            //     : height < 650
                                            //         ? 25.h
                                            //         : 23.h,
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
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            value // profile photo
                                                                            .travelList!
                                                                            .data!
                                                                            .data![
                                                                                index]!
                                                                            .dataList!
                                                                            .profilePhoto ==
                                                                        '${AppUrl.baseUrl}/profile_photo/' ||
                                                                    value
                                                                            .travelList!
                                                                            .data!
                                                                            .data![index]
                                                                            .dataList!
                                                                            .profilePhoto ==
                                                                        null
                                                                ? CircleAvatar(
                                                                    radius: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.07,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    backgroundImage:
                                                                        const AssetImage(
                                                                            'assets/img/profilePic.jpg'),
                                                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                                                  )
                                                                : CachedNetworkImage(
                                                                    imageUrl: value
                                                                        .travelList!
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .dataList!
                                                                        .profilePhoto
                                                                        .toString(),
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.05,
                                                                      width: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.05,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.contain),
                                                                      ),
                                                                    ),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Container(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.05,
                                                                      child: Shimmer
                                                                          .fromColors(
                                                                        baseColor:
                                                                            Colors.grey[400]!,
                                                                        highlightColor:
                                                                            const Color.fromARGB(
                                                                          255,
                                                                          120,
                                                                          120,
                                                                          120,
                                                                        ),
                                                                        child:
                                                                            const CircleAvatar(
                                                                          radius:
                                                                              2,
                                                                          backgroundColor:
                                                                              Colors.green,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.camera_alt_outlined,
                                                                              color: Colors.white,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                  // emp name
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Text(
                                                                    value.travelList!.data!.data![index].dataList!.empName!.length <=
                                                                            20
                                                                        ? value
                                                                            .travelList!
                                                                            .data!
                                                                            .data![
                                                                                index]
                                                                            .dataList!
                                                                            .empName
                                                                            .toString()
                                                                        : value
                                                                            .travelList!
                                                                            .data!
                                                                            .data![index]
                                                                            .dataList!
                                                                            .empName
                                                                            .toString()
                                                                            .replaceRange(
                                                                              20,
                                                                              value.travelList!.data!.data![index].dataList!.empName!.length,
                                                                              "..",
                                                                            ),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                  ),
                                                                ),
                                                                FittedBox(
                                                                  // emp code
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Text(
                                                                    value
                                                                        .travelList!
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .dataList!
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
                                                                              FontStyle.italic,
                                                                          color:
                                                                              Colors.amber,
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
                                                            // status
                                                            value
                                                                .travelList!
                                                                .data!
                                                                .data![index]
                                                                .dataList!
                                                                .status
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
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
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.015,
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
                                                          ),
                                                          SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01,
                                                          ),
                                                          FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              // document number
                                                              value
                                                                  .travelList!
                                                                  .data!
                                                                  .data![index]
                                                                  .dataList!
                                                                  .docNo
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .amber,
                                                                      fontSize:
                                                                          9.sp),
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
                                                            // no of clamiz
                                                            value
                                                                .travelList!
                                                                .data!
                                                                .data![index]
                                                                .dataList!
                                                                .noOfClaim
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.015,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Purpose:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                      SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.01,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Container(
                                                          // color: Colors.yellow,
                                                          width: 180,
                                                          child: Text(
                                                            // purpose
                                                            value
                                                                        .travelList!
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .dataList!
                                                                        .purpose
                                                                        .toString()
                                                                        .length <=
                                                                    25
                                                                ? value
                                                                    .travelList!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .dataList!
                                                                    .purpose
                                                                    .toString()
                                                                : value
                                                                    .travelList!
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .dataList!
                                                                    .purpose
                                                                    .toString()
                                                                    .replaceRange(
                                                                        25,
                                                                        value
                                                                            .travelList!
                                                                            .data!
                                                                            .data![index]
                                                                            .dataList!
                                                                            .purpose
                                                                            .toString()
                                                                            .length,
                                                                        "..."),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize:
                                                                      10.sp,
                                                                )
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.015,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          // date
                                                          value
                                                              .travelList!
                                                              .data!
                                                              .data![index]
                                                              .dataList!
                                                              .date
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          //amount
                                                          '\₹' +
                                                              value
                                                                  .travelList!
                                                                  .data!
                                                                  .data![index]
                                                                  .dataList!
                                                                  .amount
                                                                  .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .amber),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.015,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.1,
                                                    // color: Colors.red,
                                                    child: ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                // provider['data']
                                                                //             [index][
                                                                //         'approval_log']
                                                                //     .length;
                                                                value
                                                                    .travelList!
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
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.green,
                                                                          width:
                                                                              3,
                                                                        ),
                                                                      ),
                                                                      child: value.travelList!.data!.data![index].approvalLog![i].profilePhoto == '' ||
                                                                              value.travelList!.data!.data![index].approvalLog![i].profilePhoto == null
                                                                          // provider['data']['photo'] == ''
                                                                          ? CircleAvatar(
                                                                              radius: SizeVariables.getWidth(context) * 0.04,
                                                                              backgroundColor: Colors.green,
                                                                              backgroundImage: const AssetImage('assets/img/profilePic.jpg'),
                                                                              // child: const Icon(Icons.account_box, color: Colors.white),
                                                                            )
                                                                          : CachedNetworkImage(
                                                                              imageUrl: value.travelList!.data!.data![index].approvalLog![i].profilePhoto.toString(),
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
                                                                    child: Text(
                                                                      // provider['data']
                                                                      //             [
                                                                      //             index]
                                                                      //         [
                                                                      //         'approval_log'][i]
                                                                      //     [
                                                                      //     'emp_name'],
                                                                      value
                                                                          .travelList!
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .approvalLog![
                                                                              i]
                                                                          .empName
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                            fontSize:
                                                                                10,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: SizeVariables.getHeight(
                                                                            context) *
                                                                        0.002,
                                                                  ),
                                                                  Text(
                                                                    DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                                                        value
                                                                            .travelList!
                                                                            .data!
                                                                            .data![index]
                                                                            .approvalLog![i]
                                                                            .createdAt
                                                                            .toString()

                                                                        // provider['data']
                                                                        //           [
                                                                        //           index]
                                                                        //       [
                                                                        //       'approval_log'][i]
                                                                        //   [
                                                                        //   'created_at']
                                                                        )),
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
                                                              // provider['data'][index][
                                                              //                 'approval_log']
                                                              //             .length ==
                                                              //         1

                                                              value
                                                                          .travelList!
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .approvalLog!
                                                                          .length ==
                                                                      1
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        bottom:
                                                                            20,
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            37,
                                                                        height:
                                                                            4,
                                                                        color: Colors
                                                                            .grey,
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
                                                  )

                                                  //Reinstate the below snippet with API changes when it comes

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
                                                  //               shape: BoxShape
                                                  //                   .circle,
                                                  //               border:
                                                  //                   Border.all(
                                                  //                 color: Colors
                                                  //                     .green,
                                                  //                 width: 3,
                                                  //               ),
                                                  //             ),
                                                  //             child:
                                                  //                 CircleAvatar(
                                                  //               radius: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.04,
                                                  //               backgroundColor:
                                                  //                   Colors
                                                  //                       .green,
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
                                                  //                     fontSize:
                                                  //                         10,
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
                                                  //             style: Theme.of(
                                                  //                     context)
                                                  //                 .textTheme
                                                  //                 .bodyText1!
                                                  //                 .copyWith(
                                                  //                   fontSize:
                                                  //                       10,
                                                  //                 ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //       Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .only(
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
                                                  //               shape: BoxShape
                                                  //                   .circle,
                                                  //               border:
                                                  //                   Border.all(
                                                  //                 color: Colors
                                                  //                     .amber,
                                                  //                 width: 3,
                                                  //               ),
                                                  //             ),
                                                  //             child:
                                                  //                 CircleAvatar(
                                                  //               radius: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.01,
                                                  //               backgroundColor:
                                                  //                   Colors
                                                  //                       .green,
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
                                                  //                     fontSize:
                                                  //                         10,
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
                                                  //             style: Theme.of(
                                                  //                     context)
                                                  //                 .textTheme
                                                  //                 .bodyText1!
                                                  //                 .copyWith(
                                                  //                   fontSize:
                                                  //                       10,
                                                  //                 ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //       Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .only(
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
                                                  //               shape: BoxShape
                                                  //                   .circle,
                                                  //               border:
                                                  //                   Border.all(
                                                  //                 color: Colors
                                                  //                     .grey,
                                                  //                 width: 3,
                                                  //               ),
                                                  //             ),
                                                  //             child:
                                                  //                 CircleAvatar(
                                                  //               radius: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.01,
                                                  //               backgroundColor:
                                                  //                   Colors
                                                  //                       .green,
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
                                                  //                     fontSize:
                                                  //                         10,
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
                                                  //             style: Theme.of(
                                                  //                     context)
                                                  //                 .textTheme
                                                  //                 .bodyText1!
                                                  //                 .copyWith(
                                                  //                   fontSize:
                                                  //                       10,
                                                  //                 ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //       Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .only(
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
                                                  //               shape: BoxShape
                                                  //                   .circle,
                                                  //               border:
                                                  //                   Border.all(
                                                  //                 color: Colors
                                                  //                     .grey,
                                                  //                 width: 3,
                                                  //               ),
                                                  //             ),
                                                  //             child:
                                                  //                 CircleAvatar(
                                                  //               radius: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.01,
                                                  //               backgroundColor:
                                                  //                   Colors
                                                  //                       .green,
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
                                                  //                     fontSize:
                                                  //                         10,
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
                                                  //             style: Theme.of(
                                                  //                     context)
                                                  //                 .textTheme
                                                  //                 .bodyText1!
                                                  //                 .copyWith(
                                                  //                   fontSize:
                                                  //                       10,
                                                  //                 ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //       Padding(
                                                  //         padding:
                                                  //             const EdgeInsets
                                                  //                 .only(
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
                                                  //               shape: BoxShape
                                                  //                   .circle,
                                                  //               border:
                                                  //                   Border.all(
                                                  //                 color: Colors
                                                  //                     .grey,
                                                  //                 width: 3,
                                                  //               ),
                                                  //             ),
                                                  //             child:
                                                  //                 CircleAvatar(
                                                  //               radius: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.01,
                                                  //               backgroundColor:
                                                  //                   Colors
                                                  //                       .green,
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
                                                  //                     fontSize:
                                                  //                         10,
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
                                                  //             style: Theme.of(
                                                  //                     context)
                                                  //                 .textTheme
                                                  //                 .bodyText1!
                                                  //                 .copyWith(
                                                  //                   fontSize:
                                                  //                       10,
                                                  //                 ),
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
      ),
    );
  }

  Future pickDateRange() async {
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
      // isLoading = true;
    });

    print('dateRange: $dateRange');
    return dateRange;
  }
}
