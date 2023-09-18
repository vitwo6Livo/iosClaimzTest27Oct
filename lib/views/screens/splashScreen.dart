import 'package:claimz/services/splashServices.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../utils/routes/routeNames.dart';
import 'attendancereportScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    splashServices.authenticate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // color: Colors.red,
            child: Lottie.asset(
              'assets/json/claimz_splash.json',
              // fit: BoxFit.cover,
              height: height > 750
                  ? 95.h
                  : height < 650
                      ? 101.h
                      : 100.h,
              width: width > 450
                  ? 100.w
                  : width < 350
                      ? 95.w
                      : 100.w,
            ),
          ),
        ],
      ),
    );
  }
}
