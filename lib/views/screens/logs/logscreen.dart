import 'package:claimz/data/response/status.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/lateCheckinViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'package:provider/provider.dart';

import '../../config/mediaQuery.dart';

class LogScreen extends StatefulWidget {
  LogScreenState createState() => LogScreenState();
}

class LogScreenState extends State<LogScreen> {
  List<Map<String, dynamic>> images = [
    {
      "image": "assets/clamizFrom/flight.svg",
      "name": "Travel Claim",
      "routes": RouteNames.travellistlog,

      // "routes": RouteNames.managerapproveclaims,
    },
    {
      "image": "assets/icons/conveynance.svg",
      "name": "Conveyance Claim",
      "routes": RouteNames.conveyancelistlog,
    },
    {
      "image": "assets/icons/incidentals.svg",
      "name": "Incidental Expenses",
      "routes": RouteNames.incidentallistlog,
    },
  ];

  List<String> name = [
    'Travel Claim',
    'Conveyance Claim',
    'Incidental Expenses',
  ];

  @override
  void initState() {
    // TODO: implement initState
    // lateCheckinViewModel.getLateCheckin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Container(
          padding: EdgeInsets.only(
            top: SizeVariables.getHeight(context) * 0.008,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed(RouteNames.navbar);
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  "assets/icons/back button.svg",
                ),
              ),
              Container(
                width: width > 750
                    ? 50.w
                    : height < 650
                        ? 61.w
                        : 60.w,
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.02,
                ),
                child: Text(
                  'Log\'s Menu',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
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
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.1,
          right: SizeVariables.getWidth(context) * 0.1,
        ),
        child: Container(
          // color: Colors.green,
          height: height > 800
              ? 80.h
              : height < 650
                  ? 97.h
                  : 100.h,

          // color: Colors.redAccent,
          // height: double.infinity,
          child: ListView(
            //scrollDirection: Axis.vertical,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: SizeVariables.getHeight(context) * 0.01),
              //   child: Row(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           // Navigator.of(context).pushNamed(RouteNames.navbar);
              //           Navigator.of(context).pop();
              //         },
              //         child: SvgPicture.asset(
              //           "assets/icons/back button.svg",
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(
              //           left: SizeVariables.getWidth(context)*0.01,
              //         ),
              //         child: FittedBox(
              //           fit: BoxFit.contain,
              //           child: Text(
              //             'My Menu',
              //             style: Theme.of(context).textTheme.caption,
              //           ),
              //         ),
              //       ),
              //       // ProfilededarWidget(),
              //     ],
              //   ),
              // ),

              SizedBox(height: SizeVariables.getHeight(context) * 0.03),
              Container(
                height: height > 800
                    ? 80.h
                    : height < 650
                        ? 100.h
                        : 105.h,
                // height: SizeVariables.getHeight(context) * 0.9,
                // color: Colors.amber,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 50,
                    mainAxisSpacing: 40,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => index == 4
                          ? Navigator.pushNamed(
                              context, images[index]["routes"])
                          : Navigator.pushNamed(
                              context, images[index]["routes"]),
                      child: Container(
                        // color: Colors.red,
                        child: ContainerStyle(
                          height: SizeVariables.getHeight(context) * 0.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(images[index]["image"]),
                                SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.02),
                                Text(
                                  name[index],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                // Text(
                                //   // '${value.managerView.data!.data!.length} Requests',
                                //   '8 Requests',
                                //   style: Theme.of(context).textTheme.bodyText1,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
