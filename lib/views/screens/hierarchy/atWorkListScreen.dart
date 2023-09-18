// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/viewModel/reportingTreeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../res/appUrl.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../config/mediaQuery.dart';
import 'otherTreeScreen.dart';

class AtWorkListScreen extends StatelessWidget {
  // final Map<String, dynamic> role;

  // AtWorkListScreen(this.role);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;
    // final providerTwo = Provider.of<ReportingTreeViewModel>(context).all;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: [
          //   Image.asset(
          //   "assets/img/bg.png",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
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
                            Navigator.of(context).pop();
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
                              style: Theme.of(context).textTheme.caption,
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
                                        SizeVariables.getHeight(context) * 0.1,
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
                                                    child:
                                                        // value
                                                        //             .attendance
                                                        //             .data!
                                                        //             .attendance![
                                                        //                 index]
                                                        //             .user!
                                                        //             .profilePhoto ==
                                                        //         null
                                                        //     ?
                                                        CachedNetworkImage(
                                                      imageUrl:
                                                          '${AppUrl.baseUrl}/profile_photo/${provider['data']['dashboard_data']['attendance'][index]['user']['profile_photo']}',
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          CircleAvatar(
                                                        radius: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.08,
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
                                                    )
                                                    // : CircleAvatar(
                                                    //     radius: SizeVariables.getWidth(
                                                    //             context) *
                                                    //         0.08,
                                                    //     backgroundColor:
                                                    //         Colors
                                                    //             .red,
                                                    //     backgroundImage:
                                                    //         NetworkImage(
                                                    //             '${AppUrl.baseUrl}/${value.attendance.data!.attendance![index].user!.profilePhoto}'),
                                                    //   ),
                                                    ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.02,
                                                    ),
                                                    child: Container(
                                                      height: double.infinity,
                                                      // color: Colors.orange,
                                                      child: Column(
                                                        // mainAxisAlignment: MainAxisAlignment.start,
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.loose,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              // width: SizeVariables
                                                              //         .getWidth(
                                                              //             context) *
                                                              //     0.5,
                                                              // height: SizeVariables
                                                              //         .getHeight(
                                                              //             context) *
                                                              //     0.04,
                                                              // color:
                                                              //     Colors.amber,
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
                                                                    child: Text(
                                                                      provider['data']['dashboard_data']['attendance'][index]
                                                                              [
                                                                              'user']
                                                                          [
                                                                          'emp_name'],
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              fontSize: 12.sp),
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
                                                              width: double
                                                                  .infinity,
                                                              // width: SizeVariables
                                                              //         .getWidth(
                                                              //             context) *
                                                              //     0.5,
                                                              // height: SizeVariables
                                                              //         .getHeight(
                                                              //             context) *
                                                              //     0.04,
                                                              // color:
                                                              //     Colors.green,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      FittedBox(
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        child:
                                                                            Text(
                                                                          // value.attendance.data!.attendance![index].user!.empName.toString(),
                                                                          provider['data']['dashboard_data']['attendance'][index]['user']
                                                                              [
                                                                              'department_name'],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2!
                                                                              .copyWith(fontSize: 11.sp, color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),

                                                                  // Row(
                                                                  //   mainAxisAlignment:
                                                                  //       MainAxisAlignment
                                                                  //           .start,
                                                                  //   children: [
                                                                  //     // Text(
                                                                  //     //     'Checkin Time: ',
                                                                  //     //     style: Theme.of(context)
                                                                  //     //         .textTheme
                                                                  //     //         .bodyText1!
                                                                  //     //         .copyWith(fontSize: 14)),
                                                                  //     role['role'] ==
                                                                  //             1
                                                                  //         ? Row(
                                                                  //             children: [
                                                                  //               providerTwo[index]['time'] == '' || providerTwo[index]['time'] == null
                                                                  //                   ? Row(
                                                                  //                     children: [
                                                                  //                      Icon(
                                                                  //                         Icons.assignment_late_rounded,
                                                                  //                         color: Colors.red[200],
                                                                  //                         size: 15,
                                                                  //                       ),
                                                                  //                       Text(
                                                                  //                           'Not Checked in',
                                                                  //                           style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red[100]),
                                                                  //                         ),
                                                                  //                     ],
                                                                  //                   )
                                                                  //                   : Row(
                                                                  //                     children: [
                                                                  //                       Icon(
                                                                  //                         Icons.assignment_turned_in,
                                                                  //                         color: Colors.green[100],
                                                                  //                         size: 15,
                                                                  //                       ),
                                                                  //                       Text(
                                                                  //                           providerTwo[index]['time'],
                                                                  //                           style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.green[200]),
                                                                  //                         ),
                                                                  //                     ],
                                                                  //                   )
                                                                  //             ],
                                                                  //           )
                                                                  //         : Row(
                                                                  //             children: [
                                                                  //               provider['data']['dashboard_data']['attendance'][index]['time'] == '' || provider['data']['dashboard_data']['attendance'][index]['time'] == null
                                                                  //                   ? Text(
                                                                  //                     'Not Checked In',
                                                                  //                     style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
                                                                  //                     )
                                                                  //                   : Text(
                                                                  //                       provider['data']['dashboard_data']['attendance'][index]['time'],
                                                                  //                       style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10),
                                                                  //                     )
                                                                  //             ],
                                                                  //           ),

                                                                  //     // Text(
                                                                  //     //   role['role'] ==
                                                                  //     //           1
                                                                  //     //       ? providerTwo[index]['time'] == '' || providerTwo[index]['time'] == null
                                                                  //     //           ? 'Not Checked In'
                                                                  //     //           : providerTwo[index]['time']
                                                                  //     //       : provider['data']['dashboard_data']['attendance'][index]['time'] == '' || provider['data']['dashboard_data']['attendance'][index]['time'] == null
                                                                  //     //           ? 'Not Checked In'
                                                                  //     //           : provider['data']['dashboard_data']['attendance'][index]['time'],
                                                                  //     //   style: Theme.of(context)
                                                                  //     //       .textTheme
                                                                  //     //       .bodyText2!
                                                                  //     //       .copyWith(fontSize: 14),
                                                                  //     // ),
                                                                  //   ],
                                                                  // ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          // Flexible(
                                                          //   flex: 1,
                                                          //   fit: FlexFit.tight,
                                                          //   child: Container(
                                                          //     width: double.infinity,
                                                          //     // width: SizeVariables
                                                          //     //         .getWidth(
                                                          //     //             context) *
                                                          //     //     0.5,
                                                          //     // height: SizeVariables
                                                          //     //         .getHeight(
                                                          //     //             context) *
                                                          //     //     0.04,
                                                          //     color: Colors.black,
                                                          //     child: Row(
                                                          //       mainAxisAlignment:
                                                          //           MainAxisAlignment
                                                          //               .start,
                                                          //       children: [
                                                          //         Text(
                                                          //             'Check In Time: ',
                                                          //             style: Theme.of(
                                                          //                     context)
                                                          //                 .textTheme
                                                          //                 .bodyText1!
                                                          //                 .copyWith(
                                                          //                     fontSize:
                                                          //                         14)),
                                                          //         FittedBox(
                                                          //           fit: BoxFit
                                                          //               .contain,
                                                          //           child: Text(
                                                          //             // value.attendance.data!.attendance![index].user!.empName.toString(),
                                                          //             role['role'] ==
                                                          //                     1
                                                          //                 ? providerTwo[index]
                                                          //                     [
                                                          //                     'time']
                                                          //                 : provider['data']['dashboard_data']['attendance'][index]
                                                          //                     [
                                                          //                     'time'],
                                                          //             style: Theme.of(
                                                          //                     context)
                                                          //                 .textTheme
                                                          //                 .bodyText1!
                                                          //                 .copyWith(
                                                          //                     fontSize:
                                                          //                         14),
                                                          //           ),
                                                          //         ),
                                                          //       ],
                                                          //     ),
                                                          //   ),
                                                          // )
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
                                            // Text(
                                            //     'Checkin Time: ',
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText1
                                            // !
                                            //         .copyWith(fontSize: 14)),
                                            Row(
                                              children: [
                                                // providerTwo[index][
                                                //                 'time'] ==
                                                //             '' ||
                                                //         providerTwo[index]
                                                //                 [
                                                //                 'time'] ==
                                                //             null
                                                provider['data']['dashboard_data']
                                                                    ['attendance'][index]
                                                                ['status'] ==
                                                            'Absent' &&
                                                        provider['data']['dashboard_data']
                                                                    ['attendance'][index][
                                                                'checkout_time'] ==
                                                            ''
                                                    ? Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: SizeVariables
                                                                          .getHeight(
                                                                              context) *
                                                                      0.025,
                                                                  right: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.02),
                                                              child: Container(
                                                                height: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.03,
                                                                width: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.2,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      254,
                                                                      202,
                                                                      202),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: 5.0,
                                                                      right:
                                                                          5.0,
                                                                      top: 2.5,
                                                                      bottom:
                                                                          2.5),
                                                                  child: Center(
                                                                    child:
                                                                        FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        'Absent',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                                color: const Color.fromARGB(255, 255, 53, 53),
                                                                                fontSize: 11.sp),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.005,
                                                            ),
                                                            Text(
                                                              '--:--:--',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        254,
                                                                        202,
                                                                        202),
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    // ],
                                                    // )
                                                    : provider['data']['dashboard_data']
                                                                        ['attendance'][index]
                                                                    ['status'] ==
                                                                'Leave' &&
                                                            provider['data']['dashboard_data']['attendance'][index]['checkout_time'] == ''
                                                        ? Container(
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.025,
                                                                      right: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.02),
                                                                  child:
                                                                      Container(
                                                                    height: SizeVariables.getHeight(
                                                                            context) *
                                                                        0.03,
                                                                    width: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.2,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          36,
                                                                          50,
                                                                          62),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets.only(
                                                                          left:
                                                                              5.0,
                                                                          right:
                                                                              5.0,
                                                                          top:
                                                                              2.5,
                                                                          bottom:
                                                                              2.5),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            FittedBox(
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          child:
                                                                              Text(
                                                                            'On Leave',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue, fontSize: 11.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: SizeVariables
                                                                          .getHeight(
                                                                              context) *
                                                                      0.005,
                                                                ),
                                                                Text(
                                                                  '--:--:--',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            36,
                                                                            50,
                                                                            62),
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : provider['data']['dashboard_data']['attendance'][index]['status'] == 'Present' && provider['data']['dashboard_data']['attendance'][index]['checkout_time'] == ''
                                                            ? Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: SizeVariables.getHeight(context) *
                                                                            0.025,
                                                                        right: SizeVariables.getWidth(context) *
                                                                            0.02),
                                                                    child:
                                                                        Container(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.03,
                                                                      width: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.2,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: Color(
                                                                            0xfffe2f6ed),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5.0,
                                                                            right:
                                                                                5.0,
                                                                            top:
                                                                                2.5,
                                                                            bottom:
                                                                                2.5),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              'Checked In',
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xfff26af48), fontSize: 11.sp),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: SizeVariables.getHeight(
                                                                            context) *
                                                                        0.005,
                                                                  ),
                                                                  Text(
                                                                    provider['data']['dashboard_data']['attendance']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'time'],
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                            color:
                                                                                Color(0xfffe2f6ed)),
                                                                  ),
                                                                ],
                                                              )
                                                            : provider['data']['dashboard_data']['attendance'][index]['status'] == 'Weekend' && provider['data']['dashboard_data']['attendance'][index]['checkout_time'] == ''
                                                                ? Column(
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
                                                                                125,
                                                                                92,
                                                                                92,
                                                                                92),
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
                                                                                  'Weekend',
                                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white, fontSize: 11.sp),
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
                                                                              color: Color.fromARGB(255, 254, 249, 202),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
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
                                                                                249,
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
                                                                                  'Checked Out',
                                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber, fontSize: 11.sp),
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
                                                                        provider['data']['dashboard_data']['attendance'][index]
                                                                            [
                                                                            'checkout_time'],
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(
                                                                              color: Color.fromARGB(255, 254, 249, 202),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                              ],
                                            )

                                            // Text(
                                            //   role['role'] ==
                                            //           1
                                            //       ? providerTwo[index]['time'] == '' || providerTwo[index]['time'] == null
                                            //           ? 'Not Checked In'
                                            //           : providerTwo[index]['time']
                                            //       : provider['data']['dashboard_data']['attendance'][index]['time'] == '' || provider['data']['dashboard_data']['attendance'][index]['time'] == null
                                            //           ? 'Not Checked In'
                                            //           : provider['data']['dashboard_data']['attendance'][index]['time'],
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .bodyText2!
                                            //       .copyWith(fontSize: 14),
                                            // ),
                                          ],
                                        ),

                                        // Flexible(
                                        //   flex: 1,
                                        //   fit: FlexFit.tight,
                                        //   child: role['role'] == 1
                                        //       ? Container(
                                        //           height: double.infinity,
                                        //           // color: Colors.blue,
                                        //           child: Center(
                                        //             child: CircleAvatar(
                                        //               radius: 10,
                                        //               backgroundColor: providerTwo[
                                        //                               index][
                                        //                           'status'] ==
                                        //                       'absent'
                                        //                   ? Colors.red
                                        //                   : providerTwo[index]
                                        //                               [
                                        //                               'status'] ==
                                        //                           'leaves'
                                        //                       ? Colors.blue
                                        //                       : Colors.green,
                                        //             ),
                                        //           ),
                                        //         )
                                        //       : Container(
                                        //           height: double.infinity,
                                        //           // color: Colors.blue,
                                        //           child: Center(
                                        //             child: CircleAvatar(
                                        //               radius: 10,
                                        //               backgroundColor: provider['data']
                                        //                                   ['dashboard_data']
                                        //                               ['attendance'][index]
                                        //                           [
                                        //                           'status'] ==
                                        //                       'absent'
                                        //                   ? Colors.red
                                        //                   : provider['data']['dashboard_data']
                                        //                                       ['attendance']
                                        //                                   [
                                        //                                   index]
                                        //                               [
                                        //                               'status'] ==
                                        //                           'leaves'
                                        //                       ? Colors.blue
                                        //                       : Colors.green,
                                        //             ),
                                        //           ),
                                        //         ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.04)
                                ],
                              ),
                          itemCount: provider['data']['dashboard_data']
                                  ['attendance']
                              .length),
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
}
