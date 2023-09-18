import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/mediaQuery.dart';

class IncidentalScreen extends StatefulWidget {
  // const IncidentalScreen({Key? key}) : super(key: key);

  @override
  State<IncidentalScreen> createState() => _IncidentalScreenState();
}

class _IncidentalScreenState extends State<IncidentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromARGB(206, 27, 26, 26),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeVariables.getHeight(context) * 0.05,
                  left: SizeVariables.getWidth(context) * 0.04,
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
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.15,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeVariables.getHeight(context) * 0.08,
                      left: SizeVariables.getWidth(context) * 0.03,
                      right: SizeVariables.getWidth(context) * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: Colors.white),
                    child: ListView(
                      children: [],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
