import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/routes/route.dart';
import '../../../utils/routes/routeNames.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/userViewModel.dart';
import '../../../viewModel/logIn&signUpViewModel.dart';

class VerticalcontainerWidget extends StatefulWidget {
  final Map<String, dynamic> profile;

  // const VerticalcontainerWidget({Key? key}) : super(key: key);
  List<Map<String, dynamic>> images = [
    {
      'image': "assets/icons/logout.svg",
      'route': RouteNames.login,
      'name': "Log-Out"
    },
    {
      'image': "assets/icons/change password.svg",
      'route': RouteNames.changepassword,
      'name': "Change Password"
    },
    {
      "image": "assets/icons/Settings.svg",
      "route": RouteNames.themescreen,
      "name": "Theme ",
    },
    {
      "image": "assets/icons/feedback.svg",
      "route": RouteNames.tickethistoryscroll,
      "name": "Ticket ",
    },
  ];

  VerticalcontainerWidget(this.profile);

  @override
  State<VerticalcontainerWidget> createState() =>
      _VerticalcontainerWidgetState();
}

class _VerticalcontainerWidgetState extends State<VerticalcontainerWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height > 750
          ? 48.h
          : height < 650
              ? 103.h
              : 58.h,
      // color: Colors.amber,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              if (index == 0) {
                Provider.of<LoginSignUpViewModel>(context, listen: false)
                    .logout({}, context);
                // localStorage.remove('token');
              } else if (index == 3) {
                Navigator.pushNamed(context, widget.images[index]['route'],
                    arguments: widget.profile);
              } else {
                Navigator.pushNamed(context, widget.images[index]['route']);
              }
            },
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[index]['image']),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.images[index]['name'],
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
