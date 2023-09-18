import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/routes/routeNames.dart';
import '../../../viewModel/logIn&signUpViewModel.dart';
import '../../config/mediaQuery.dart';

class Signupdetails_Screen extends StatefulWidget {
  final String verificationCode;
  final String empName;
  final String empEmail;

  Signupdetails_Screen(this.verificationCode, this.empName, this.empEmail);

  @override
  State<Signupdetails_Screen> createState() => _Signupdetails_ScreenState();
}

class _Signupdetails_ScreenState extends State<Signupdetails_Screen> {
  TextEditingController fullName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController v_Code = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    v_Code.text = widget.verificationCode;
    fullName.text = widget.empName;
    email.text = widget.empEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // v_Code.text = 'VITWO5674567';
    // fullName.text = 'Joy Shil';
    // email.text = 'jshil@vitwo.in';
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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
                'Please Sign Up in to continue',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 22,
                    ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.04,
              ),
              Container(
                child: TextFormField(
                  readOnly: true,
                  cursorColor: Colors.white,
                  controller: v_Code,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                      ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                    // hintText: 'Verification Code',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                child: TextFormField(
                  controller: fullName,
                  cursorColor: Colors.white,
                  // showCursor: false,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                    hintText: 'Full name',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xfff7B7B7B),
                        ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 188, 188, 188),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                child: TextFormField(
                  controller: email,
                  // showCursor: false,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                    hintText: 'ex@gmail.in',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xfff7B7B7B),
                        ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 188, 188, 188),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                child: TextFormField(
                  controller: password,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
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
                    hintText: 'create password',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xfff7B7B7B),
                        ),
                    prefixIcon: const Icon(
                      Icons.lock_person,
                      color: Color.fromARGB(255, 188, 188, 188),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                child: TextFormField(
                  controller: confirmPassword,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
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
                    hintText: 'Confirm Password',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xfff7B7B7B),
                        ),
                    prefixIcon: const Icon(
                      Icons.lock_person,
                      color: Color.fromARGB(255, 188, 188, 188),
                    ),
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
                            ? Icon(Icons.visibility, color: Colors.white)
                            : Icon(Icons.visibility_off, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.08,
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
                        text: 'Sign Up',
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
                          // Navigator.pushNamed(context, RouteNames.kycdetails);

                          Map<String, dynamic> data = {
                            'password': password.text,
                            'confirm_password': confirmPassword.text,
                            'email': email.text,
                            'verification_code': v_Code.text
                          };

                          Provider.of<LoginSignUpViewModel>(context,
                                  listen: false)
                              .accountCreation(data, widget.empName, context);
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
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.login);
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
