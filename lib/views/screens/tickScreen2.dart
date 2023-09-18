import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'attendancereportScreen.dart';

class SuccessTickScreenTwo extends StatefulWidget {
  SuccessTickScreenTwoState createState() => SuccessTickScreenTwoState();
}

class SuccessTickScreenTwoState extends State<SuccessTickScreenTwo> {
  // const SuccessTickScreenTwo({super.key});

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      new Duration(seconds: 3),
      () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AttendanceReport())),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          child: Lottie.asset(
            'assets/json/Loading.json',
            height: height > 750
                ? 38.h
                : height < 650
                    ? 47.h
                    : 70.h,
            width: width > 450
                ? 70.w
                : width < 350
                    ? 58.w
                    : 48.w,
          ),
        ),
      ),
    );
  }
}
