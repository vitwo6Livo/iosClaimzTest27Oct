import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ClaimzHistoryShimmer extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 0.7,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                color: Colors.green,
                width: double.infinity,
                height: height > 750
                    ? 9.h
                    : height < 650
                        ? 10.h
                        : 9.h,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: const Color.fromARGB(255, 120, 120, 120),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
