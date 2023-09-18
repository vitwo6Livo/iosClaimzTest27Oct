import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

class BirthdayWidget extends StatelessWidget {
  final double height;
  final Widget child;

  BirthdayWidget({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: width * 0.02,
      border: 0.06,
      blur: 15,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: (themeProvider.darkTheme)
              ? [
                  Color.fromARGB(255, 100, 100, 100),
                  Color.fromARGB(255, 65, 65, 65)
                ]
              : [
                  Color.fromARGB(255, 223, 221, 221),
                  Color.fromARGB(255, 227, 224, 224),
                ],
          stops: [0.1, 1]),
      borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: (themeProvider.darkTheme)
              ? [
                  Color.fromARGB(255, 100, 100, 100),
                  Color.fromARGB(255, 65, 65, 65)
                ]
              : [
                  Color.fromARGB(255, 222, 220, 220),
                  Color.fromARGB(255, 212, 211, 211),
                ]),
      child: child,
    );
  }
}
