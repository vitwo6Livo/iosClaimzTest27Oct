import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes/routeNames.dart';
import '../widgets/attendanceWidget/attnhedarWidget.dart';
import '../widgets/attendanceWidget/attscreenWidget.dart';

class AttendanceScreen extends StatefulWidget {
  // const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   "assets/img/bg.png",
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.01),
                  child: Row(
                    children: [
                      // ProfilededarWidget(),
                    ],
                  ),
                ),
                AttnhedarWidget(),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.04,
                ),
                // AttscreenWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
