import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/components/buttonStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';

class ClaimzHeader extends StatefulWidget {
  // const ClaimzHeader({Key? key}) : super(key: key);

  @override
  State<ClaimzHeader> createState() => _ClaimzHeaderState();
}

class _ClaimzHeaderState extends State<ClaimzHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: SizeVariables.getHeight(context) * 0.06,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.02),
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
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: SizeVariables.getHeight(context)*0.02,
          //     left: SizeVariables.getWidth(context)*0.01
          //   ),
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Text(
          //       'Claimz Menu',
          //       style: Theme.of(context).textTheme.caption,
          //     ),
          //   ),

          // ),
        ],
      ),
    );
  }
}
