import 'dart:ui';

import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../views/config/appColors.dart';
import 'package:provider/provider.dart';

class ContainerStyle extends StatelessWidget {
  final double height;
  final Widget child;

  ContainerStyle({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(width * 0.02),
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //     child: Container(
    //       width: width,
    //       height: height,
    //       decoration: BoxDecoration(
    //         color: themeProvider.darkTheme ? Theme.of(context).colorScheme.background : const Color(0xfffffefc),
    //         border: const Border(
    //             bottom: BorderSide(width: 0.06),
    //             top: BorderSide(width: 0.06),
    //             right: BorderSide(width: 0.06),
    //             left: BorderSide(width: 0.06)),
    //             boxShadow: const [
    //               BoxShadow(
    //                 color: Color.fromARGB(255, 206, 205, 205),
    //                 spreadRadius: 2.0
    //               )
    //             ]
    //       ),
    //       child: child,
    //     ),
    //   ),
    // );

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
              ? [AppColors.gradientStartColor, AppColors.gradientEndColor]
              : [
                  Color(0xfffffefc),
                  Color(0xfffffefc),
                ],
          stops: const [0.1, 1]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.borderGradientStartColor,
          AppColors.borderGradientEndColor,
        ],
      ),
      child: child,
    );
  }
}
