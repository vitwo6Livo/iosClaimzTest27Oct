import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/viewModel/reportingTreeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import '../../../res/appUrl.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../config/mediaQuery.dart';
import 'dart:convert';

import '../employeeRecord/viewEmployeeRecordScreen.dart';
import '../mapScreen.dart';
import 'managersAtWorkListScreen.dart';

class HierarchyScreen extends StatefulWidget {
  final int id;

  HierarchyScreenState createState() => HierarchyScreenState();

  HierarchyScreen(this.id);
}

class HierarchyScreenState extends State<HierarchyScreen> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ReportingTreeViewModel>(context, listen: false)
        .getOthersReportingTree(context, widget.id)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void checkHierarchy(int id) async {
    Provider.of<ReportingTreeViewModel>(context, listen: false)
        .getOthersReportingTree(context, id)
        .then((value) {
      print('VALUEEEEEEEEE: $value');
      if (value.isEmpty) {
        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          title: 'No Record Found',
          message: 'No Record Found',
          barBlur: 20,
        ).show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportingTreeViewModel>(context).others;
    // final otherProvider =
    //     Provider.of<ReportingTreeViewModel>(context).otherTree;

    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerAtWorkListScreen()));
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
                                    'Team Members',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                                        Container(
                                          width: double.infinity,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.12,
                                          // color: Colors.red,
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
                                                          child: provider[index]
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
                                                                      '${AppUrl.baseUrl}/profile_photo/${provider[index]['user']['profile_photo']}',
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
                                                            //     .orange,
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.start,
                                                              // crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                            provider[index]['user']['emp_name'],
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
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
                                                                                provider[index]['user']['department_name'],
                                                                                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14, color: Colors.grey),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    // color: Colors
                                                                    //     .yellow,
                                                                    child: provider[index]['count'] ==
                                                                                0 ||
                                                                            provider[index]['count'] ==
                                                                                null
                                                                        ? InkWell(
                                                                            // onTap: () {
                                                                            //   print('ID OF EMPLOYEE: ${provider[index]['user']['id']}');
                                                                            // },
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeRecordScreen(true, widget.id, provider[index], DateFormat('MMMM').format(DateTime.now()), DateFormat('yyyy').format(DateTime.now()), false, provider[index]['user']['emp_name'], false)));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: Row(
                                                                                children: const [
                                                                                  Icon(Icons.assignment, color: Colors.amber),
                                                                                  Text('View'),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Row(
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  print('ID OF EMPLOYEE: ${provider[index]['user']['id']}');
                                                                                  checkHierarchy(provider[index]['user']['id']);
                                                                                },
                                                                                child: Container(
                                                                                  child: Row(
                                                                                    children: [
                                                                                      const Icon(Icons.person, color: Colors.amber),
                                                                                      Text('${provider[index]['count']}  |  '),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  print('ID OF EMPLOYEE: ${provider[index]['user']['id']}');
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeRecordScreen(true, widget.id, provider[index], DateFormat('MMMM').format(DateTime.now()), DateFormat('yyyy').format(DateTime.now()), false, provider[index]['user']['emp_name'], false)));
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
                                                                )
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
                                                    onTap: () =>
                                                        attendanceBottom(
                                                            context,
                                                            provider,
                                                            index),
                                                    child: Container(
                                                      // color: Colors.red,
                                                      child: Row(
                                                        children: [
                                                          provider[index]["status"] ==
                                                                      "Absent" &&
                                                                  provider[index][
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
                                                                            .copyWith(color: Color.fromARGB(255, 255, 70, 53)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              // ],
                                                              // )
                                                              : provider[index][
                                                                              "status"] ==
                                                                          "Leave" &&
                                                                      provider[index]
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
                                                                                Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.blue),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : provider[index]["status"] ==
                                                                              "Present" &&
                                                                          provider[index]['checkout_time'] ==
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
                                                                                  color: Color(0xfffe2f6ed),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                  child: Center(
                                                                                    child: FittedBox(
                                                                                      fit: BoxFit.contain,
                                                                                      child: Text(
                                                                                        'Checked In',
                                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color.fromARGB(255, 35, 237, 86), fontSize: 11.sp),
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
                                                                              DateFormat.Hms().format(DateTime.parse(provider[index]['time'])),
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xfffe2f6ed)),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : provider[index]["status"] == "Weekend" &&
                                                                              provider[index]['checkout_time'] == ''
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
                                                                                  DateFormat.Hms().format(DateTime.parse(provider[index]['checkout_time'])),
                                                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: const Color.fromARGB(255, 254, 249, 202)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.04)
                                      ],
                                    ),
                                itemCount: provider.length),
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
                        userAgentPackageName: 'com.claimz.claimz'),
                    MarkerLayer(markers: [
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
                    ]),
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
