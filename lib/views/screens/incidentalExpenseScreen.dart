import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/userIncidentalViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../res/components/bottomNavigationBar.dart';
import '../../res/components/date_range_picker.dart';
import 'editIncidentalExpenseForm.dart';
import 'incidentalExpenseShimmer.dart';

class IncidentalExpenseScreen extends StatefulWidget {
  IncidentalExpenseScreenState createState() => IncidentalExpenseScreenState();
}

class IncidentalExpenseScreenState extends State<IncidentalExpenseScreen> {
  bool isLoading = true;
  bool pendingIncidental = true;
  bool fromUser = true;
  bool? isEditable;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<UserIncidentalViewModel>(context, listen: false)
        .getUserIncidental()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    // userIncidentalViewModel.getUserIncidental();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<UserIncidentalViewModel>(context).incidentalExpense;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final start = dateRange.start;
    final end = dateRange.end;

    // TODO: implement build

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   automaticallyImplyLeading: false,
      //   elevation: 1,
      //   title: Container(
      //     padding: EdgeInsets.only(
      //       top: SizeVariables.getHeight(context) * 0.008,
      //     ),
      //     child: Row(
      //       children: [
      //         InkWell(
      //           onTap: () {
      //             // Navigator.of(context).pushNamed(RouteNames.navbar);
      //             // Navigator.of(context).pop();
      //             Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) => CustomBottomNavigation(0)));
      //           },
      //           child: SvgPicture.asset(
      //             "assets/icons/back button.svg",
      //           ),
      //         ),
      //         SizedBox(width: SizeVariables.getWidth(context) * 0.02),
      //         Container(
      //           child: Text(
      //             'Incidental Expense',
      //             style: Theme.of(context).textTheme.caption,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.incidentalClaimsFormScreen);
        },
        backgroundColor: (themeProvider.darkTheme)
            ? Colors.grey
            : Theme.of(context).colorScheme.onPrimary,
        child: Icon(Icons.add,
            color: (themeProvider.darkTheme) ? Colors.white : Colors.black),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                // color: Colors.amber,
                width: SizeVariables.getWidth(context) * 0.8,
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pushNamed(RouteNames.navbar);
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CustomBottomNavigation(0)));
                          },
                          child: SvgPicture.asset(
                            "assets/icons/back button.svg",
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.01,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.33,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Incidental Expense',
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
              Container(
                width: double.infinity,
                height: SizeVariables.getHeight(context) * 0.9,
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.02,
                    top: SizeVariables.getHeight(context) * 0.02,
                    right: SizeVariables.getWidth(context) * 0.02),
                // color: Colors.red,
                child: isLoading
                    ? IncidentalExpenseShimmer()
                    // CircularProgressIndicator()
                    : provider['data'].isEmpty
                        ? Center(
                            child: Text('No Incidental Claims',
                                style: Theme.of(context).textTheme.bodyText1),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IncidentalClaimsEditScreen(
                                                  fromUser == true && provider['data'][index]['data_list']['status'] != 'Saved as Draft'
                                                      ? true
                                                      : false,
                                                  pendingIncidental,
                                                  provider['data'][index],
                                                  fromUser,
                                                  provider['data'][index]['data_list']
                                                      ['incedental_form_id'],
                                                  // provider['data'][index]['emp_id'],
                                                  provider['data'][index]
                                                      ['data_list']['user_id'],
                                                  provider['data'][index]
                                                      ['data_list']['claim_no'],
                                                  // provider['data'][index]['doc_no'],
                                                  provider['data'][index]['data_list']
                                                      ['service_provider'],
                                                  provider['data'][index]
                                                      ['data_list']['bill_no'],
                                                  provider['data'][index]
                                                      ['data_list']['gst_no'],
                                                  provider['data'][index]['data_list']
                                                      ['basic_amount'],
                                                  provider['data'][index]['data_list']
                                                      ['gst_amount'],
                                                  provider['data'][index]['data_list']
                                                      ['claim_amount'],
                                                  provider['data'][index]
                                                      ['data_list']['purpose'],
                                                  provider['data'][index]['data_list']
                                                          ['attachment'] ??
                                                      '',
                                                  '',
                                                  ''))),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        SizeVariables.getWidth(context) * 0.02),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 20, sigmaY: 20),
                                      child: Container(
                                        // color: Colors.amber,
                                        width: double.infinity,
                                        // height: 50,
                                        margin: EdgeInsets.only(
                                            bottom: SizeVariables.getHeight(
                                                    context) *
                                                0.01),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 181, 179, 179)
                                              .withOpacity(0.1),
                                          border: const Border(
                                              bottom: BorderSide(width: 0.06),
                                              top: BorderSide(width: 0.06),
                                              right: BorderSide(width: 0.06),
                                              left: BorderSide(width: 0.06)),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //       color: Color.fromARGB(255, 57, 57, 57),
                                          //       blurRadius: 15,
                                          //       spreadRadius: 1,
                                          //       offset: Offset(1, 2))
                                          // ]
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              width: double.infinity,
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.054,
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      height: double.infinity,
                                                      // color: Colors.red,
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.receipt,
                                                              size: 30,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      142,
                                                                      140,
                                                                      133)),
                                                          FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              provider['data'][
                                                                          index]
                                                                      [
                                                                      'data_list']
                                                                  ['claim_no'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          156,
                                                                          118,
                                                                          2)
                                                                      // color: const Color
                                                                      //         .fromARGB(
                                                                      //     255,
                                                                      //     208,
                                                                      //     204,
                                                                      //     204)
                                                                      ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      height: double.infinity,
                                                      // color: Colors.green,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              // DateFormat(
                                                              //         'dd-MMM-yyyy')
                                                              //     .format(DateTime
                                                              //         .parse(provider['data'][
                                                              //                 index]
                                                              //             ['date'])),
                                                              provider['data'][
                                                                          index]
                                                                      [
                                                                      'data_list']
                                                                  ['date'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              // color: Colors.red,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Purpose: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  Expanded(
                                                    child: Text(
                                                      provider['data'][index]
                                                              ['data_list']
                                                          ['purpose'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: const Color
                                                                .fromARGB(
                                                              255,
                                                              208,
                                                              204,
                                                              204,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      provider['data'][index][
                                                                      'data_list']
                                                                  ['status'] ==
                                                              999999
                                                          ? 'Rejected'
                                                          : provider['data']
                                                                      [index]
                                                                  ['data_list']
                                                              ['status'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: provider['data'][index]
                                                                              [
                                                                              'data_list']
                                                                          [
                                                                          'status'] ==
                                                                      999999
                                                                  ? Colors.red
                                                                  : provider['data'][index]['data_list']
                                                                              [
                                                                              'status'] ==
                                                                          'Saved as Draft'
                                                                      ? Colors
                                                                          .amber
                                                                      : Colors
                                                                          .green,
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.01),
                                            InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          IncidentalClaimsEditScreen(
                                                              fromUser == true && provider['data'][index]['data_list']['status'] != 'Saved as Draft'
                                                                  ? true
                                                                  : false,
                                                              pendingIncidental,
                                                              provider['data']
                                                                  [index],
                                                              fromUser,
                                                              provider['data'][index]
                                                                      ['data_list'][
                                                                  'incedental_form_id'],
                                                              provider['data']
                                                                          [index]
                                                                      ['data_list']
                                                                  ['user_id'],
                                                              provider['data']
                                                                          [index]
                                                                      ['data_list']
                                                                  ['claim_no'],
                                                              // provider[index]
                                                              //     ['doc_no'],
                                                              provider['data']
                                                                          [index]
                                                                      ['data_list']
                                                                  ['service_provider'],
                                                              provider['data'][index]['data_list']['bill_no'],
                                                              provider['data'][index]['data_list']['gst_no'],
                                                              provider['data'][index]['data_list']['basic_amount'],
                                                              provider['data'][index]['data_list']['gst_amount'],
                                                              provider['data'][index]['data_list']['claim_amount'],
                                                              provider['data'][index]['data_list']['purpose'],
                                                              provider['data'][index]['data_list']['attachment'] ?? '',
                                                              '',
                                                              ''))),
                                              child: Container(
                                                width: double.infinity,
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.04,

                                                // color: Colors.red,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        height: double.infinity,
                                                        // color: Colors.green,
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.info,
                                                                color: Colors
                                                                    .amber),
                                                            Text(provider['data'][index]
                                                                            [
                                                                            'data_list']
                                                                        [
                                                                        'status'] ==
                                                                    'Saved as Draft'
                                                                ? 'View/Edit Claim'
                                                                : 'View')
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
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            const Text('₹'),
                                                            Text(
                                                                '${provider['data'][index]['data_list']['claim_amount']}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .amber,
                                                                    fontSize:
                                                                        22)),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.01),

                                            Container(
                                              width: double.infinity,
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.1,
                                              // color: Colors.red,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          provider['data']
                                                                      [index][
                                                                  'approval_log']
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
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 3,
                                                                  ),
                                                                ),
                                                                child: provider['data'][index]['approval_log'][i]['profile_photo'] ==
                                                                            '' ||
                                                                        provider['data'][index]['approval_log'][i]['profile_photo'] ==
                                                                            null
                                                                    ? CircleAvatar(
                                                                        radius: SizeVariables.getWidth(context) *
                                                                            0.04,
                                                                        backgroundColor:
                                                                            Colors.green,
                                                                        backgroundImage:
                                                                            const AssetImage('assets/img/profilePic.jpg'),
                                                                        // child: const Icon(Icons.account_box, color: Colors.white),
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        imageUrl:
                                                                            provider['data'][index]['approval_log'][i]['profile_photo'],
                                                                        imageBuilder:
                                                                            (context, imageProvider) =>
                                                                                Container(
                                                                          height:
                                                                              SizeVariables.getHeight(context) * 0.08,
                                                                          width:
                                                                              SizeVariables.getHeight(context) * 0.08,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: imageProvider, fit: BoxFit.contain)),
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
                                                                provider['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'approval_log'][i]
                                                                    [
                                                                    'emp_name'],
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
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.002,
                                                            ),
                                                            Text(
                                                              DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(DateTime.parse(provider['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'approval_log'][i]
                                                                      [
                                                                      'created_at'])),
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
                                                        provider['data'][index][
                                                                        'approval_log']
                                                                    .length ==
                                                                1
                                                            ? Container()
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  bottom: 20,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 37,
                                                                  height: 4,
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
                                            ),

                                            // SingleChildScrollView(
                                            //   scrollDirection: Axis.horizontal,
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
                                            //                 color: Colors.green,
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
                                            //               provider['data']
                                            //                           [index][
                                            //                       'approval_log']
                                            //                   ['emp_name'],
                                            //               overflow: TextOverflow
                                            //                   .ellipsis,
                                            //               style:
                                            //                   Theme.of(context)
                                            //                       .textTheme
                                            //                       .bodyText1!
                                            //                       .copyWith(
                                            //                         fontSize:
                                            //                             10,
                                            //                       ),
                                            //             ),
                                            //           ),
                                            //           SizedBox(
                                            //             height: SizeVariables
                                            //                     .getHeight(
                                            //                         context) *
                                            //                 0.002,
                                            //           ),
                                            //           Text(
                                            //             DateFormat('yyyy-MM-dd')
                                            //                 .format(DateTime.parse(
                                            //                     provider['data']
                                            //                                 [
                                            //                                 index]
                                            //                             [
                                            //                             'approval_log']
                                            //                         [
                                            //                         'created_at'])),
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .bodyText1!
                                            //                 .copyWith(
                                            //                   fontSize: 10,
                                            //                 ),
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
                                            //                 color: Colors.amber,
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
                                            //               overflow: TextOverflow
                                            //                   .ellipsis,
                                            //               style:
                                            //                   Theme.of(context)
                                            //                       .textTheme
                                            //                       .bodyText1!
                                            //                       .copyWith(
                                            //                         fontSize:
                                            //                             10,
                                            //                       ),
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
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .bodyText1!
                                            //                 .copyWith(
                                            //                   fontSize: 10,
                                            //                 ),
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
                                            //                 color: Colors.grey,
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
                                            //               overflow: TextOverflow
                                            //                   .ellipsis,
                                            //               style:
                                            //                   Theme.of(context)
                                            //                       .textTheme
                                            //                       .bodyText1!
                                            //                       .copyWith(
                                            //                         fontSize:
                                            //                             10,
                                            //                       ),
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
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .bodyText1!
                                            //                 .copyWith(
                                            //                   fontSize: 10,
                                            //                 ),
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
                                            //                 color: Colors.grey,
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
                                            //               overflow: TextOverflow
                                            //                   .ellipsis,
                                            //               style:
                                            //                   Theme.of(context)
                                            //                       .textTheme
                                            //                       .bodyText1!
                                            //                       .copyWith(
                                            //                         fontSize:
                                            //                             10,
                                            //                       ),
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
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .bodyText1!
                                            //                 .copyWith(
                                            //                   fontSize: 10,
                                            //                 ),
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
                                            //                 color: Colors.grey,
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
                                            //               overflow: TextOverflow
                                            //                   .ellipsis,
                                            //               style:
                                            //                   Theme.of(context)
                                            //                       .textTheme
                                            //                       .bodyText1!
                                            //                       .copyWith(
                                            //                         fontSize:
                                            //                             10,
                                            //                       ),
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
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .bodyText1!
                                            //                 .copyWith(
                                            //                   fontSize: 10,
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
                            itemCount: provider['data'].length),
              ),
            ],
          ),
        ],
      ),
    );

    // return DefaultTabController(
    //   length: 3,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.black,
    //       automaticallyImplyLeading: false,
    //       elevation: 10,
    //       title: Container(
    //         padding: EdgeInsets.only(
    //           top: SizeVariables.getHeight(context) * 0.008,
    //         ),
    //         child: Row(
    //           children: [
    //             InkWell(
    //               onTap: () {
    //                 // Navigator.of(context).pushNamed(RouteNames.navbar);
    //                 Navigator.of(context).pop();
    //               },
    //               child: SvgPicture.asset(
    //                 "assets/icons/back button.svg",
    //               ),
    //             ),
    //             SizedBox(width: SizeVariables.getWidth(context) * 0.05),
    //             Container(
    //               padding: EdgeInsets.only(
    //                 left: SizeVariables.getWidth(context) * 0.01,
    //               ),
    //               child: Text(
    //                 'Incidental Expenses',
    //                 style: Theme.of(context).textTheme.caption,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       bottom: const TabBar(
    //         indicatorColor: Colors.amber,
    //         tabs: [
    //         Tab(text: 'Pending'),
    //         Tab(text: 'Approved'),
    //         Tab(text: 'Rejected'),
    //       ]),
    //     ),
    //     backgroundColor: Colors.black,
    //     body: isLoading ? const Center(
    //       child: CircularProgressIndicator(),
    //     ) : TabBarView(
    //       children: [
    // PendingIncidental(),
    //         ApprovedIncidental(),
    //         RejectedIncidental()
    //       ],
    //     ),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         Navigator.pushNamed(context, RouteNames.incidentalClaimsFormScreen);
    //       },
    //       backgroundColor: const Color(0xffF59F23),
    //       child: const Icon(Icons.add, color: Colors.white),
    //     ),
    //   ),
    // );
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
