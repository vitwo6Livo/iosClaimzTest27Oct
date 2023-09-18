import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/managerIncidentalScreen/pendingmanagerIncidents.dart';
import 'package:claimz/views/screens/managerIncidentalScreen/rejectedManagerIncidents.dart';
import 'package:claimz/views/widgets/incidentalExpenseWidget/approvedIncidental.dart';
import 'package:claimz/views/widgets/incidentalExpenseWidget/pendingIncidental.dart';
import 'package:claimz/views/widgets/incidentalExpenseWidget/rejectedIncidental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../res/appUrl.dart';
import '../../../res/components/bottomNavigationBar.dart';
import '../editIncidentalExpenseForm.dart';
import 'approvedManagerIncidents.dart';
import 'managarPartialIncidental.dart';
import 'managerIncidentalShimmer.dart';
import 'managerPaidIncidental.dart';

class ManagerIncidentalExpenseScreen extends StatefulWidget {
  ManagerIncidentalExpenseScreenState createState() =>
      ManagerIncidentalExpenseScreenState();
}

class ManagerIncidentalExpenseScreenState
    extends State<ManagerIncidentalExpenseScreen> {
  bool isLoading = true;
  // ManagerIncidentalViewModel userIncidentalViewModel = new ManagerIncidentalViewModel();
  bool pendingIncidental = true;
  bool fromUser = false;
  var dateFormat = DateFormat('yyyy-MM-dd');
  final _controller = TextEditingController();
  var data;
  List<dynamic> query = [];

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, 4, 1),
    end: DateTime(DateTime.now().year + 1, 3, 31),
  );

  @override
  void initState() {
    Provider.of<ManagerIncidentalViewModel>(context, listen: false)
        .getManagerIncidental(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
        .then((value) {
      setState(() {
        isLoading = false;
        // data = Provider.of<ManagerIncidentalViewModel>(context).incidentalExpense
      });
    });
    super.initState();
    // userIncidentalViewModel.getManagerIncidental();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final provider =
        Provider.of<ManagerIncidentalViewModel>(context).incidentalExpense;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        // toolbarHeight: 130,
        elevation: 1,
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.008,
              ),
              child: Container(
                // height: 400,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                          SizedBox(
                              width: SizeVariables.getWidth(context) * 0.02),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.4,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Manage Incidental Claims',
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
              // child: Row(
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         // Navigator.of(context).pushNamed(RouteNames.navbar);
              //         // Navigator.of(context).pop();
              //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomBottomNavigation(0)));
              //       },
              //       child: SvgPicture.asset(
              //         "assets/icons/back button.svg",
              //       ),
              //     ),
              //     Container(
              //       width: width > 750
              //           ? 50.w
              //           : height < 650
              //               ? 61.w
              //               : 60.w,
              //       padding: EdgeInsets.only(
              //         left: SizeVariables.getWidth(context) * 0.02,
              //       ),
              //       child: FittedBox(
              //         fit: BoxFit.contain,
              //         child: Text(
              //           'Manage Incidental Claims',
              //           style: Theme.of(context).textTheme.caption,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            // Container(
            //   height: 80,
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(top: 17),
            //   // color: Colors.red,
            //   child: Row(
            //     children: [
            //       // Padding(
            //       //   padding:
            //       //       EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.03, top: SizeVariables.getHeight(context) * 0.014),
            //       //   child: InkWell(
            //       //       onTap: () => Navigator.of(context).pop(),
            //       //       child: const Icon(Icons.arrow_back_ios,
            //       //           color: Colors.green, size: 30)),
            //       // ),
            //       Padding(
            //         padding: EdgeInsets.only(
            //             left: SizeVariables.getWidth(context) * 0.02,
            //             right: SizeVariables.getWidth(context) * 0.04,
            //             bottom: SizeVariables.getHeight(context) * 0.04),
            //         child: Container(
            //           // color: Colors.amber,
            //           width: SizeVariables.getWidth(context) * 0.8,
            //           height: SizeVariables.getHeight(context) * 0.065,
            //           // margin: EdgeInsets.only(
            //           //     // top: SizeVariables.getHeight(context) * 0.02,
            //           //     ),
            //           padding: EdgeInsets.only(
            //               left: SizeVariables.getWidth(context) * 0.02),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(20),
            //             boxShadow: const [
            //               BoxShadow(
            //                 color: Colors.grey,
            //                 // spreadRadius: 5,
            //                 blurRadius: 5,
            //                 offset: Offset(0, 2),
            //               ),
            //             ],
            //           ),
            //           child: Row(
            //             children: [
            //               const Flexible(
            //                 flex: 1,
            //                 fit: FlexFit.tight,
            //                 child: Icon(
            //                   Icons.search_outlined,
            //                   color: Colors.grey,
            //                   size: 22,
            //                 ),
            //               ),
            //               Flexible(
            //                 flex: 9,
            //                 fit: FlexFit.tight,
            //                 child: TextField(
            //                   controller: _controller,
            //                   // onChanged: (value) => searchByQuery(value),
            //                   autofocus: false,
            //                   cursorColor: Colors.grey,
            //                   style: const TextStyle(
            //                       color: Colors.black, fontSize: 14),
            //                   decoration: const InputDecoration(
            //                     border: InputBorder.none,
            //                     hintText: 'Search By Name or Title',
            //                     hintStyle: TextStyle(color: Colors.grey),
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
        // bottom: const TabBar(
        //   indicatorColor: Colors.amber,
        //   tabs: [
        //   Tab(text: 'Pending'),
        //   Tab(text: 'Approved'),
        //   // Tab(text: 'Payment Pending'),
        //   // Tab(text: 'Partial Payment'),
        //   // Tab(text: 'Paid'),
        //   Tab(text: 'Rejected'),
        // ]),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? ManagerIncidentalShimmer()
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
                                        false,
                                        pendingIncidental,
                                        provider['data'][index],
                                        fromUser,
                                        provider['data'][index]['data_list']
                                            ['incedental_form_id'],
                                        // provider['data'][index]['emp_id'],
                                        provider['data'][index]['data_list']
                                            ['user_id'],
                                        provider['data'][index]['data_list']
                                            ['claim_no'],
                                        // provider['data'][index]['doc_no'],
                                        provider['data'][index]['data_list']
                                            ['service_provider'],
                                        provider['data'][index]['data_list']
                                            ['bill_no'],
                                        provider['data'][index]['data_list']
                                            ['gst_no'],
                                        provider['data'][index]['data_list']
                                            ['basic_amount'],
                                        provider['data'][index]['data_list']
                                            ['gst_amount'],
                                        provider['data'][index]['data_list']
                                            ['claim_amount'],
                                        provider['data'][index]['data_list']
                                            ['purpose'],
                                        provider['data'][index]['data_list']
                                            ['attachment'],
                                        dateFormat.format(dateRange.start),
                                        dateFormat.format(dateRange.end)))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              SizeVariables.getWidth(context) * 0.02),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              width: double.infinity,
                              // height: 50,
                              margin: EdgeInsets.only(
                                  bottom:
                                      SizeVariables.getHeight(context) * 0.01),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 181, 179, 179)
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
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          // color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              provider['data'][index]
                                                                  ['data_list'][
                                                              'profile_photo'] ==
                                                          '${AppUrl.baseUrl}/profile_photo/' ||
                                                      provider['data'][index]
                                                                  ['data_list'][
                                                              'profile_photo'] ==
                                                          null
                                                  ? CircleAvatar(
                                                      radius: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.05,
                                                      backgroundColor:
                                                          Colors.green,
                                                      backgroundImage:
                                                          const AssetImage(
                                                              'assets/img/profilePic.jpg'),
                                                      // child: const Icon(Icons.account_box, color: Colors.white),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: provider['data']
                                                                  [index]
                                                              ['data_list']
                                                          ['profile_photo'],
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.05,
                                                        width: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.05,
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
                                                                  0.05,
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
                                                                            10),
                                                                  ),
                                                                ),
                                                              )),
                                                    ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.01,
                                                    top:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.007,
                                                  ),
                                                  // color: Colors.pink,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        // color: Colors.green,

                                                        child: Text(
                                                            provider['data']
                                                                        [index][
                                                                    'data_list']
                                                                ['emp_name'],
                                                            // textAlign:
                                                            //     TextAlign.end,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        // color: Colors.blue,

                                                        child: Text(
                                                          provider['data']
                                                                      [index]
                                                                  ['data_list']
                                                              ['emp_code'],
                                                          // textAlign:
                                                          //     TextAlign.end,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: const Color.fromARGB(
                                                  255, 103, 122, 114)
                                              .withOpacity(0.1),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                              top: 2.5,
                                              bottom: 2.5),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                provider['data'][index]
                                                    ['data_list']['status'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 109, 247, 143),
                                                        fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height:
                                        SizeVariables.getHeight(context) * 0.06,
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
                                                  color: Colors.amber,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    provider['data'][index]
                                                            ['data_list']
                                                        ['claim_no'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: Colors.amber
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
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    // DateFormat(
                                                    //         'dd-MMM-yyyy')
                                                    //     .format(DateTime
                                                    //         .parse(provider['data'][
                                                    //                 index]
                                                    //             ['date'])),
                                                    provider['data'][index]
                                                        ['data_list']['date'],
                                                    style: Theme.of(context)
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
                                                        FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                                provider['data'][index]
                                                    ['data_list']['purpose'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: const Color
                                                            .fromARGB(255, 208,
                                                            204, 204))))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.02),
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IncidentalClaimsEditScreen(
                                                    false,
                                                    pendingIncidental,
                                                    provider['data'][index],
                                                    fromUser,
                                                    provider['data'][index]['data_list']
                                                        ['incedental_form_id'],
                                                    provider['data'][index]['data_list']
                                                        ['user_id'],
                                                    provider['data'][index]['data_list']
                                                        ['claim_no'],
                                                    // provider[index]
                                                    //     ['doc_no'],
                                                    provider['data'][index]['data_list']
                                                        ['service_provider'],
                                                    provider['data'][index]
                                                            ['data_list']
                                                        ['bill_no'],
                                                    provider['data'][index]
                                                        ['data_list']['gst_no'],
                                                    provider['data'][index]
                                                            ['data_list']
                                                        ['basic_amount'],
                                                    provider['data'][index]
                                                            ['data_list']
                                                        ['gst_amount'],
                                                    provider['data'][index]
                                                            ['data_list']
                                                        ['claim_amount'],
                                                    provider['data'][index]
                                                            ['data_list']
                                                        ['purpose'],
                                                    provider['data'][index]
                                                        ['data_list']['attachment'],
                                                    dateFormat.format(dateRange.start),
                                                    dateFormat.format(dateRange.end)))),
                                    child: Container(
                                      width: double.infinity,
                                      height: SizeVariables.getHeight(context) *
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
                                                children: const [
                                                  Icon(Icons.info,
                                                      color: Colors.amber),
                                                  Text('View/Edit Claim')
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
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text('₹'),
                                                  Text(
                                                    '${provider['data'][index]['data_list']['claim_amount']}',
                                                    style: const TextStyle(
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        SizeVariables.getHeight(context) * 0.02,
                                  ),

                                  Container(
                                    width: double.infinity,
                                    height:
                                        SizeVariables.getHeight(context) * 0.1,
                                    // color: Colors.red,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (int i = 0;
                                            i <
                                                provider['data'][index]
                                                        ['approval_log']
                                                    .length;
                                            i++)
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                      child:
                                                          provider['data'][index]['approval_log']
                                                                              [
                                                                              i]
                                                                          [
                                                                          'profile_photo'] ==
                                                                      '' ||
                                                                  provider['data']
                                                                              [
                                                                              index]['approval_log'][i]
                                                                          [
                                                                          'profile_photo'] ==
                                                                      null
                                                              ? CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.04,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  backgroundImage:
                                                                      const AssetImage(
                                                                          'assets/img/profilePic.jpg'),
                                                                  // child: const Icon(Icons.account_box, color: Colors.white),
                                                                )
                                                              : CachedNetworkImage(
                                                                  imageUrl: provider['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'approval_log'][i]
                                                                      [
                                                                      'profile_photo'],
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    height: SizeVariables.getHeight(
                                                                            context) *
                                                                        0.08,
                                                                    width: SizeVariables.getHeight(
                                                                            context) *
                                                                        0.08,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.contain)),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Container(
                                                                          height: SizeVariables.getHeight(context) *
                                                                              0.06,
                                                                          child:
                                                                              Shimmer.fromColors(
                                                                            baseColor:
                                                                                Colors.grey[400]!,
                                                                            highlightColor: const Color.fromARGB(
                                                                                255,
                                                                                120,
                                                                                120,
                                                                                120),
                                                                            child:
                                                                                const CircleAvatar(
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
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.002,
                                                  ),
                                                  Container(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.1,
                                                    child: Text(
                                                      provider['data'][index]
                                                              ['approval_log']
                                                          [i]['emp_name'],
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
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.002,
                                                  ),
                                                  Text(
                                                    DateFormat('yyyy-MM-dd').format(
                                                        DateTime.parse(provider[
                                                                        'data']
                                                                    [index]
                                                                ['approval_log']
                                                            [i]['created_at'])),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 10,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              provider['data'][index]
                                                              ['approval_log']
                                                          .length ==
                                                      1
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      child: Container(
                                                        width: 37,
                                                        height: 4,
                                                        color: Colors.grey,
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
                                  //             decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               border: Border.all(
                                  //                 color: Colors.green,
                                  //                 width: 3,
                                  //               ),
                                  //             ),
                                  //             child: CircleAvatar(
                                  //               radius: SizeVariables.getWidth(
                                  //                       context) *
                                  //                   0.04,
                                  //               backgroundColor: Colors.green,
                                  //               backgroundImage:
                                  //                   const AssetImage(
                                  //                 'assets/img/profilePic.jpg',
                                  //               ),
                                  //               // child: const Icon(Icons.account_box, color: Colors.white),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
                                  //                 0.002,
                                  //           ),
                                  //           Container(
                                  //             width: SizeVariables.getWidth(
                                  //                     context) *
                                  //                 0.1,
                                  //             child: Text(
                                  //               'Shaikh salim Akhtar',
                                  //               overflow: TextOverflow.ellipsis,
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .bodyText1!
                                  //                   .copyWith(
                                  //                     fontSize: 10,
                                  //                   ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
                                  //                 0.002,
                                  //           ),
                                  //           Text(
                                  //             '2023-05-08',
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
                                  //         padding: const EdgeInsets.only(
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
                                  //             decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               border: Border.all(
                                  //                 color: Colors.amber,
                                  //                 width: 3,
                                  //               ),
                                  //             ),
                                  //             child: CircleAvatar(
                                  //               radius: SizeVariables.getWidth(
                                  //                       context) *
                                  //                   0.01,
                                  //               backgroundColor: Colors.green,
                                  //               backgroundImage:
                                  //                   const AssetImage(
                                  //                 'assets/img/profilePic.jpg',
                                  //               ),
                                  //               // child: const Icon(Icons.account_box, color: Colors.white),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
                                  //                 0.002,
                                  //           ),
                                  //           Container(
                                  //             width: SizeVariables.getWidth(
                                  //                     context) *
                                  //                 0.1,
                                  //             child: Text(
                                  //               '..............................',
                                  //               overflow: TextOverflow.ellipsis,
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .bodyText1!
                                  //                   .copyWith(
                                  //                     fontSize: 10,
                                  //                   ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
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
                                  //         padding: const EdgeInsets.only(
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
                                  //             decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               border: Border.all(
                                  //                 color: Colors.grey,
                                  //                 width: 3,
                                  //               ),
                                  //             ),
                                  //             child: CircleAvatar(
                                  //               radius: SizeVariables.getWidth(
                                  //                       context) *
                                  //                   0.01,
                                  //               backgroundColor: Colors.green,
                                  //               backgroundImage:
                                  //                   const AssetImage(
                                  //                 'assets/img/profilePic.jpg',
                                  //               ),
                                  //               // child: const Icon(Icons.account_box, color: Colors.white),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
                                  //                 0.002,
                                  //           ),
                                  //           Container(
                                  //             width: SizeVariables.getWidth(
                                  //                     context) *
                                  //                 0.1,
                                  //             child: Text(
                                  //               '..............................',
                                  //               overflow: TextOverflow.ellipsis,
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .bodyText1!
                                  //                   .copyWith(
                                  //                     fontSize: 10,
                                  //                   ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
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
                                  //         padding: const EdgeInsets.only(
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
                                  //             decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               border: Border.all(
                                  //                 color: Colors.grey,
                                  //                 width: 3,
                                  //               ),
                                  //             ),
                                  //             child: CircleAvatar(
                                  //               radius: SizeVariables.getWidth(
                                  //                       context) *
                                  //                   0.01,
                                  //               backgroundColor: Colors.green,
                                  //               backgroundImage:
                                  //                   const AssetImage(
                                  //                 'assets/img/profilePic.jpg',
                                  //               ),
                                  //               // child: const Icon(Icons.account_box, color: Colors.white),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
                                  //                 0.002,
                                  //           ),
                                  //           Container(
                                  //             width: SizeVariables.getWidth(
                                  //                     context) *
                                  //                 0.1,
                                  //             child: Text(
                                  //               '..............................',
                                  //               overflow: TextOverflow.ellipsis,
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .bodyText1!
                                  //                   .copyWith(
                                  //                     fontSize: 10,
                                  //                   ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
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
                                  //         padding: const EdgeInsets.only(
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
                                  //             decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               border: Border.all(
                                  //                 color: Colors.grey,
                                  //                 width: 3,
                                  //               ),
                                  //             ),
                                  //             child: CircleAvatar(
                                  //               radius: SizeVariables.getWidth(
                                  //                       context) *
                                  //                   0.01,
                                  //               backgroundColor: Colors.green,
                                  //               backgroundImage:
                                  //                   const AssetImage(
                                  //                 'assets/img/profilePic.jpg',
                                  //               ),
                                  //               // child: const Icon(Icons.account_box, color: Colors.white),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
                                  //                 0.002,
                                  //           ),
                                  //           Container(
                                  //             width: SizeVariables.getWidth(
                                  //                     context) *
                                  //                 0.1,
                                  //             child: Text(
                                  //               '..............................',
                                  //               overflow: TextOverflow.ellipsis,
                                  //               style: Theme.of(context)
                                  //                   .textTheme
                                  //                   .bodyText1!
                                  //                   .copyWith(
                                  //                     fontSize: 10,
                                  //                   ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: SizeVariables.getHeight(
                                  //                     context) *
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
    });

    var fromDate = dateFormat.format(dateRange.start);
    var toDate = dateFormat.format(dateRange.end);

    Provider.of<ManagerIncidentalViewModel>(context, listen: false)
        .getManagerIncidental(fromDate, toDate)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    print('dateRange: $dateRange');
    return dateRange;
  }
}
