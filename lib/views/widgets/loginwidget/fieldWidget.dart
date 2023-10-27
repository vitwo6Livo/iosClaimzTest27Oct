import 'dart:io';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:sizer/sizer.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/routes/routeNames.dart';
import '../../../viewModel/logIn&signUpViewModel.dart';
import 'package:unique_identifier/unique_identifier.dart';

class Fieldwidget extends StatefulWidget {
  // const Fieldwidget({Key? key}) : super(key: key);

  @override
  State<Fieldwidget> createState() => _FieldwidgetState();
}

class _FieldwidgetState extends State<Fieldwidget> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var deviceInfo = DeviceInfoPlugin();
  var deviceId;

  String? fcm;

  String name = '';
  String password = '';
  String email = '';
  String _identifier = 'Unknown';

  Future<void> fcmCodeGenerate() async {
    fcm = await FirebaseMessaging.instance.getToken();
    print('FCM CODE: $fcm');
  }

  @override
  void initState() {
    // TODO: implement initState
    fcmCodeGenerate();
    // getDeviceId();
    initUniqueIdentifierState();

    super.initState();
  }

  // void getDeviceId() async {
  //   if (Platform.isAndroid) {
  //     deviceId = await deviceInfo.androidInfo;
  //   } else if (Platform.isIOS) {
  //     deviceId = await deviceInfo.iosInfo;
  //   }
  // }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Username',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            // ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(right: 25),
              height: SizeVariables.getHeight(context) * 0.06,
              // color: Colors.red,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: _userNameController,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  // fillColor: Colors.grey,
                ),
                // validator: (value) {
                //   if (value!.isEmpty || value == '') {
                //     return 'Please enter usename';
                //   } else {
                //     name = value;
                //     return null;
                //   }
                // },
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.03),
            // const Text(
            //   'Password',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            // ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(right: 25),
              height: SizeVariables.getHeight(context) * 0.06,
              // color: Colors.red,
              child: TextFormField(
                controller: _passwordController,
                obscureText:
                    Provider.of<LoginSignUpViewModel>(context, listen: false)
                        .count,
                cursorColor: Colors.white,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  // border: InputBorder.none,
                  fillColor: Colors.grey,
                  suffixIcon: InkWell(
                    onTap: () {
                      if (Provider.of<LoginSignUpViewModel>(context,
                              listen: false)
                          .count) {
                        setState(() {
                          Provider.of<LoginSignUpViewModel>(context,
                                  listen: false)
                              .count = false;
                        });
                      } else {
                        setState(() {
                          Provider.of<LoginSignUpViewModel>(context,
                                  listen: false)
                              .count = true;
                        });
                      }
                    },
                    child: Provider.of<LoginSignUpViewModel>(context,
                                listen: false)
                            .count
                        ? const Icon(Icons.visibility, color: Colors.white)
                        : const Icon(Icons.visibility_off, color: Colors.white),
                  ),
                ),
                // validator: (value) {
                //   if (value!.isEmpty || value == '') {
                //     return 'Please enter Password';
                //   } else {
                //     password = value;
                //     return null;
                //   }
                // },
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.005),
            InkWell(
              onTap: () {
                (_userNameController.text == '' ||
                        _userNameController.text.isEmpty)
                    ? showFlushBar(context)
                    : Provider.of<LoginSignUpViewModel>(context, listen: false)
                        .forgotPassword(_userNameController.text, context);
              },
              child: Text(
                'Forgot Password',
                // textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 30),
                  child: Container(
                    child: AnimatedButton(
                      height: 55,
                      width: 280,
                      text: 'Login',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(
                          fontSize: 18,
                          color: (themeProvider.darkTheme)
                              ? Colors.white
                              : Colors.black),
                      backgroundColor: (themeProvider.darkTheme)
                          ? Colors.black
                          : Colors.amberAccent,
                      borderColor: (themeProvider.darkTheme)
                          ? Colors.white
                          : Colors.amberAccent,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {
                        if (_userNameController.text == '') {
                          Flushbar(
                            duration: const Duration(seconds: 4),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            borderRadius: BorderRadius.circular(10),
                            icon: const Icon(Icons.error, color: Colors.white),
                            leftBarIndicatorColor: Colors.red,
                            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                            // title: 'Email',
                            message: 'Please Enter Email',
                            barBlur: 20,
                          ).show(context);
                        } else if (_passwordController.text == '') {
                          Flushbar(
                            duration: const Duration(seconds: 4),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            borderRadius: BorderRadius.circular(10),
                            icon: const Icon(Icons.error, color: Colors.white),
                            leftBarIndicatorColor: Colors.red,
                            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                            // title: 'Email',
                            message: 'Please Enter Your Password To Continue',
                            barBlur: 20,
                          ).show(context);
                        } else {
                          Map<String, dynamic> data = {
                            'email': _userNameController.text,
                            'password': _passwordController.text,
                            // 'fcm_code': fcm,
                            // 'device_id': 'RP1A.200720.012'
                            // 'device_id': 'a738f0f522f72cba',
                            'device_id': 'd548149ffc125ebe' //My Device ID
                            // 'device_id':
                            //     'd8b64dad7d49653b' //Salim Sir's Device ID
                            // 'device_id': 'f944fc8f9ecc19ab' //Neeraj Sir's ID
                            // 'device_id': _identifier
                          };

                          if (kDebugMode) {
                            print('Credentials: $data');
                          }
                          FocusManager.instance.primaryFocus?.unfocus();

                          // FocusScope.of(context).unfocus();
                          Provider.of<LoginSignUpViewModel>(context,
                                  listen: false)
                              .loginApi(data, context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Don’t have any account?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.signup);
                  },
                  child: const Text(
                    'Sign Up',
                  ),
                ),
              ],
            ),

            SizedBox(height: SizeVariables.getHeight(context) * 0.05),

            Container(
              // height: SizeVariables.getHeight(context) * 0.1,
              height: 15.h,
              margin: const EdgeInsets.only(right: 30),
              width: double.infinity,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      'By clicking the button above, you will have agreed to our',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Terms & Conditions',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(width: SizeVariables.getWidth(context) * 0.01),
                      Text('and', style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(width: SizeVariables.getWidth(context) * 0.01),
                      Text('Privacy Policy',
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showFlushBar(BuildContext context) {
    return Flushbar(
      duration: const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(Icons.error, color: Colors.white),
      // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      title: 'Email',
      message: 'Please enter the email',
      barBlur: 20,
    ).show(context);
  }
}
