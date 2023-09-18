import 'package:claimz/viewModel/logIn&signUpViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';
import '../../../../provider/theme_provider.dart';
import '../../../config/mediaQuery.dart';

class kycWidget extends StatefulWidget {
  final String name;

  kycWidget(this.name);

  @override
  State<kycWidget> createState() => _kycWidgetState();
}

class _kycWidgetState extends State<kycWidget> {
  TextEditingController kname = new TextEditingController();
  TextEditingController addhar = new TextEditingController();
  TextEditingController kphone = new TextEditingController();
  TextEditingController panCard = new TextEditingController();
  TextEditingController passport = new TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    kname.text = widget.name;
    print('KYC DETAILS');
    initialiseValues().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> initialiseValues() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('KYC DETAILSsssss');

    String aadharNumber = localStorage.getString('aadharNumber') ?? '';

    String phoneNumber = localStorage.getString('mobileNo') ?? '';

    String panCardNumber = localStorage.getString('panNo') ?? '';

    String passportNumber = localStorage.getString('passportNo') ?? '';

    addhar = TextEditingController(text: aadharNumber);
    kphone = TextEditingController(text: phoneNumber);
    panCard = TextEditingController(text: panCardNumber);
    passport = TextEditingController(text: passportNumber);
  }

  @override
  Widget build(BuildContext context) {
    // kname.text = 'XXX Shil';

    final themeProvider = Provider.of<ThemeProvider>(context);
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: TextFormField(
                    readOnly: true,
                    controller: kname,
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
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                      suffixIcon: const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.015,
                ),
                Container(
                  child: TextFormField(
                    readOnly: false,
                    controller: addhar,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                        ),
                    keyboardType: TextInputType.number,
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
                      hintText: 'Aadhar number',

                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.list_alt,
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                      // suffixIcon: const Icon(
                      //   Icons.done,
                      //   color: Colors.green,
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.015,
                ),
                Container(
                  child: TextFormField(
                    controller: kphone,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                        ),
                    keyboardType: TextInputType.number,
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
                      hintText: 'Phone number',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.015,
                ),
                Container(
                  child: TextFormField(
                    controller: panCard,
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
                      hintText: 'Pan number',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.list_alt,
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.015,
                ),
                Container(
                  child: TextFormField(
                    controller: passport,
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
                      hintText: 'Passport number',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.check_box_outline_blank,
                        color: Color.fromARGB(255, 188, 188, 188),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.03,
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
                          text: 'Save',
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
                          onPress: () async {
                            SharedPreferences localStorage =
                                await SharedPreferences.getInstance();

                            localStorage.setString('aadharNumber', addhar.text);
                            localStorage.setString('mobileNo', kphone.text);
                            localStorage.setString('panNo', panCard.text);
                            localStorage.setString('passportNo', passport.text);

                            Provider.of<LoginSignUpViewModel>(context,
                                    listen: false)
                                .kycDetailsUpload({
                              'name': widget.name,
                              'aadhaar_no': addhar.text,
                              'mobile_no': kphone.text,
                              'pan': panCard.text,
                              'passport_no': passport.text,
                              'candidate_id': localStorage.getInt('userId')
                            }, context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
