import 'package:flutter/material.dart';

class SizeVariables {
  // late double height;
  // late double width;

  // void init(context) {
  //   height = MediaQuery.of(context).size.height * 1;
  //   width = MediaQuery.of(context).size.width * 1;
  // }

  static double getHeight(context) {
    return MediaQuery.of(context).size.height * 1;
  }

  static double getWidth(context) {
    return MediaQuery.of(context).size.width * 1;
  }
}
