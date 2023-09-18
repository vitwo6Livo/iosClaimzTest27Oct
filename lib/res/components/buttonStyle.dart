import 'package:flutter/material.dart';
import '../../views/config/mediaQuery.dart';
import '../../views/config/appColors.dart';

class AppButtonStyle extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  AppButtonStyle(
      {required this.label, required this.onPressed, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? SizeVariables.getWidth(context) * 0.4,
        height: height ?? SizeVariables.getHeight(context) * 0.06,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
