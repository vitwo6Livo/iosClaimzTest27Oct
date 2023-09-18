import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/components/bottomNavigationBar.dart';
import '../../../utils/routes/routeNames.dart';

class ProfilededarWidget extends StatefulWidget {
  // const ProfilededarWidget({Key? key}) : super(key: key);

  @override
  State<ProfilededarWidget> createState() => _ProfilededarWidgetState();
}

class _ProfilededarWidgetState extends State<ProfilededarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.10,
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
                    // Navigator.of(context).pushNamed(RouteNames.navbar);
                    // Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomBottomNavigation(2)));
                  },
                  child: SvgPicture.asset(
                    "assets/icons/back button.svg",
                  ),
                ),
                // ProfilededarWidget(),
              ],
            ),
          ),
          SizedBox(
            width: SizeVariables.getWidth(context) * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.025,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'My Profile',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
