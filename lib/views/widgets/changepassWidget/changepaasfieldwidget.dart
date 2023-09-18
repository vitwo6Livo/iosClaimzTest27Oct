import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../viewModel/logIn&signUpViewModel.dart';
import '../../config/mediaQuery.dart';

class changepaasfieldwidget extends StatefulWidget {
  const changepaasfieldwidget({Key? key}) : super(key: key);

  @override
  State<changepaasfieldwidget> createState() => _changepaasfieldwidgetState();
}

class _changepaasfieldwidgetState extends State<changepaasfieldwidget> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String name = '';
  String password = '';
  String newPassword = '';
  String confirmPassword = '';
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.06,
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // s
            Text(
              'New Password',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(right: 25),
              height: SizeVariables.getHeight(context) * 0.04,
              child: ContainerStyle(
                height: SizeVariables.getHeight(context) * 0.045,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _newPassword,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey),
                      // ),
                      // fillColor: Colors.grey,
                    ),
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please enter New Password';
                      } else {
                        newPassword = value;
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.03),
            Text(
              'Confirm Password',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(right: 25),
              height: SizeVariables.getHeight(context) * 0.04,
              child: ContainerStyle(
                height: SizeVariables.getHeight(context) * 0.045,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _confirmPassword,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey),
                      // ),
                      // fillColor: Colors.grey,
                    ),
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please enter confirm Password';
                      } else {
                        confirmPassword = value;
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Container(
                  child: AnimatedButton(
                    height: 45,
                    width: 100,
                    text: 'Submit',
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: TextStyle(
                        fontSize: 16,
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
                      Map<String, dynamic> _data = {
                        'password': _newPassword.text,
                        'confirm_password': _confirmPassword.text
                      };

                      if (kDebugMode) {
                        print('PASSWORD CHANGE DATA $_data');
                      }

                      Provider.of<LoginSignUpViewModel>(context, listen: false)
                          .changePassword(_data, context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
