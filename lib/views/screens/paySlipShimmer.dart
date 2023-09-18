// ignore_for_file: use_key_in_widget_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../config/mediaQuery.dart';

class PaySlipShimmer extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 180,
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.grey,
                    ],
                    stops: [
                      0.0,
                      0.1,
                      0.9,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.5,
                        height: SizeVariables.getHeight(context) * 0.02,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: const Color.fromARGB(255, 120, 120, 120),
              child: Container(
                width: SizeVariables.getWidth(context) * 0.8,
                height: SizeVariables.getHeight(context) * 0.035,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: const Color.fromARGB(255, 120, 120, 120),
              child: Container(
                width: SizeVariables.getWidth(context) * 0.8,
                height: SizeVariables.getHeight(context) * 0.03,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 95,
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.grey,
                    ],
                    stops: [
                      0.0,
                      0.1,
                      0.9,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.5,
                        height: SizeVariables.getHeight(context) * 0.02,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: const Color.fromARGB(255, 120, 120, 120),
              child: Container(
                width: SizeVariables.getWidth(context) * 0.8,
                height: SizeVariables.getHeight(context) * 0.04,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: const Color.fromARGB(255, 120, 120, 120),
              child: Container(
                width: SizeVariables.getWidth(context) * 0.8,
                height: SizeVariables.getHeight(context) * 0.04,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
