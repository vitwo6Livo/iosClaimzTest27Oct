import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/allClaimViewModel.dart';
import 'package:claimz/views/screens/editIncidentalExpenseForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_provider.dart';
import '../../res/components/containerStyle.dart';
import '../../res/components/date_range_picker.dart';
import '../config/mediaQuery.dart';
import 'claimzHistory/convenyanceClaimFrom.dart';

class Claimzsummary_all_Screen extends StatefulWidget {
  @override
  State<Claimzsummary_all_Screen> createState() =>
      _Claimzsummary_all_ScreenState();
}

class _Claimzsummary_all_ScreenState extends State<Claimzsummary_all_Screen> {
  int _selection = 0;
  AllClaimViewModel _claimList = new AllClaimViewModel();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  String _type = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map data = {
      "status": "",
      "status_name": "",
      "type": _type,
    };
    _claimList.postClaimlist(data);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final start = dateRange.start;
    final end = dateRange.end;
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
              // color: Colors.red,
              // height: SizeVariables.getHeight(context) * 0.07,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.02),
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
                            'All Claims',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ],
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
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'All',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _selection = 0;
                              _type = "";
                              Map data = {
                                "status": "",
                                "status_name": "",
                                "type": _type,
                              };
                              _claimList.postClaimlist(data);
                            },
                          );
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
                            'Travel',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 1;
                            _type = "travel";
                            Map data = {
                              "status": "",
                              "status_name": "",
                              "type": _type,
                            };
                            _claimList.postClaimlist(data);
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
                        child: Container(
                          // width: SizeVariables.getWidth(context)*0.35,

                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Conveyance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 2;
                            _type = "conveyance";
                            Map data = {
                              "status": "",
                              "status_name": "",
                              "type": _type,
                            };
                            _claimList.postClaimlist(data);
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
                          primary: _selection == 3
                              ? Colors.amberAccent
                              : Colors.white,
                        ),
                        child: Container(
                          // width: SizeVariables.getWidth(context)*0.3,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Incidental',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 3;
                            _type = "incidental";
                            Map data = {
                              "status": "",
                              "status_name": "",
                              "type": _type,
                            };
                            _claimList.postClaimlist(data);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ChangeNotifierProvider<AllClaimViewModel>(
              create: (context) => _claimList,
              child: Consumer<AllClaimViewModel>(
                builder: (context, value, child) {
                  switch (value.allclaimzList.status) {
                    case Status.ERROR:
                      return Center(
                        child: Text(value.allclaimzList.message.toString()),
                      );
                    // case Status.LOADING:
                    //   return Center(child: CircularProgressIndicator());
                    case Status.COMPLETED:
                      if (value.allclaimzList.data!.data!.isEmpty) {
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
                          // color: Colors.green,
                          height: SizeVariables.getHeight(context) * 0.82,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: value.allclaimzList.data!.data!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                if (value.allclaimzList!.data!.data![index]!
                                        .claimType
                                        .toString()
                                        .toLowerCase() ==
                                    "travel") {
                                  Map args = {};
                                  args.addAll({
                                    "doc": value.allclaimzList!.data!
                                        .data![index]!.docNo
                                        .toString(),
                                    "all": "1",
                                  });
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, RouteNames.travelClaimsForm,
                                      arguments: args);
                                } else if (value.allclaimzList!.data!
                                        .data![index]!.claimType
                                        .toString()
                                        .toLowerCase() ==
                                    "incidental") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          IncidentalClaimsEditScreen(
                                              value
                                                          .allclaimzList!
                                                          .data!
                                                          .data![index]!
                                                          .status !=
                                                      'Saved as Draft'
                                                  ? true
                                                  : false,
                                              true,
                                              value.allclaimzList!.data!
                                                  .data![index]
                                                  .toJson(),
                                              true,
                                              value
                                                  .allclaimzList!
                                                  .data!
                                                  .data![index]
                                                  .incedental_form_id,
                                              // provider['data'][index]['emp_id'],
                                              value.allclaimzList!.data!
                                                  .data![index].userId,
                                              value.allclaimzList!.data!
                                                  .data![index].docNo,
                                              // provider['data'][index]['doc_no'],
                                              value
                                                  .allclaimzList!
                                                  .data!
                                                  .data![index]
                                                  .service_provider,
                                              value.allclaimzList!.data!
                                                  .data![index].bill_no,
                                              value.allclaimzList!.data!
                                                  .data![index].gst_no,
                                              value.allclaimzList!.data!
                                                  .data![index].basic_amount,
                                              value.allclaimzList!.data!
                                                  .data![index].gst_amount,
                                              value.allclaimzList!.data!
                                                  .data![index].claim_amount,
                                              value.allclaimzList!.data!
                                                  .data![index].purpose,
                                              value.allclaimzList!.data!
                                                  .data![index].attachment,
                                              '',
                                              '')));
                                } else {
                                  Map<String, dynamic> data = {
                                    "doc_no": value
                                        .allclaimzList.data!.data![index].docNo
                                        .toString(),
                                    "from": value.allclaimzList.data!
                                        .data![index].tStartOriginAddress
                                        .toString(),
                                    "date": value.allclaimzList.data!
                                        .data![index].travelStartDate
                                        .toString(),
                                    "to": value.allclaimzList.data!.data![index]
                                        .tEndOriginAddress
                                        .toString(),
                                    'flag': 0,
                                    'remarks': value.allclaimzList.data!
                                        .data![index].remarks
                                        .toString(),
                                    'status': value
                                        .allclaimzList.data!.data![index].status
                                  };
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ConvenyanceClaimFrom(
                                              data, {}, {}, true)));
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      SizeVariables.getHeight(context) * 0.02,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            ? 30.h
                                            : 28.h,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.04,
                                        right: SizeVariables.getWidth(context) *
                                            0.04,
                                        top: SizeVariables.getHeight(context) *
                                            0.015,
                                        bottom:
                                            SizeVariables.getHeight(context) *
                                                0.015,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      // profile image////////////////////
                                                      value
                                                          .allclaimzList!
                                                          .data!
                                                          .data![index]!
                                                          .profilePhoto
                                                          .toString(),
                                                    ),
                                                    radius: 20,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
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
                                                          //emp name //////////////////////////
                                                          value
                                                                      .allclaimzList!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .empName
                                                                      .toString()
                                                                      .length <=
                                                                  16
                                                              ? value
                                                                  .allclaimzList!
                                                                  .data!
                                                                  .data![index]!
                                                                  .empName
                                                                  .toString()
                                                              : value
                                                                  .allclaimzList!
                                                                  .data!
                                                                  .data![index]!
                                                                  .empName
                                                                  .toString()
                                                                  .replaceRange(
                                                                      16,
                                                                      value
                                                                          .allclaimzList!
                                                                          .data!
                                                                          .data![
                                                                              index]!
                                                                          .empName
                                                                          .toString()
                                                                          .length,
                                                                      ".."),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          //emp code ////////////////////////////
                                                          value
                                                              .allclaimzList!
                                                              .data!
                                                              .data![index]!
                                                              .empCode
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
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
                                                  //ststus//////////////////
                                                  value.allclaimzList!.data!
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
                                                0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.message,
                                                    color: Colors.amber,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.008,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      // doc number//////////////////////
                                                      value.allclaimzList!.data!
                                                          .data![index]!.docNo
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.amber,
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.grey,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  radius: 11,
                                                  child: Text(
                                                    //no of claim///////////////////
                                                    value.allclaimzList!.data!
                                                        .data![index]!.noOfClaim
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                          color: Colors.white,
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
                                                0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Purpose:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.008,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Container(
                                                      width: 180,
                                                      child: Text(
                                                        // purpose//////////////////////////////
                                                        value
                                                                    .allclaimzList!
                                                                    .data!
                                                                    .data![
                                                                        index]!
                                                                    .purpose
                                                                    .toString() ==
                                                                "null"
                                                            ? "no purpose provided.."
                                                            : value
                                                                        .allclaimzList!
                                                                        .data!
                                                                        .data![
                                                                            index]!
                                                                        .purpose
                                                                        .toString()
                                                                        .length <=
                                                                    25
                                                                ? value
                                                                    .allclaimzList!
                                                                    .data!
                                                                    .data![
                                                                        index]!
                                                                    .purpose
                                                                    .toString()
                                                                : value
                                                                    .allclaimzList!
                                                                    .data!
                                                                    .data![
                                                                        index]!
                                                                    .purpose
                                                                    .toString()
                                                                    .replaceRange(
                                                                        25,
                                                                        value
                                                                            .allclaimzList!
                                                                            .data!
                                                                            .data![index]!
                                                                            .purpose
                                                                            .toString()
                                                                            .length,
                                                                        "..."),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 12,
                                                            )
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
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5.0,
                                                  ),
                                                  color: const Color.fromARGB(
                                                    255,
                                                    70,
                                                    70,
                                                    70,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                    top: 2.5,
                                                    bottom: 2.5,
                                                  ),
                                                  child: Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        //type of claim////////////////////
                                                        value
                                                            .allclaimzList!
                                                            .data!
                                                            .data![index]!
                                                            .claimType
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  233,
                                                                  231,
                                                                  231),
                                                              fontSize: 12,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  // date/////////////////////
                                                  value.allclaimzList!.data!
                                                      .data![index]!.date
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  //amount////////////////////
                                                  '\₹' +
                                                      value.allclaimzList!.data!
                                                          .data![index]!.amount
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontSize: 17,
                                                        color: Colors.amber,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.01,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.green,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 10,
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.amber,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 10,
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.grey,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 10,
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.grey,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 10,
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.grey,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 10,
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
                },
                // child: Container(),
              ),
            ),
            // Container(
            //   // height: double.infinity,
            //   height: SizeVariables.getHeight(context) * 0.82,
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (context, index) => Padding(
            //       padding: EdgeInsets.only(
            //         bottom: SizeVariables.getHeight(context)*0.02
            //       ),
            //       child: Container(
            //         decoration: BoxDecoration(
            //           boxShadow: (themeProvider.darkTheme)
            //               ? []
            //               : [
            //                   BoxShadow(
            //                     color: Colors.grey.withOpacity(0.5),
            //                     spreadRadius: 0,
            //                     blurRadius: 7,
            //                     //offset: Offset(0, 3), // changes position of shadow
            //                   ),
            //                 ],
            //         ),
            //         child: Padding(
            //           padding: EdgeInsets.only(
            //             right: SizeVariables.getWidth(context) * 0.03,
            //           ),
            //           child: ContainerStyle(
            //             height: height > 750
            //                 ? 16.h
            //                 : height < 650
            //                     ? 20.h
            //                     : 17.h,
            //             child: Padding(
            //               padding:
            //                   const EdgeInsets.only(bottom: 8.0, right: 8.0),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   Container(
            //                     padding: EdgeInsets.all(8),
            //                     child: Column(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceEvenly,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Padding(
            //                           padding: EdgeInsets.only(
            //                             top: SizeVariables.getHeight(context) *
            //                                 0,
            //                           ),
            //                           child: FittedBox(
            //                             fit: BoxFit.contain,
            //                             child: Container(
            //                               // color: Colors.yellow,
            //                               width: 180,
            //                               child: Text(
            //                                 'Test',
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .bodyText1!
            //                                     .copyWith(fontSize: 10.sp)
            //                                     .copyWith(
            //                                         fontWeight:
            //                                             FontWeight.bold),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           // color: Colors.red,
            //                           child: FittedBox(
            //                             fit: BoxFit.contain,
            //                             child: Text(
            //                               'Tue,22nd Nov 2022',
            //                               style: Theme.of(context)
            //                                   .textTheme
            //                                   .bodyText1!
            //                                   .copyWith(fontSize: 9.sp),
            //                             ),
            //                           ),
            //                         ),
            //                         Container(
            //                           // color: Colors.blue,
            //                           child: Row(
            //                             children: [
            //                               Container(
            //                                 decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(5.0),
            //                                   color: const Color(0xff2c2c2c),
            //                                 ),
            //                                 child: Padding(
            //                                   padding:
            //                                       const EdgeInsets.all(5.0),
            //                                   child: Center(
            //                                     child: FittedBox(
            //                                       fit: BoxFit.contain,
            //                                       child: Text(
            //                                         '1266789356',
            //                                         style: Theme.of(context)
            //                                             .textTheme
            //                                             .bodyText1!
            //                                             .copyWith(
            //                                                 color: Colors.amber,
            //                                                 fontSize: 9.sp),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               SizedBox(
            //                                 width: 5,
            //                               ),
            //                               Container(
            //                                 decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(5.0),
            //                                   color: Color.fromARGB(
            //                                       255, 103, 122, 114),
            //                                 ),
            //                                 child: Padding(
            //                                   padding: const EdgeInsets.only(
            //                                       left: 5.0,
            //                                       right: 5.0,
            //                                       top: 2.5,
            //                                       bottom: 2.5),
            //                                   child: Center(
            //                                     child: FittedBox(
            //                                       fit: BoxFit.contain,
            //                                       child: Text(
            //                                         "Pending for Approval",
            //                                         style: Theme.of(context)
            //                                             .textTheme
            //                                             .bodyText1!
            //                                             .copyWith(
            //                                                 color:
            //                                                     Color.fromARGB(
            //                                                         255,
            //                                                         109,
            //                                                         247,
            //                                                         143),
            //                                                 fontSize: 12),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         Container(
            //                           decoration: BoxDecoration(
            //                             borderRadius:
            //                                 BorderRadius.circular(5.0),
            //                             color: Color.fromARGB(255, 70, 70, 70),
            //                           ),
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(
            //                                 left: 5.0,
            //                                 right: 5.0,
            //                                 top: 2.5,
            //                                 bottom: 2.5),
            //                             child: Center(
            //                               child: FittedBox(
            //                                 fit: BoxFit.contain,
            //                                 child: Text(
            //                                   "Travel",
            //                                   style: Theme.of(context)
            //                                       .textTheme
            //                                       .bodyText1!
            //                                       .copyWith(
            //                                           color: Color.fromARGB(
            //                                               255, 233, 231, 231),
            //                                           fontSize: 12),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   Container(
            //                     padding: EdgeInsets.all(8),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         SizedBox(
            //                           height: SizeVariables.getHeight(context) *
            //                               0.010,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   //right side design
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.end,
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceEvenly,
            //                     children: [
            //                       FittedBox(
            //                         fit: BoxFit.contain,
            //                         child: Text(
            //                           '\₹' + '200',
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .bodyText1!
            //                               .copyWith(
            //                                   fontSize: 16,
            //                                   color: Colors.amber),
            //                         ),
            //                       ),
            //                       CircleAvatar(
            //                         radius: 12,
            //                         backgroundColor: Colors.grey,
            //                         child: CircleAvatar(
            //                           backgroundColor: Colors.black,
            //                           radius: 11,
            //                           child: Text(
            //                             '2',
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .bodyText2!
            //                                 .copyWith(
            //                                     color: Colors.white,
            //                                     fontSize: 13),
            //                           ),
            //                         ),
            //                       ),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               FittedBox(
            //                                 fit: BoxFit.contain,
            //                                 child: Text(
            //                                   'Joy Shil',
            //                                   style: Theme.of(context)
            //                                       .textTheme
            //                                       .bodyText1!
            //                                       .copyWith(
            //                                           fontSize: 10,
            //                                           color: Colors.grey),
            //                                 ),
            //                               ),
            //                               FittedBox(
            //                                 fit: BoxFit.contain,
            //                                 child: Text(
            //                                   'EMP093',
            //                                   style: Theme.of(context)
            //                                       .textTheme
            //                                       .bodyText1!
            //                                       .copyWith(fontSize: 10)
            //                                       .copyWith(
            //                                           fontStyle:
            //                                               FontStyle.italic,
            //                                           color: Colors.amber),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           SizedBox(
            //                             width: 5,
            //                           ),
            //                           CircleAvatar(
            //                             radius:
            //                                 SizeVariables.getWidth(context) *
            //                                     0.05,
            //                             backgroundColor: Colors.green,
            //                             backgroundImage: const AssetImage(
            //                                 'assets/img/profilePic.jpg'),
            //                             // child: const Icon(Icons.account_box, color: Colors.white),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
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
