import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/mediaQuery.dart';

class LeaveCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.03,
          right: SizeVariables.getWidth(context) * 0.03),
      margin: EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.02),
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 0.1,
      decoration: BoxDecoration(
          // color: Colors.amber,
          color: Colors.black,
          borderRadius:
              BorderRadius.circular(SizeVariables.getHeight(context) * 0.02),
          border:
              Border.all(color: Color.fromARGB(255, 123, 125, 125), width: 1)),
      child: Row(
        children: [
          // Center(child: Icon(Icons.circle, color: Colors.white)),
          Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: const Color.fromARGB(255, 120, 120, 120),
            child: Container(
              height: SizeVariables.getHeight(context) * 0.05,
              width: SizeVariables.getWidth(context) * 0.10,
              color: Colors.red,
              // child: Image.asset(path, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.05,
                  right: SizeVariables.getWidth(context) * 0.05),
              height: double.infinity,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: const Color.fromARGB(255, 120, 120, 120),
                    child: Container(
                      height: SizeVariables.getHeight(context) * 0.02,
                      width: SizeVariables.getWidth(context) * 0.8,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              // child: Text(leaveTypes,
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodyText2!
              //         .copyWith(fontSize: 16)),
            ),
          ),
          // Center(
          //   child: Text(
          //     leaveBalance.toString(),
          //     style: Theme.of(context).textTheme.bodyText1,
          //   ),
          // )
          Container(
            width: SizeVariables.getWidth(context) * 0.2,
            height: double.infinity,
            // color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: const Color.fromARGB(255, 120, 120, 120),
                  child: Container(
                    height: SizeVariables.getHeight(context) * 0.08,
                    width: SizeVariables.getWidth(context) * 0.1,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
