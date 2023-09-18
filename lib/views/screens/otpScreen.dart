import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './inputOtp.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  OtpScreen(this.email);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.red
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'An OTP has been sent to your Email',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 19),
                ),
              ],
            ),
            Text(
              'Please Enter to Continue',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.04,
                  right: SizeVariables.getWidth(context) * 0.04),
              child: SizedBox(
                  height: SizeVariables.getHeight(context) * 0.25,
                  width: double.infinity,
                  // color: Colors.red,
                  child: InputOTP(email)),
            )
          ],
        ),
      ),
    );
  }
}
