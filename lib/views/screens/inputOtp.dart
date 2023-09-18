import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../viewModel/logIn&signUpViewModel.dart';
// import '../bottomNavigation.dart';

class InputOTP extends StatefulWidget {
  final String email;
  InputOTPState createState() => InputOTPState();
  // final String email;

  // InputOTP(this.email);
  InputOTP(this.email);
}

class InputOTPState extends State<InputOTP> {
  final _focusFirst = FocusNode();
  final _focusSecond = FocusNode();
  final _focusThird = FocusNode();
  final _focusFourth = FocusNode();
  final _key = GlobalKey<FormState>();
  String? _firstPin;
  String? _secondPin;
  String? _thirdPin;
  String? _fourthPin;
  int seconds = 60;
  bool isTimer = true;
  Timer? timer;
  String? fcm;
  // bool isLoading = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _focusFirst.dispose();
    _focusSecond.dispose();
    _focusThird.dispose();
    _focusFourth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // var textScale = MediaQuery.of(context).textScaleFactor;
    bool tabLayout = width > 600;
    bool largeLayout = width > 350 && width < 600;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // final routes =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final mobile = routes['mobile'];
    // final name = routes['name'];
    // final flag = routes['flag'];
    // final addressDetails = routes['houseDetails'];
    // final streetName = routes['streetName'];

    // print('mobile: $mobile');
    // print('name: $name');
    // print('flag: $flag');
    // print('addressDetails: $addressDetails');
    // print('streetName: $streetName');

    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Form(
          key: _key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tabLayout
                  ? Container(
                      width: width * 0.15,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 62, 61, 61),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(1, 2))
                          ]),
                      child: TextFormField(
                        showCursor: true,
                        cursorHeight: height * 0.08,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: width * 0.1, color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_focusFirst),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        validator: (first) {
                          _firstPin = first;
                          return null;
                        },
                      ),
                    )
                  : largeLayout
                      ? Container(
                          width: width * 0.15,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: 45,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusFirst),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (first) {
                              _firstPin = first;
                              return null;
                            },
                          ),
                        )
                      : Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: height * 0.04,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusFirst),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (first) {
                              _firstPin = first;
                              return null;
                            },
                          ),
                        ),
              SizedBox(width: width * 0.04),
              tabLayout
                  ? Container(
                      width: width * 0.15,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 62, 61, 61),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(1, 2))
                          ]),
                      child: TextFormField(
                        showCursor: true,
                        cursorHeight: height * 0.08,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: width * 0.1, color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_focusSecond),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        validator: (second) {
                          _secondPin = second;
                          return null;
                        },
                      ),
                    )
                  : largeLayout
                      ? Container(
                          width: width * 0.15,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: 45,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusSecond),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (second) {
                              _secondPin = second;
                              return null;
                            },
                          ),
                        )
                      : Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: height * 0.04,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusSecond),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (second) {
                              _secondPin = second;
                              return null;
                            },
                          ),
                        ),
              SizedBox(width: width * 0.04),
              tabLayout
                  ? Container(
                      width: width * 0.15,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 62, 61, 61),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(1, 2))
                          ]),
                      child: TextFormField(
                        showCursor: true,
                        cursorHeight: height * 0.08,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: width * 0.1, color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_focusThird),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        validator: (third) {
                          _thirdPin = third;
                          return null;
                        },
                      ),
                    )
                  : largeLayout
                      ? Container(
                          width: width * 0.15,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: 45,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusThird),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (third) {
                              _thirdPin = third;
                              return null;
                            },
                          ),
                        )
                      : Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: height * 0.04,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusThird),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (third) {
                              _thirdPin = third;
                              return null;
                            },
                          ),
                        ),
              SizedBox(width: width * 0.04),
              tabLayout
                  ? Container(
                      width: width * 0.15,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 62, 61, 61),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(1, 2))
                          ]),
                      child: TextFormField(
                        showCursor: true,
                        cursorHeight: height * 0.08,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: width * 0.1),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_focusFourth),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        validator: (fourth) {
                          _fourthPin = fourth;
                          return null;
                        },
                      ),
                    )
                  : largeLayout
                      ? Container(
                          width: width * 0.15,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 62, 61, 61),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: 45,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusFourth),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (fourth) {
                              _fourthPin = fourth;
                              return null;
                            },
                          ),
                        )
                      : Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 173, 172, 172),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(1, 2))
                              ]),
                          child: TextFormField(
                            showCursor: true,
                            cursorHeight: height * 0.04,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 45, color: Colors.white),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_focusFourth),
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (fourth) {
                              _fourthPin = fourth;
                              return null;
                            },
                          ),
                        ),
            ],
          ),
        ),
        SizedBox(height: height * 0.045),
        Container(
          child: AnimatedButton(
            height: 50,
            width: 250,
            text: 'Validate',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            textStyle: TextStyle(
                fontSize: 16,
                color: (themeProvider.darkTheme) ? Colors.white : Colors.black),
            backgroundColor:
                (themeProvider.darkTheme) ? Colors.black : Colors.amberAccent,
            borderColor:
                (themeProvider.darkTheme) ? Colors.white : Colors.amberAccent,
            borderRadius: 8,
            borderWidth: 2,
            onPress: () {
              if (_key.currentState!.validate()) {
                var otp = _firstPin! + _secondPin! + _thirdPin! + _fourthPin!;
                Map<String, dynamic> _data = {
                  'otp': otp,
                  'email': widget.email
                };

                if (kDebugMode) {
                  print('DATAAAAAAAAAAA: $_data');
                }

                Provider.of<LoginSignUpViewModel>(context, listen: false)
                    .validateOtp(_data, context);
              }
            },
          ),
        ),
        SizedBox(height: height * 0.006),
      ],
    );
  }

  void checkOtpSignUp(String mobile, BuildContext context, String name,
      String addressDetails, String streetName) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();

    // hfjgjhgjkgk
    // kjhkjhkjhkjh
    // jnnklkjlkjl;j
    // lnljljlkjlkjlkjlkjlj

    //   var otp = _firstPin! + _secondPin! + _thirdPin! + _fourthPin!;
    //   var data = {'otp': otp, 'mobile': mobile};
    //   else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: const Text('Incorrect OTP',
    //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    //       backgroundColor: Colors.green,
    //       action: SnackBarAction(
    //           label: 'OK',
    //           onPressed: () =>
    //               ScaffoldMessenger.of(context).hideCurrentSnackBar()),
    //     ));
    //   }
  }
}



// void resendOtp(mobile) {
// }


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// // import '../bottomNavigation.dart';

// class InputOTP extends StatefulWidget {
//   InputOTPState createState() => InputOTPState();
//   // final String email;

//   // InputOTP(this.email);
// }

// class InputOTPState extends State<InputOTP> {
//   final _focusFirst = FocusNode();
//   final _focusSecond = FocusNode();
//   final _focusThird = FocusNode();
//   final _focusFourth = FocusNode();
//   final _key = GlobalKey<FormState>();
//   String? _firstPin;
//   String? _secondPin;
//   String? _thirdPin;
//   String? _fourthPin;
//   int seconds = 60;
//   bool isTimer = true;
//   Timer? timer;
//   String? fcm;
//   // bool isLoading = true;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _focusFirst.dispose();
//     _focusSecond.dispose();
//     _focusThird.dispose();
//     _focusFourth.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     // var textScale = MediaQuery.of(context).textScaleFactor;
//     bool tabLayout = width > 600;
//     bool largeLayout = width > 350 && width < 600;
//     // final routes =
//     //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     // final mobile = routes['mobile'];
//     // final name = routes['name'];
//     // final flag = routes['flag'];
//     // final addressDetails = routes['houseDetails'];
//     // final streetName = routes['streetName'];

//     // print('mobile: $mobile');
//     // print('name: $name');
//     // print('flag: $flag');
//     // print('addressDetails: $addressDetails');
//     // print('streetName: $streetName');

//     // TODO: implement build
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Form(
//           key: _key,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               tabLayout
//                   ? Container(
//                       width: width * 0.15,
//                       height: height * 0.1,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 62, 61, 61),
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.grey,
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 offset: Offset(1, 2))
//                           ]),
//                       child: TextFormField(
//                         showCursor: true,
//                         cursorHeight: height * 0.08,
//                         inputFormatters: [LengthLimitingTextInputFormatter(1)],
//                         keyboardType: TextInputType.number,
//                         style: TextStyle(fontSize: width * 0.1),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none),
//                         onFieldSubmitted: (_) =>
//                             FocusScope.of(context).requestFocus(_focusFirst),
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                         validator: (first) {
//                           _firstPin = first;
//                           return null;
//                         },
//                       ),
//                     )
//                   : largeLayout
//                       ? Container(
//                           width: width * 0.15,
//                           height: height * 0.075,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: 45,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusFirst),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (first) {
//                               _firstPin = first;
//                               return null;
//                             },
//                           ),
//                         )
//                       : Container(
//                           width: width * 0.15,
//                           height: height * 0.08,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: height * 0.04,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusFirst),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (first) {
//                               _firstPin = first;
//                               return null;
//                             },
//                           ),
//                         ),
//               SizedBox(width: width * 0.04),
//               tabLayout
//                   ? Container(
//                       width: width * 0.15,
//                       height: height * 0.1,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 62, 61, 61),
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.grey,
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 offset: Offset(1, 2))
//                           ]),
//                       child: TextFormField(
//                         showCursor: true,
//                         cursorHeight: height * 0.08,
//                         inputFormatters: [LengthLimitingTextInputFormatter(1)],
//                         keyboardType: TextInputType.number,
//                         style: TextStyle(fontSize: width * 0.1),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none),
//                         onFieldSubmitted: (_) =>
//                             FocusScope.of(context).requestFocus(_focusSecond),
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                         validator: (second) {
//                           _secondPin = second;
//                           return null;
//                         },
//                       ),
//                     )
//                   : largeLayout
//                       ? Container(
//                           width: width * 0.15,
//                           height: height * 0.075,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: 45,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusSecond),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (second) {
//                               _secondPin = second;
//                               return null;
//                             },
//                           ),
//                         )
//                       : Container(
//                           width: width * 0.15,
//                           height: height * 0.08,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: height * 0.04,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusSecond),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (second) {
//                               _secondPin = second;
//                               return null;
//                             },
//                           ),
//                         ),
//               SizedBox(width: width * 0.04),
//               tabLayout
//                   ? Container(
//                       width: width * 0.15,
//                       height: height * 0.1,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 62, 61, 61),
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.grey,
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 offset: Offset(1, 2))
//                           ]),
//                       child: TextFormField(
//                         showCursor: true,
//                         cursorHeight: height * 0.08,
//                         inputFormatters: [LengthLimitingTextInputFormatter(1)],
//                         keyboardType: TextInputType.number,
//                         style: TextStyle(fontSize: width * 0.1),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none),
//                         onFieldSubmitted: (_) =>
//                             FocusScope.of(context).requestFocus(_focusThird),
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                         validator: (third) {
//                           _thirdPin = third;
//                           return null;
//                         },
//                       ),
//                     )
//                   : largeLayout
//                       ? Container(
//                           width: width * 0.15,
//                           height: height * 0.075,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: 45,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusThird),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (third) {
//                               _thirdPin = third;
//                               return null;
//                             },
//                           ),
//                         )
//                       : Container(
//                           width: width * 0.15,
//                           height: height * 0.08,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: height * 0.04,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusThird),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (third) {
//                               _thirdPin = third;
//                               return null;
//                             },
//                           ),
//                         ),
//               SizedBox(width: width * 0.04),
//               tabLayout
//                   ? Container(
//                       width: width * 0.15,
//                       height: height * 0.1,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 62, 61, 61),
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.grey,
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 offset: Offset(1, 2))
//                           ]),
//                       child: TextFormField(
//                         showCursor: true,
//                         cursorHeight: height * 0.08,
//                         inputFormatters: [LengthLimitingTextInputFormatter(1)],
//                         keyboardType: TextInputType.number,
//                         style: TextStyle(fontSize: width * 0.1),
//                         textAlign: TextAlign.center,
//                         decoration: const InputDecoration(
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none),
//                         onFieldSubmitted: (_) =>
//                             FocusScope.of(context).requestFocus(_focusFourth),
//                         onChanged: (value) {
//                           if (value.length == 1) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                         validator: (fourth) {
//                           _fourthPin = fourth;
//                           return null;
//                         },
//                       ),
//                     )
//                   : largeLayout
//                       ? Container(
//                           width: width * 0.15,
//                           height: height * 0.075,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 62, 61, 61),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: 45,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusFourth),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (fourth) {
//                               _fourthPin = fourth;
//                               return null;
//                             },
//                           ),
//                         )
//                       : Container(
//                           width: width * 0.15,
//                           height: height * 0.08,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey,
//                                     spreadRadius: 2,
//                                     blurRadius: 10,
//                                     offset: Offset(1, 2))
//                               ]),
//                           child: TextFormField(
//                             showCursor: true,
//                             cursorHeight: height * 0.04,
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(1)
//                             ],
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(fontSize: 45),
//                             textAlign: TextAlign.center,
//                             decoration: const InputDecoration(
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none),
//                             onFieldSubmitted: (_) => FocusScope.of(context)
//                                 .requestFocus(_focusFourth),
//                             onChanged: (value) {
//                               if (value.length == 1) {
//                                 FocusScope.of(context).nextFocus();
//                               }
//                             },
//                             validator: (fourth) {
//                               _fourthPin = fourth;
//                               return null;
//                             },
//                           ),
//                         ),
//             ],
//           ),
//         ),
//         SizedBox(height: height * 0.045),
//         InkWell(
//           onTap: () {



//             // ..;l;.
//             // if (_key.currentState!.validate()) {
//             //   if (flag == '0') {
//             //     checkOtpSignIn(mobile, context);
//             //   } else {
//             //     checkOtpSignUp(
//             //         mobile, context, name, addressDetails, streetName);
//             //   }
//             // }
//           },
//           child: Container(
//             width: double.infinity,
//             height: height * 0.07,
//             margin: EdgeInsets.only(top: height * 0.02),
//             decoration: BoxDecoration(
//                 color: const Color.fromRGBO(57, 226, 14, 1),
//                 borderRadius: BorderRadius.circular(15)),
//             child: Center(
//               child: Text(
//                 'Validate',
//                 // textScaleFactor: textScaleFactor,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: tabLayout
//                         ? width * 0.03
//                         : largeLayout
//                             ? 18
//                             : 16),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: height * 0.006),
//       ],
//     );
//   }

//   void checkOtpSignUp(String mobile, BuildContext context, String name,
//       String addressDetails, String streetName) async {
//     // SharedPreferences localStorage = await SharedPreferences.getInstance();

//   // hfjgjhgjkgk
//   // kjhkjhkjhkjh
//   // jnnklkjlkjl;j
//   // lnljljlkjlkjlkjlkjlj

//   //   var otp = _firstPin! + _secondPin! + _thirdPin! + _fourthPin!;
//   //   var data = {'otp': otp, 'mobile': mobile};
//   //   else {
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: const Text('Incorrect OTP',
//   //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//   //       backgroundColor: Colors.green,
//   //       action: SnackBarAction(
//   //           label: 'OK',
//   //           onPressed: () =>
//   //               ScaffoldMessenger.of(context).hideCurrentSnackBar()),
//   //     ));
//   //   }
//   }
// }



// // void resendOtp(mobile) {
// // }
