import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SuccessTickScreen extends StatefulWidget {
  SuccessTickScreenState createState() => SuccessTickScreenState();
}

class SuccessTickScreenState extends State<SuccessTickScreen> {
  // const SuccessTickScreen({super.key});

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pop(),
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
