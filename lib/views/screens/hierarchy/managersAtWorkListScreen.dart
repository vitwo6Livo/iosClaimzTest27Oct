// import 'dart:html';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/viewModel/reportingTreeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import '../../../res/appUrl.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../config/mediaQuery.dart';
import '../employeeRecord/viewEmployeeRecordScreen.dart';
import '../mapScreen.dart';
import 'otherTreeScreen.dart';

class ManagerAtWorkListScreen extends StatefulWidget {
  @override
  State<ManagerAtWorkListScreen> createState() =>
      _ManagerAtWorkListScreenState();
}

class _ManagerAtWorkListScreenState extends State<ManagerAtWorkListScreen> {
  var myMonth = DateFormat('MMMM').format(DateTime.now());

  var myYears = DateFormat('yyyy').format(DateTime.now());

  // List<String> month = [
  //   "January",
  //   "February",
  //   "March",
  //   "April",
  //   "May",
  //   "June",
  //   "July",
  //   "August",
  //   "September",
  //   "October",
  //   "November",
  //   "December"
  // ];

  // List<String> year = ["2022", "2021", "2020", "2019", "2018"];

  // Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kgoogle =
  //     CameraPosition(target: LatLng(22.5851993447, 88.4864015238), zoom: 14);

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final providerTwo = Provider.of<ReportingTreeViewModel>(context).all;
    // final provider = Provider.of<ReportingTreeViewModel>(context).tree;

    print('Latitudeeeeeee: ${providerTwo[0]['lat']}   RuntimeType: ${providerTwo[0]['lat'].runtimeType}');

    print('Longitude: ${providerTwo[0]['lng']}   RuntimeType: ${providerTwo[0]['lng'].runtimeType}');


    // print(object);

    // double.parse(providerTwo[index]['lat']),
    //                     double.parse(providerTwo[index]['lng'])

    print('ALL EMPLOYEES: $providerTwo');

    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Container(
              padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.025,
                right: SizeVariables.getWidth(context) * 0.025,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.015,
                    ),
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CustomBottomNavigation(2),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/back button.svg",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.01,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Attendance List',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // color: Colors.red,
                      child: ListView.builder(
                          itemBuilder: (context, index) => Column(
                                children: [
                                  providerTwo[index]['user']['emp_name'] ==
                                              null ||
                                          providerTwo[index]['user']
                                                  ['company_id'] ==
                                              null ||
                                          providerTwo[index]['user']['id'] ==
                                              null ||
                                          providerTwo[index]['user']
                                                  ['department_name'] ==
                                              null
                                      ? Container()
                                      : Container(
                                          width: double.infinity,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.12,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 5,
                                                fit: FlexFit.tight,
                                                child: Container(
                                                  height: double.infinity,
                                                  // color: Colors.green,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              left: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.02,
                                                              right: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.02),
                                                          child: providerTwo[index]
                                                                          ['user']
                                                                      ['profile_photo'] ==
                                                                  null
                                                              ? CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.08,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  backgroundImage:
                                                                      const AssetImage(
                                                                          'assets/img/profilePic.jpg'),
                                                                  // child: const Icon(Icons.account_box, color: Colors.white),
                                                                )
                                                              : CachedNetworkImage(
                                                                  imageUrl:
                                                                      '${AppUrl.baseUrl}/profile_photo/${providerTwo[index]['user']['profile_photo']}',
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          CircleAvatar(
                                                                    radius: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.08,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    backgroundImage:
                                                                        imageProvider,
                                                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Shimmer
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
                                                                    child: CircleAvatar(
                                                                        radius: SizeVariables.getWidth(context) *
                                                                            0.08),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      CircleAvatar(
                                                                    radius: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.08,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    backgroundImage:
                                                                        const AssetImage(
                                                                            'assets/img/profilePic.jpg'),
                                                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                                                  ),
                                                                )),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.02,
                                                          ),
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            // color: Colors
                                                            //     .blue,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .loose,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        FittedBox(
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          child:
                                                                              Text(
                                                                            providerTwo[index]['user']['emp_name'],
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.sp),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            FittedBox(
                                                                              fit: BoxFit.contain,
                                                                              child: Text(
                                                                                // value.attendance.data!.attendance![index].user!.empName.toString(),
                                                                                providerTwo[index]['user']['department_name'],
                                                                                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10.sp, color: Colors.grey),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: providerTwo[index]['count'] ==
                                                                              0 ||
                                                                          providerTwo[index]['count'] ==
                                                                              null
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeRecordScreen(false, providerTwo[index]['user']['id'], providerTwo[index], myMonth, myYears, false, providerTwo[index]['user']['emp_name'], false)));
                                                                          },
                                                                          // onTap: () => showDialog(
                                                                          //     context: context,
                                                                          //     builder: (context) => AlertDialog(
                                                                          //           backgroundColor: const Color.fromARGB(255, 50, 48, 48),
                                                                          //           title: Text('Select Month And Year For Which To View Record', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                                                          //           content: StatefulBuilder(
                                                                          //             builder: (BuildContext context, StateSetter setState) => Container(
                                                                          //               height: SizeVariables.getHeight(context) * 0.06,
                                                                          //               child: Padding(
                                                                          //                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                          //                 child: DateRangePicker(),
                                                                          //               ),

                                                                          //             ),
                                                                          //           ),
                                                                          //           actions: [
                                                                          //             TextButton(
                                                                          //                 onPressed: () {
                                                                          //                   Navigator.of(context).pop();
                                                                          //                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeRecordScreen(providerTwo[index], myMonth, myYears)));
                                                                          //                 },
                                                                          //                 child: const Text('View', style: TextStyle(color: Colors.amber)))
                                                                          //           ],
                                                                          //         )),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            child:
                                                                                Row(
                                                                              children: const [
                                                                                Icon(Icons.assignment, color: Colors.amber),
                                                                                Text('View'),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width:
                                                                              double.infinity,
                                                                          // color: Colors.red,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HierarchyScreen(providerTwo[index]['user']['id']))),
                                                                                child: Container(
                                                                                  child: Row(
                                                                                    children: [
                                                                                      const Icon(Icons.person, color: Colors.amber),
                                                                                      const Text(': '),
                                                                                      Text('${providerTwo[index]['count']}   |  '),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeRecordScreen(false, providerTwo[index]['user']['id'], providerTwo[index], myMonth, myYears, false, providerTwo[index]['user']['emp_name'], false)));
                                                                                },
                                                                                child: Container(
                                                                                  child: Row(
                                                                                    children: const [
                                                                                      Icon(Icons.assignment, color: Colors.amber),
                                                                                      Text('View'),
                                                                                    ],
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      attendanceBottom(context,
                                                          providerTwo, index);
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          providerTwo[index][
                                                                          "status"] ==
                                                                      "Absent" &&
                                                                  providerTwo[index]
                                                                          [
                                                                          'checkout_time'] ==
                                                                      ''
                                                              ? Container(
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top: SizeVariables.getHeight(context) *
                                                                                0.025,
                                                                            right:
                                                                                SizeVariables.getWidth(context) * 0.02),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              SizeVariables.getHeight(context) * 0.03,
                                                                          width:
                                                                              SizeVariables.getWidth(context) * 0.2,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            color: const Color.fromARGB(
                                                                                255,
                                                                                254,
                                                                                202,
                                                                                202),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 5.0,
                                                                                right: 5.0,
                                                                                top: 2.5,
                                                                                bottom: 2.5),
                                                                            child:
                                                                                Center(
                                                                              child: FittedBox(
                                                                                fit: BoxFit.contain,
                                                                                child: Text(
                                                                                  'Absent',
                                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: const Color.fromARGB(255, 255, 53, 53), fontSize: 11.sp),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: SizeVariables.getHeight(context) *
                                                                            0.005,
                                                                      ),
                                                                      Text(
                                                                        '--:--:--',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(
                                                                              color: Color.fromARGB(255, 254, 202, 202),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              // ],
                                                              // )
                                                              : providerTwo[index]["status"] ==
                                                                          "Leave" &&
                                                                      providerTwo[index]
                                                                              [
                                                                              'checkout_time'] ==
                                                                          ''
                                                                  ? Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.025, right: SizeVariables.getWidth(context) * 0.02),
                                                                            child:
                                                                                Container(
                                                                              height: SizeVariables.getHeight(context) * 0.03,
                                                                              width: SizeVariables.getWidth(context) * 0.2,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                color: Color.fromARGB(255, 36, 50, 62),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                child: Center(
                                                                                  child: FittedBox(
                                                                                    fit: BoxFit.contain,
                                                                                    child: Text(
                                                                                      'On Leave',
                                                                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue, fontSize: 11.sp),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                SizeVariables.getHeight(context) * 0.005,
                                                                          ),
                                                                          Text(
                                                                            '--:--:--',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText2!.copyWith(color: const Color.fromARGB(255, 36, 50, 62)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : providerTwo[index]["status"] ==
                                                                              "Present" &&
                                                                          providerTwo[index]['checkout_time'] ==
                                                                              ''
                                                                      ? Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.025, right: SizeVariables.getWidth(context) * 0.02),
                                                                              child: Container(
                                                                                height: SizeVariables.getHeight(context) * 0.03,
                                                                                width: SizeVariables.getWidth(context) * 0.2,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  color: const Color(0xfffe2f6ed),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                  child: Center(
                                                                                    child: FittedBox(
                                                                                      fit: BoxFit.contain,
                                                                                      child: Text(
                                                                                        'Checked In',
                                                                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color.fromARGB(255, 35, 237, 86), fontSize: 11.sp),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: SizeVariables.getHeight(context) * 0.005,
                                                                            ),
                                                                            Text(
                                                                              DateFormat('HH:mm:ss').format(DateTime.parse(providerTwo[index]['time'])),
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xfffe2f6ed)),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : providerTwo[index]["status"] == "Weekend" &&
                                                                              providerTwo[index]['checkout_time'] == ''
                                                                          ? Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.025, right: SizeVariables.getWidth(context) * 0.02),
                                                                                  child: Container(
                                                                                    height: SizeVariables.getHeight(context) * 0.03,
                                                                                    width: SizeVariables.getWidth(context) * 0.2,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      color: const Color.fromARGB(125, 92, 92, 92),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                      child: Center(
                                                                                        child: FittedBox(
                                                                                          fit: BoxFit.contain,
                                                                                          child: Text(
                                                                                            'Weekend',
                                                                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 11.sp),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: SizeVariables.getHeight(context) * 0.005,
                                                                                ),
                                                                                Text(
                                                                                  '--:--:--',
                                                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xfffe2f6ed)),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.025, right: SizeVariables.getWidth(context) * 0.02),
                                                                                  child: Container(
                                                                                    height: SizeVariables.getHeight(context) * 0.03,
                                                                                    width: SizeVariables.getWidth(context) * 0.2,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      color: const Color.fromARGB(255, 254, 249, 202),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                      child: Center(
                                                                                        child: FittedBox(
                                                                                          fit: BoxFit.contain,
                                                                                          child: Text(
                                                                                            'Checked Out',
                                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber, fontSize: 11.sp),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: SizeVariables.getHeight(context) * 0.005,
                                                                                ),
                                                                                Text(
                                                                                  providerTwo[index]['checkout_time'] == '' ? '' : DateFormat('HH:mm:ss').format(DateTime.parse(providerTwo[index]['checkout_time'])),
                                                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                                        color: const Color.fromARGB(255, 254, 249, 202),
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.04)
                                ],
                              ),
                          itemCount: providerTwo.length),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> attendanceBottom(
      BuildContext context, List<Map<String, dynamic>> providerTwo, int index) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.02,
                            right: SizeVariables.getWidth(context) * 0.02),
                        child: providerTwo[index]['user']['profile_photo'] ==
                                null
                            ? CircleAvatar(
                                radius: SizeVariables.getWidth(context) * 0.055,
                                backgroundColor: Colors.green,
                                backgroundImage: const AssetImage(
                                  'assets/img/profilePic.jpg',
                                ),
                                // child: const Icon(Icons.account_box, color: Colors.white),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    '${AppUrl.baseUrl}/profile_photo/${providerTwo[index]['user']['profile_photo']}',
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius:
                                      SizeVariables.getWidth(context) * 0.055,
                                  backgroundColor: Colors.green,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 120, 120, 120),
                                  child: CircleAvatar(
                                      radius: SizeVariables.getWidth(context) *
                                          0.08),
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius:
                                      SizeVariables.getWidth(context) * 0.055,
                                  backgroundColor: Colors.green,
                                  backgroundImage: const AssetImage(
                                      'assets/img/profilePic.jpg'),
                                ),
                              ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            providerTwo[index]['user']['emp_name'],
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            providerTwo[index]['user']['department_name'],
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white54,
                    ),
                    label: Text(
                      'History',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black, fontSize: 16),
                    ),
                    icon: const Icon(
                      Icons.location_searching,
                      color: Colors.black,
                      size: 18,
                    ),
                    onPressed: () {
                      Map<String, dynamic> data = {
                        'device_id': providerTwo[index]['user']['device_id'],
                        'place_of_posting': providerTwo[index]['user']
                            ['place_of_posting']
                      };

                      print('Device ID: $data');

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapScreen(data),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Text(
                      providerTwo[index]['checkin_address'] ?? '---',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.2,
                  top: SizeVariables.getHeight(context) * 0.006,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: Color(0xffF59F23),
                          size: 20,
                        ),
                        Text(
                          providerTwo[index]['status'] == 'Absent' &&
                                      providerTwo[index]['checkout_time'] ==
                                          '' ||
                                  providerTwo[index]['status'] == 'Leave' ||
                                  providerTwo[index]['status'] == 'Weekend'
                              ? '--:--:--'
                              : DateFormat('HH:mm:ss').format(
                                  DateTime.parse(providerTwo[index]['time'])),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: const Color.fromARGB(255, 88, 151, 91),
                            fontWeight: FontWeight.normal,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    providerTwo[index]['checkin_workstation'] == '' ||
                            providerTwo[index]['checkin_workstation'] == null
                        ? Container()
                        : Row(
                            children: [
                              Icon(
                                providerTwo[index]['checkin_workstation'] ==
                                        'Office'
                                    ? Icons.business_center
                                    : providerTwo[index]
                                                ['checkin_workstation'] ==
                                            'Offsite'
                                        ? Icons.home
                                        : Icons.person,
                                color: const Color(0xffF59F23),
                                size: 20,
                              ),
                              Text(
                                providerTwo[index]['checkin_workstation'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.red),
                  Expanded(
                    // fit: BoxFit.contain,
                    child: Text(
                      providerTwo[index]['checkout_address'] ?? '---',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.2,
                  top: SizeVariables.getHeight(context) * 0.006,
                ),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Color(0xffF59F23),
                            size: 20,
                          ),
                          Text(
                            providerTwo[index]['status'] == 'Absent' &&
                                        providerTwo[index]['checkout_time'] ==
                                            '' ||
                                    providerTwo[index]['status'] == 'Leave' ||
                                    providerTwo[index]['status'] == 'Weekend'
                                ? '--:--:--'
                                : providerTwo[index]['checkout_time'] == ''
                                    ? '--:--:--'
                                    : DateFormat('HH:mm:ss').format(
                                        DateTime.parse(
                                          providerTwo[index]['checkout_time'],
                                        ),
                                      ),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: const Color.fromARGB(255, 216, 109, 99),
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    providerTwo[index]['checkout_workstation'] == '' ||
                            providerTwo[index]['checkout_workstation'] == null
                        ? Container()
                        : Container(
                            child: Row(
                              children: [
                                Icon(
                                    providerTwo[index]
                                                ['checkout_workstation'] ==
                                            'Office'
                                        ? Icons.business_center
                                        : providerTwo[index]
                                                    ['checkout_workstation'] ==
                                                'Offsite'
                                            ? Icons.home
                                            : Icons.person,
                                    color: const Color(0xffF59F23),
                                    size: 20),
                                Text(
                                  providerTwo[index]['checkout_workstation'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.black,
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
              Row(
                children: [
                  Text(
                    'Working Time: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                  Container(
                    // color: Colors
                    //     .green,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.av_timer,
                          color: Colors.black,
                          size: 17,
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.002,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeVariables.getHeight(context) * 0.002),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: providerTwo[index]['checkout_time'] == '' ||
                                    providerTwo[index]['checkout_time'] == null
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getHeight(context) *
                                            0.002),
                                    child: Text(
                                      "--:--:--",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.black),
                                    ),
                                  )
                                : Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.14,
                                    child: Row(
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            '${DateTime.parse(providerTwo[index]['checkout_time']).difference(DateTime.parse(providerTwo[index]['time'])).inHours}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'H',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.015,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            '${DateTime.parse(providerTwo[index]['checkout_time']).difference(DateTime.parse(providerTwo[index]['time'])).inMinutes % 60}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'm',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Current Status:',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    providerTwo[index]['status'],
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: SizeVariables.getHeight(context) * 0.35,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(double.parse(providerTwo[index]['lat']),
                        double.parse(providerTwo[index]['lng'])),
                    zoom: 14,
                    minZoom: 8,
                    maxZoom: 16,
                  ),
                  children: [
                    TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', 
                        userAgentPackageName: 'com.claimz.claimzpublic'),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(double.parse(providerTwo[index]['lat']),
                              double.parse(providerTwo[index]['lng'])),
                          builder: (context) => RippleAnimation(
                              color: Colors.blue,
                              repeat: true,
                              minRadius: 25,
                              ripplesCount: 2,
                              child: const Icon(Icons.man,
                                  size: 30, color: Colors.amber)),
                        )
                      ],
                    )

                    // MarkerLayerOptions(markers: [
                    //   Marker(
                    //     point: LatLng(double.parse(providerTwo[index]['lat']),
                    //         double.parse(providerTwo[index]['lng'])),
                    //     builder: (context) => RippleAnimation(
                    //         color: Colors.blue,
                    //         repeat: true,
                    //         minRadius: 25,
                    //         ripplesCount: 2,
                    //         child: const Icon(Icons.man,
                    //             size: 30, color: Colors.amber)),
                    //   )
                    // ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Last Update On-   ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: const Color(0xfff93a4c7),
                              fontSize: 16,
                            ),
                      ),
                      Text(
                        providerTwo[index]['datetime'],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: const Color(0xfff93a4c7),
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: Text(
                          providerTwo[index]['address'],
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.social_distance,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: Text(
                          providerTwo[index]['distance'].toStringAsFixed(2),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
