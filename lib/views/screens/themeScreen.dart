import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../config/mediaQuery.dart';

class ThemeScreen extends StatefulWidget {
  // const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool status3 = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.025,
                left: SizeVariables.getWidth(context) * 0.015,
              ),
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
                  SizedBox(
                    width: SizeVariables.getWidth(context) * 0.02,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Theme',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.01,
            ),
            Container(
              child: ListTile(
                leading: Container(
                  child: Icon(
                    Icons.bedtime_rounded,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
                title: (themeChange.darkTheme == true)
                    ? Text(
                        'Dark Theme',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    : Text(
                        'Light Theme',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                trailing: Container(
                  height: 27,
                  width: 50,
                  child: FlutterSwitch(
                    showOnOff: false,
                    activeTextColor: Colors.black,
                    inactiveTextColor: Colors.white,
                    value: themeChange.darkTheme,
                    onToggle: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
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
