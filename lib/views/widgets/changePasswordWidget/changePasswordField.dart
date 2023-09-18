import 'package:flutter/material.dart';
import '../../../res/components/buttonStyle.dart';
import '../../config/mediaQuery.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/logIn&signUpViewModel.dart';

class ChangePasswordField extends StatefulWidget {
  const ChangePasswordField({Key? key}) : super(key: key);

  @override
  State<ChangePasswordField> createState() => _ChangePasswordFieldState();
}

class _ChangePasswordFieldState extends State<ChangePasswordField> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String name = '';
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.06,
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Old Password',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: SizeVariables.getHeight(context) * 0.01),
            // Container(
            //   margin: const EdgeInsets.only(right: 25),
            //   height: SizeVariables.getHeight(context) * 0.04,
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.grey),
            //       ),
            //       fillColor: Colors.grey,
            //     ),
            //     validator: (value) {
            //       if (value!.isEmpty || value == '') {
            //         return 'Please enter old passwod';
            //       } else {
            //         name = value;
            //         return null;
            //       }
            //     },
            //   ),
            // ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.03),
            const Text(
              'New Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(right: 25),
              height: SizeVariables.getHeight(context) * 0.04,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.grey,
                ),
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Please enter New Password';
                  } else {
                    password = value;
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.03),
            const Text(
              'Confirm Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.only(right: 25),
              height: SizeVariables.getHeight(context) * 0.04,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.grey,
                ),
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
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: AppButtonStyle(
                  label: 'Submit',
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      Map<String, dynamic> _data = {
                        'password': password,
                        'confirm_password': confirmPassword
                      };
                      Provider.of<LoginSignUpViewModel>(context, listen: false)
                          .changePassword(_data, context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
