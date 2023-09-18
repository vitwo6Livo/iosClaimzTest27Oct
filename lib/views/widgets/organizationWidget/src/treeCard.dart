import 'dart:ui';

import 'package:flutter/material.dart';

class TreeCard extends StatelessWidget {
  // const ContainerStyle({Key? key}) : super(key: key);
  // final double height;
  final Widget child;
  final double? width;

  TreeCard({
    // required this.height,
    required this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.02),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(31, 185, 185, 185),
            border: const Border(
                bottom: BorderSide(width: 0.06),
                top: BorderSide(width: 0.06),
                right: BorderSide(width: 0.06),
                left: BorderSide(width: 0.06)),
          ),
          child: child,
        ),
      ),
    );
  }
}
