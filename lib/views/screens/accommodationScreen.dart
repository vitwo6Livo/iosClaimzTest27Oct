import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/mediaQuery.dart';

class AccommodationScreen extends StatefulWidget {
  // const AccommodationScreen({Key? key}) : super(key: key);

  @override
  State<AccommodationScreen> createState() => _AccommodationScreenState();
}

class _AccommodationScreenState extends State<AccommodationScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: SvgPicture.asset('assetName'),
                            ),
                          ],
                        ),
                      ],
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
