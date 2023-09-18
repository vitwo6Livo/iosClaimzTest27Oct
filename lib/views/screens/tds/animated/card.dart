import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import '../../../config/appColors.dart';

class ContainerCard extends StatelessWidget {
  final double height;
  final Widget child;

  ContainerCard({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                  const Color.fromARGB(255, 122, 121, 121).withOpacity(0.2),
                  const Color.fromARGB(255, 130, 130, 130).withOpacity(0.2),
                ]
              : [
                  Color.fromARGB(107, 255, 254, 252),
                  Color.fromARGB(116, 255, 254, 252),
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

class ContainerNew extends StatelessWidget {
  final double height;
  final Widget child;

  ContainerNew({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(159, 75, 74, 74),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(12),
        ),
      ),
      child: child,
    );
  }
}
