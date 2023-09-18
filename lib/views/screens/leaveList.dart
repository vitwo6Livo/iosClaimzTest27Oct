import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/components/containerStyle.dart';
import '../config/mediaQuery.dart';

class LeaveList extends StatefulWidget {
  // const LeaveList({Key? key}) : super(key: key);

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // color: Colors.green,
        height: SizeVariables.getHeight(context) * 1,
        width: SizeVariables.getWidth(context) * 1,
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.05),
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
            ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
