import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../views/config/appColors.dart';

class FlexContainerStyle extends StatelessWidget {
  final Widget child;

  FlexContainerStyle({required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;

    // TODO: implement build
    return GlassmorphicFlexContainer(
      borderRadius: width * 0.02,
      border: 0.06,
      blur: 15,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gradientStartColor, AppColors.gradientEndColor],
          stops: const [0.1, 1]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.borderGradientStartColor,
          AppColors.borderGradientEndColor
        ],
      ),
      child: child,
    );
  }
}
