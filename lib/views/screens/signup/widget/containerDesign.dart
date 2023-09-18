import 'package:claimz/views/config/appColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/theme_provider.dart';

class ContainerDesign extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;

  ContainerDesign({
    required this.height,
    required this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final themeProvider = Provider.of<ThemeProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.01),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: (themeProvider.darkTheme)
                ? [
                    Color.fromARGB(255, 230, 214, 214).withOpacity(0.1),
                    Color.fromARGB(255, 212, 209, 209).withOpacity(0.1),
                  ]
                : [
                    Color(0xfffffefc),
                    Color(0xfffffefc),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 38, 38, 38),
          ),
        ),
        child: child,
      ),
    );
  }
}
