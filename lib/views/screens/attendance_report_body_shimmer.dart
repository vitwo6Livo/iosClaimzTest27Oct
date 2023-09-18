import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../config/mediaQuery.dart';

class AttendanceReportBodyShimmer extends StatelessWidget {
  //const AttendanceReportBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      //color: Colors.amber,
      width: double.infinity,
      height: mediaQuery.height * 1,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.green,
              width: double.infinity,
              height: mediaQuery.height * 0.1,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: const Color.fromARGB(255, 120, 120, 120),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey,
                ),
              ),
            );
          }),
    );
  }
}
