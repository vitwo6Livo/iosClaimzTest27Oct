import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/mediaQuery.dart';

class ReportHeader extends StatefulWidget {
  // const ReportHeader({Key? key}) : super(key: key);

  @override
  State<ReportHeader> createState() => _ReportHeaderState();
}

class _ReportHeaderState extends State<ReportHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      // height: SizeVariables.getHeight(context) * 0.07,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomBottomNavigation(0)));
                },
                child: SvgPicture.asset(
                  "assets/icons/back button.svg",
                ),
              ),
            ],
          ),
          SizedBox(
            width: SizeVariables.getWidth(context) * 0.01,
          ),
          Container(
            width: SizeVariables.getWidth(context) * 0.4,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Attendance Report',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
