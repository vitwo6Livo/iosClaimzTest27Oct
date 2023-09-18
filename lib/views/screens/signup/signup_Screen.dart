import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/viewModel/logIn&signUpViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';
import 'signupdetails_Screen.dart';

class Signup_Screen extends StatefulWidget {
  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  TextEditingController verificationCode = new TextEditingController();
  int _selection = 15;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final verfication =
        Provider.of<LoginSignUpViewModel>(context).verificationResponse;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.07,
                  right: SizeVariables.getWidth(context) * 0.1,
                  top: SizeVariables.getHeight(context) * 0.04,
                ),
                child: ListView(
                  children: [
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 46,
                          ),
                    ),
                    Text(
                      'Please Sign Up to continue',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 22,
                          ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.05,
                    ),
                    Container(
                      child: TextFormField(
                        showCursor: true,
                        controller: verificationCode,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xfffD9D9D9),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xfffD9D9D9),
                            ),
                          ),
                          hintText: 'Verification Code',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Color(0xfff7B7B7B),
                                  ),
                          prefixIcon: const Icon(
                            Icons.dataset,
                            color: Color.fromARGB(255, 188, 188, 188),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 35),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.verified_outlined,
                    //       color: Colors.green,
                    //       size: 30,
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Container(
                    //       width: SizeVariables.getWidth(context) * 0.74,
                    //       child: FittedBox(
                    //         fit: BoxFit.contain,
                    //         child: Text(
                    //           '6 Livo technologies private limited.',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText2!
                    //               .copyWith(
                    //                 fontSize: 20,
                    //               ),
                    //           // textAlign: TextAlign.justify,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25,
                          ),
                          child: Container(
                            child: AnimatedButton(
                              height: 55,
                              width: SizeVariables.getWidth(context) * 0.83,
                              text: verfication['status'] == 200
                                  ? 'Continue'
                                  : verfication == {}
                                      ? 'Verify'
                                      : 'Verify',
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
                              // onPress: () {
                              //   Navigator.pushNamed(
                              //       context, RouteNames.signupdetails);
                              // },
                              onPress: () async {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();

                                if (verificationCode.text == '') {
                                  Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    borderRadius: BorderRadius.circular(10),
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                    // title: 'An Error Occured',
                                    message: 'Please Enter Verfication Code',
                                    barBlur: 20,
                                  ).show(context);
                                } else {
                                  Provider.of<LoginSignUpViewModel>(context,
                                          listen: false)
                                      .verificationCode(
                                          verificationCode.text, context)
                                      .then((response) {
                                    if (response['data'] ==
                                        'You are already registered, Please login and continue') {
                                      Flushbar(
                                        duration: const Duration(seconds: 4),
                                        flushbarPosition:
                                            FlushbarPosition.BOTTOM,
                                        borderRadius: BorderRadius.circular(10),
                                        icon: const Icon(Icons.error,
                                            color: Colors.white),
                                        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                        // title: 'An Error Occured',
                                        message:
                                            'You are already registered, Please login to continue',
                                        barBlur: 20,
                                      ).show(context);
                                    } else if (response != {}) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (response['status'] == 200) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        // Navigator.pushNamed(
                                        //     context, RouteNames.signupdetails);

                                        localStorage.setString(
                                            'name',
                                            response['data']['emp_name']
                                                .toString());

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signupdetails_Screen(
                                                      response['data']
                                                          ['verification_code'],
                                                      response['data']
                                                          ['emp_name'],
                                                      response['data']['email'],
                                                      // response['data']['id'],
                                                    )));
                                      }
                                      // else if (response == {}) {

                                      // }
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      // Navigator.pushNamed(
                                      //     context, RouteNames.signupdetails);
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.login);
                          },
                          child: Text(
                            'Login',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.amber,
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
