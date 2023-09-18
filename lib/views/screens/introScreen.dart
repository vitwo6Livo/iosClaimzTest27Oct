import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_provider.dart';
import '../../utils/routes/route.dart';
import '../../utils/routes/routeNames.dart';

class IntroScreen extends StatelessWidget {
  final bool intro;

  IntroScreen(this.intro);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    print('Height Of Screen: $height');
    print('Width Of Screen: $width');

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img/claimzLogo.png'),
          Expanded(
            child: Text(
                intro == null || intro == false
                    ? ' To ensure the best experience and track your location activities accurately during work hours, we kindly request you to allow your location access from the Popup on the next screen or your app settings. This will help us provide you with valuable insights and improve your productivity.'
                    : 'Your application has been successfully submitted! Please await confirmation of your candidature from the Administrator.',
                textAlign: TextAlign.center),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.sp),
            child: AnimatedButton(
              height: 55,
              width: 280,
              text: 'Next',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              textStyle: TextStyle(
                  fontSize: 18,
                  color:
                      (themeProvider.darkTheme) ? Colors.white : Colors.black),
              backgroundColor:
                  (themeProvider.darkTheme) ? Colors.black : Colors.amberAccent,
              borderColor:
                  (themeProvider.darkTheme) ? Colors.white : Colors.amberAccent,
              borderRadius: 8,
              borderWidth: 2,
              onPress: () => Navigator.pushNamed(context, RouteNames.login),
            ),
          )
        ],
      ),
    );
  }
}
