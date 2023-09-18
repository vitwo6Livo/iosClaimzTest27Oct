import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/widgets/loginwidget/fieldWidget.dart';
import 'package:claimz/views/widgets/loginwidget/loginWidget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../services/locationPermissions.dart';
import '../config/mediaQuery.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   print('Screen Height: ${MediaQuery.of(context).size.height}');
  //   super.initState();
  // }

  @override
  void initState() {
    // TODO: implement initState
    LocationProvider();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    print('HEIGHT OF SCREEN: $height');
    print('WIDTH OF SCREEN: $width');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) =>
              constraints.maxWidth > 400 && constraints.maxWidth < 600
                  ? loginForm(context, 'largeDevice')
                  : constraints.maxWidth > 360 && constraints.maxWidth < 400
                      ? loginForm(context, 'mediumDevice')
                      : constraints.maxWidth < 360
                          ? loginForm(context, 'smallDevice')
                          : loginForm(context, ''),
        ),
      ),
    );
  }

  Container loginForm(BuildContext context, String size) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.red,
      // decoration: const BoxDecoration(
      //   // image: DecorationImage(
      //   //   image: AssetImage(
      //   //   "assets/img/bg.png"),
      //   //   fit: BoxFit.cover,
      //   // ),
      //   ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.05,
          ),
          Container(
            height: size == 'largeDevice'
                ? SizeVariables.getHeight(context) * 0.25
                : size == 'mediumDevice'
                    ? SizeVariables.getHeight(context) * 0.2
                    : size == 'smallDevice'
                        ? SizeVariables.getHeight(context) * 0.15
                        : SizeVariables.getHeight(context) * 0.25,
            width: double.infinity,
            // color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.02,
                    ),
                    width: size == 'largeDevice'
                        ? 300
                        : size == 'mediumDevice'
                            ? 300
                            : size == 'smallDevice'
                                ? 250
                                : 400,
                    height: size == 'largeDevice'
                        ? 160
                        : size == 'mediumDevice'
                            ? 150
                            : size == 'smallDevice'
                                ? 80
                                : 200,
                    child: Image.asset(
                      'assets/img/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              // color: Colors.red,
              height: size == 'largeDevice'
                  ? SizeVariables.getHeight(context) * 0.75
                  : size == 'mediumDevice'
                      ? SizeVariables.getHeight(context) * 0.8
                      : size == 'smallDevice'
                          ? SizeVariables.getHeight(context) * 0.8
                          : SizeVariables.getHeight(context) * 0.75,
              // width: SizeVariables.getWidth(context) * 0.8,
              // color: Colors.green,
              child: Column(
                children: [
                  LoginWidget(),
                  // SizedBox(height: 1),
                  Fieldwidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
