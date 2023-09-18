import 'dart:ui';

import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../config/mediaQuery.dart';

// import '../../config/mediaQuery.dart';
// import '../config/mediaQuery.dart';

class LeaveRequestManagerShimmer extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 1,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Column(
          children: [
            ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.15,
              child: Container(
                height: double.infinity,
                // color: Colors.green,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        width: double.infinity,
                        // color: Colors.red,
                        // padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: Container(
                                height: double.infinity,
                                // color: Colors.amber,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                          SizeVariables.getWidth(context) *
                                              0.01),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[400]!,
                                        highlightColor: const Color.fromARGB(
                                            255, 120, 120, 120),
                                        child: CircleAvatar(
                                            radius: SizeVariables.getWidth(
                                                    context) *
                                                0.08),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: double.infinity,
                                        // color: Colors.orange,
                                        padding: EdgeInsets.only(
                                            left: SizeVariables.getWidth(
                                                    context) *
                                                0.005,
                                            top: SizeVariables.getHeight(
                                                    context) *
                                                0.008),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor:
                                                    const Color.fromARGB(
                                                        255, 120, 120, 120),
                                                child: Container(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.2,
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.015,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey[400]!,
                                              highlightColor:
                                                  const Color.fromARGB(
                                                      255, 120, 120, 120),
                                              child: Container(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.2,
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.015,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        width: double.infinity,
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Container(
                                height: double.infinity,
                                // color: Colors.amber,
                                padding: EdgeInsets.all(
                                    SizeVariables.getWidth(context) * 0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.2,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.015,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Container(
                                height: double.infinity,
                                // color: Colors.red,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text('|',
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .bodyText2),
                                      // SizedBox(
                                      //     width:
                                      //         SizeVariables.getWidth(context) *
                                      //             0.005),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[400]!,
                                        highlightColor: const Color.fromARGB(
                                            255, 120, 120, 120),
                                        child: Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.015,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.01),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[400]!,
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 120, 120, 120),
                                            child: Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.2,
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.015,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 120, 120, 120),
                                  child: Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.2,
                                    height: SizeVariables.getHeight(context) *
                                        0.015,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02)
          ],
        ),
      ),
    );
  }
}
