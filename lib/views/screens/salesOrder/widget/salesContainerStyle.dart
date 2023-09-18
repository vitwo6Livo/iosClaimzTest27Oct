import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../config/appColors.dart';

class SalesContainer extends StatelessWidget {
  final Widget child;
  final double? width;

  SalesContainer({
    required this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: (themeProvider.darkTheme)
              ? [AppColors.gradientStartColor, AppColors.gradientEndColor]
              : [
                  Color(0xfffffefc),
                  Color(0xfffffefc),
                ],
          stops: const [0.1, 1],
        ),
      ),
      child: child,
    );
  }
}
