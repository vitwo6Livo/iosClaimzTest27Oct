import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/viewModel/logsViewModel.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/editIncidentalExpenseForm.dart';
import 'package:claimz/views/screens/logs/incidental/incidentalview.dart';
import 'package:claimz/views/screens/managerIncidentalScreen/managerIncidentalShimmer.dart';
import 'package:claimz/views/screens/managerIncidentalScreen/pendingmanagerIncidents.dart';
import 'package:claimz/views/screens/managerIncidentalScreen/rejectedManagerIncidents.dart';
import 'package:claimz/views/widgets/incidentalExpenseWidget/approvedIncidental.dart';
import 'package:claimz/views/widgets/incidentalExpenseWidget/pendingIncidental.dart';
import 'package:claimz/views/widgets/incidentalExpenseWidget/rejectedIncidental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/appUrl.dart';

class Incidentallist extends StatefulWidget {
  IncidentallistState createState() => IncidentallistState();
}

class IncidentallistState extends State<Incidentallist> {
  bool isLoading = true;
  // ManagerIncidentalViewModel userIncidentalViewModel = new ManagerIncidentalViewModel();
  bool pendingIncidental = true;
  bool fromUser = false;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    final start = dateRange.start;
    final end = dateRange.end;
    Provider.of<LogsViewModel>(context, listen: false)
        .getManagerIncidental(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    // userIncidentalViewModel.getManagerIncidental();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final provider = Provider.of<LogsViewModel>(context).incidentalExpense;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Container(
          padding: EdgeInsets.only(
            top: SizeVariables.getHeight(context) * 0.008,
          ),
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
                          'Incidental Expense',
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
          //         // Navigator.of(context).pushNamed(RouteNames.navbar);
          //         Navigator.of(context).pop();
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
          //           'Incidental Expense',
          //           style: Theme.of(context).textTheme.caption,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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

              // : Column(
              //
              //   children:[
              //     Container(
              //       // color: Colors.amber,
              //       width: SizeVariables.getWidth(context) * 0.7,
              //       child: DateRangePicker(
              //         onPressed: pickDateRange,
              //         end: end,
              //         start: start,
              //         // width: 1,
              //       ),
              //     ),
              //
              //
              //   ])
              : ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Incidentalview(
                                    false,
                                    pendingIncidental,
                                    {},
                                    fromUser,
                                    provider['data'][index]
                                        ['incedental_form_id'],
                                    // provider['data'][index]['emp_id'],
                                    provider['data'][index]['user_id'],
                                    provider['data'][index]['claim_no'],
                                    // provider['data'][index]['doc_no'],
                                    provider['data'][index]['service_provider'],
                                    provider['data'][index]['bill_no'],
                                    provider['data'][index]['gst_no'],
                                    provider['data'][index]['basic_amount'],
                                    provider['data'][index]['gst_amount'],
                                    provider['data'][index]['claim_amount'],
                                    provider['data'][index]['purpose'] ??
                                        "no purpose",
                                    provider['data'][index]['attachment']))),
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
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.04,
                                  right: SizeVariables.getWidth(context) * 0.04,
                                  top: SizeVariables.getHeight(context) * 0.015,
                                  bottom:
                                      SizeVariables.getHeight(context) * 0.015,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            provider['data'][index]
                                                            ['profile_photo'] ==
                                                        '${AppUrl.baseUrl}/profile_photo/' ||
                                                    provider['data'][index]
                                                            ['profile_photo'] ==
                                                        null
                                                ? CircleAvatar(
                                                    radius:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.05,
                                                    backgroundColor:
                                                        Colors.green,
                                                    backgroundImage: const AssetImage(
                                                        // profile photo /////////////////////////////////
                                                        'assets/img/profilePic.jpg'),
                                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl: provider['data']
                                                            [index]
                                                        ['profile_photo'],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.04,
                                                      width: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.04,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.04,
                                                      child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[400]!,
                                                        highlightColor:
                                                            const Color
                                                                .fromARGB(
                                                          255,
                                                          120,
                                                          120,
                                                          120,
                                                        ),
                                                        child:
                                                            const CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor:
                                                              Colors.green,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 10,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.008,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // emp name  //////////////////////////////
                                                  provider['data'][index]
                                                      ['emp_name'],
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                Text(
                                                  // emp code  /////////////////////////////////////
                                                  provider['data'][index]
                                                      ['emp_code'],
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Colors.amberAccent,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            // ststus //////////////////////////////
                                            provider['data'][index]['status']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: const Color.fromARGB(
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
                                      height: SizeVariables.getHeight(context) *
                                          0.012,
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
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                // doc number /////////////////////////////////
                                                provider['data'][index]
                                                    ['claim_no'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      color: Colors.amber,
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
                                        Row(
                                          children: [
                                            Text(
                                              'Remarks: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.2,
                                              child: Text(
                                                // purpose //////////////////////////////
                                                provider['data'][index]
                                                        ['approve_remarks']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        208,
                                                        204,
                                                        204,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.012,
                                    ),
                                    InkWell(
                                      // button //////////////////////////////////////
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Incidentalview(
                                                      false,
                                                      pendingIncidental,
                                                      {},
                                                      fromUser,
                                                      provider['data'][index][
                                                          'incedental_form_id'],
                                                      provider['data'][index]
                                                          ['user_id'],
                                                      provider['data'][index]
                                                          ['claim_no'],
                                                      // provider[index]
                                                      //     ['doc_no'],
                                                      provider['data'][index]
                                                          ['service_provider'],
                                                      provider['data'][index]
                                                          ['bill_no'],
                                                      provider['data'][index]
                                                          ['gst_no'],
                                                      provider['data'][index]
                                                          ['basic_amount'],
                                                      provider['data'][index]
                                                          ['gst_amount'],
                                                      provider['data'][index]
                                                          ['claim_amount'],
                                                      provider['data'][index]
                                                          ['purpose'],
                                                      provider['data'][index]
                                                          ['attachment'])

                                              // Incidentalview(
                                              //     false,
                                              //     pendingIncidental,
                                              //     {},
                                              //     fromUser,
                                              //     111,
                                              //     1,
                                              //     "12",
                                              //     // provider[index]
                                              //     //     ['doc_no'],
                                              //     "uber",
                                              //     "123",
                                              //     "224rwefds",
                                              //     "123",
                                              //     "10",
                                              //     "133",
                                              //     "nice",
                                              //     "blank")

                                              )),
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            SizeVariables.getHeight(context) *
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.012,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // date ///////////////////////////////////
                                          provider['data'][index]['created_at'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            // doc number /////////////////////////////////
                                            provider['data'][index]['claim_no'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 14,
                                                  color: Colors.amber,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.01),
                                    Container(
                                      width: double.infinity,
                                      height: SizeVariables.getHeight(context) *
                                          0.1,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 3,
                                                          ),
                                                        ),
                                                        child:
                                                            provider['data'][index]['approval_log'][i]
                                                                            [
                                                                            'profile_photo'] ==
                                                                        '' ||
                                                                    provider['data'][index]['approval_log'][i]
                                                                            [
                                                                            'profile_photo'] ==
                                                                        null
                                                                ? CircleAvatar(
                                                                    radius: SizeVariables.getWidth(
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
                                                                    imageUrl: provider['data'][index]
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
                                                                              image: imageProvider,
                                                                              fit: BoxFit.contain)),
                                                                    ),
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        Container(
                                                                            height: SizeVariables.getHeight(context) *
                                                                                0.06,
                                                                            child:
                                                                                Shimmer.fromColors(
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
                                                        provider['data'][index]
                                                                ['approval_log']
                                                            [i]['emp_name'],
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
                                                      DateFormat('yyyy-MM-dd').format(
                                                          DateTime.parse(provider[
                                                                          'data']
                                                                      [index]
                                                                  [
                                                                  'approval_log']
                                                              [
                                                              i]['created_at'])),
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
                                                            const EdgeInsets
                                                                .only(
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
                                  ],
                                ),
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
        saveText: "SEt",
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

    Provider.of<LogsViewModel>(context, listen: false)
        .getManagerIncidental(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
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
