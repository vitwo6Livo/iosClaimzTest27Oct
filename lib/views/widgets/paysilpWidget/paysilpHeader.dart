import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/mediaQuery.dart';

class PayslipHeader extends StatefulWidget {
  // const PayslipHeader({Key? key}) : super(key: key);

  @override
  State<PayslipHeader> createState() => _PayslipHeaderState();
}

class _PayslipHeaderState extends State<PayslipHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.07,
      // width: double.infinity,
      // color: Colors.red,
      padding: const EdgeInsets.all(8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: SizeVariables.getWidth(context) * 0.02),
          Padding(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.008,
              left: SizeVariables.getWidth(context) * 0.008,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'PaySlip',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          )
        ],
      ),
    );
  }
}
