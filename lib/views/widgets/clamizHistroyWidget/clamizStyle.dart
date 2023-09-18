import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class ListWidget extends StatelessWidget {
  final double height;
  final Widget child;

  ListWidget({
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;

    // TODO: implement build
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: width * 0.02,
      border: 0.06,
      blur: 20,
      linearGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 37, 37, 37),
            Color.fromARGB(207, 65, 65, 65)
          ],
          stops: [
            0.1,
            1
          ]),
      borderGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 37, 37, 37),
          Color.fromARGB(207, 65, 65, 65)
        ],
      ),
      child: child,
    );
  }
}
