import 'package:claimz/viewModel/logIn&signUpViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../provider/theme_provider.dart';
import '../../../config/mediaQuery.dart';

class BankDetails extends StatefulWidget {
  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController bank = new TextEditingController();
  TextEditingController re_bank = new TextEditingController();
  TextEditingController branch = new TextEditingController();
  TextEditingController ifsc = new TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    initialiseValues().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> initialiseValues() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String accountNumber = localStorage.getString('accountNumber') ?? '';

    String bankName = localStorage.getString('bankName') ?? '';

    String ifscCode = localStorage.getString('ifscCode') ?? '';

    String branchName = localStorage.getString('branchName') ?? '';

    bank = TextEditingController(text: accountNumber);
    re_bank = TextEditingController(text: bankName);
    ifsc = TextEditingController(text: ifscCode);
    branch = TextEditingController(text: branchName);
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: bank,
                    cursorColor: Colors.white,
                    // obscureText: true,
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
                      hintText: 'Account number',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.comment_bank,
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
                    controller: re_bank,
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
                      hintText: 'Bank Name',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.comment_bank,
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
                    controller: branch,
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
                      hintText: 'Branch',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.grid_view,
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
                    controller: ifsc,
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
                      hintText: 'IFSC code',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Color(0xfff7B7B7B),
                              ),
                      prefixIcon: const Icon(
                        Icons.data_array,
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

                            localStorage.setString('accountNumber', bank.text);
                            localStorage.setString('bankName', branch.text);
                            localStorage.setString('ifscCode', ifsc.text);
                            localStorage.setString('branchName', re_bank.text);

                            Provider.of<LoginSignUpViewModel>(context,
                                    listen: false)
                                .bankDetailsUpload({
                              'acc_no': bank.text,
                              'bank_branch': branch.text,
                              'ifsc': ifsc.text,
                              'branch': re_bank.text,
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
