import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/widgets/profileWidget/hedar.dart';
import 'package:claimz/views/widgets/profileWidget/profilecontainerWidget.dart';
import 'package:claimz/views/widgets/profileWidget/verticalcontainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../res/components/bottomNavigationBar.dart';
import '../../utils/routes/routeNames.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profileDetails;

  ProfileScreen(this.profileDetails);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        // Navigator.of(context).pushNamed(RouteNames.navbar);
        // Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CustomBottomNavigation(2)));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Container(
              // height: double.infinity,
              child: ListView(
                //scrollDirection: Axis.vertical,
                children: [
                  ProfilededarWidget(),
                  ProfilecontainerWidget(profileDetails),
                  SizedBox(height: SizeVariables.getHeight(context) * 0.03),
                  VerticalcontainerWidget(profileDetails),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
