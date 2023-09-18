import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';
import '../widgets/changePasswordWidget/changePasswordField.dart';
import '../widgets/changePasswordWidget/changePasswordText.dart';

class ChangePassword extends StatefulWidget {
  // const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            //   image: DecorationImage(
            //   image: AssetImage("assets/img/bg.png"),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.03),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/back button.svg",
                    ),
                  ),
                  // ProfilededarWidget(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeVariables.getHeight(context) * 0.15,
                  left: SizeVariables.getWidth(context) * 0.03,
                  right: SizeVariables.getWidth(context) * 0.03),
              child: ContainerStyle(
                height: SizeVariables.getHeight(context) * 0.55,
                child: Column(
                  children: [
                    ChangePasswordField(),
                    // SizedBox(height: SizeVariables.getHeight(context)*0.01,),
                    ChangePasswordText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
