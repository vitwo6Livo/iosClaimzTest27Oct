import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginWidget extends StatefulWidget {
  // const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height > 750
          ? 9.h
          : height < 650
              ? 14.h
              : 13.h,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Flexible(
            // flex: 4,
            // fit: FlexFit.tight,
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Enter Your Credentials To Continue',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
