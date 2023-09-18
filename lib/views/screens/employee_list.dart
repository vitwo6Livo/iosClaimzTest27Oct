// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/viewModel/reportingTreeViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../res/appUrl.dart';
//import '../../config/mediaQuery.dart';
//import 'otherTreeScreen.dart';

class EmployeeList extends StatelessWidget {
  final List employeeList;
  final int role;

  EmployeeList(this.employeeList, this.role);

  @override
  Widget build(BuildContext context) {
    print('employee-list: $employeeList');
    // final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                      child: (employeeList.isEmpty)
                          ? Center(
                              child: Text(
                                'Nothing to show, sorry',
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor),
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.1,
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
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              '${AppUrl.baseUrl}/profile_photo/${employeeList[index]['user']['profile_photo']}',
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
                                                              Shimmer
                                                                  .fromColors(
                                                            baseColor: Colors
                                                                .grey[400]!,
                                                            highlightColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    120,
                                                                    120,
                                                                    120),
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
                                                                          employeeList[index]['user']
                                                                              [
                                                                              'emp_name'],
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(fontSize: 12.sp),
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
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              // value.attendance.data!.attendance![index].user!.empName.toString(),
                                                                              employeeList[index]['user']['department_name'],
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 11.sp, color: Colors.grey),
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
                                                Row(
                                                  children: [
                                                    employeeList[index]['status'] ==
                                                                'Absent' &&
                                                            employeeList[index][
                                                                    'checkout_time'] ==
                                                                ''
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
                                                                          254,
                                                                          202,
                                                                          202),
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
                                                                            'Absent',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1!.copyWith(color: const Color.fromARGB(255, 255, 53, 53), fontSize: 11.sp),
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
                                                        : employeeList[index]['status'] ==
                                                                    'Leave' &&
                                                                employeeList[index]
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
                                                                        height: SizeVariables.getHeight(context) *
                                                                            0.03,
                                                                        width: SizeVariables.getWidth(context) *
                                                                            0.2,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              36,
                                                                              50,
                                                                              62),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 5.0,
                                                                              right: 5.0,
                                                                              top: 2.5,
                                                                              bottom: 2.5),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                FittedBox(
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
                                                                      height: SizeVariables.getHeight(
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
                                                            : employeeList[index]['status'] ==
                                                                        'Present' &&
                                                                    employeeList[index]['checkout_time'] ==
                                                                        ''
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
                                                                            color:
                                                                                Color(0xfffe2f6ed),
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
                                                                                  'Checked In',
                                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xfff26af48), fontSize: 11.sp),
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
                                                                        role == 0
                                                                            ? employeeList[index]['time']
                                                                            : DateFormat.Hms().format(DateTime.parse(employeeList[index]['time'])),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(color: Color(0xfffe2f6ed)),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : employeeList[index]['status'] ==
                                                                            'Weekend' &&
                                                                        employeeList[index]['checkout_time'] ==
                                                                            ''
                                                                    ? Column(
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
                                                                                color: const Color.fromARGB(125, 92, 92, 92),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5, bottom: 2.5),
                                                                                child: Center(
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
                                                                            height:
                                                                                SizeVariables.getHeight(context) * 0.005,
                                                                          ),
                                                                          Text(
                                                                            '--:--:--',
                                                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                                  color: Color.fromARGB(255, 254, 249, 202),
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Column(
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
                                                                            height:
                                                                                SizeVariables.getHeight(context) * 0.005,
                                                                          ),
                                                                          Text(
                                                                            role == 0
                                                                                ? employeeList[index]['checkout_time']
                                                                                : DateFormat.Hms().format(DateTime.parse(employeeList[index]['checkout_time'])),
                                                                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                                                  color: Color.fromARGB(255, 254, 249, 202),
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.04)
                                    ],
                                  ),
                              itemCount: employeeList.length),
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
