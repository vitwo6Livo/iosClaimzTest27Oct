import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class ProfileInfoHeader extends StatefulWidget {
  // const ProfileInfoHeader({Key? key}) : super(key: key);

  @override
  State<ProfileInfoHeader> createState() => _ProfileInfoHeaderState();
}

class _ProfileInfoHeaderState extends State<ProfileInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.08,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.03,
              left: SizeVariables.getWidth(context) * 0.025,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Profile Information',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
