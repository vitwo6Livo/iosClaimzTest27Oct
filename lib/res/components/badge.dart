import 'package:flutter/material.dart';
import '../../views/config/appColors.dart';
import '../../views/config/mediaQuery.dart';

class Badges extends StatelessWidget {
  // final double height;
  final String label;

  Badges(
      {
      // required this.height,
      required this.label});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CircleAvatar(
      backgroundColor: AppColors.badgeColor,
      radius: SizeVariables.getWidth(context) * 0.03,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
