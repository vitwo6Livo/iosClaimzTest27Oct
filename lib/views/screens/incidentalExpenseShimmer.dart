import 'dart:ui';

import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// import '../../config/mediaQuery.dart';
import '../config/mediaQuery.dart';

class IncidentalExpenseShimmer extends StatelessWidget {
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
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(SizeVariables.getWidth(context) * 0.02),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                    // color: Colors.amber,
                    width: double.infinity,
                    // height: 50,
                    margin: EdgeInsets.only(
                        bottom: SizeVariables.getHeight(context) * 0.01),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 181, 179, 179).withOpacity(0.1),
                      border: const Border(
                          bottom: BorderSide(width: 0.06),
                          top: BorderSide(width: 0.06),
                          right: BorderSide(width: 0.06),
                          left: BorderSide(width: 0.06)),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Color.fromARGB(255, 57, 57, 57),
                      //       blurRadius: 15,
                      //       spreadRadius: 1,
                      //       offset: Offset(1, 2))
                      // ]
                    ),
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.red,
                          width: double.infinity,
                          height: SizeVariables.getHeight(context) * 0.06,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  height: double.infinity,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
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
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: const Color.fromARGB(
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  height: double.infinity,
                                  // color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 50,
                                        child: FittedBox(
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
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.015,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          // color: Colors.red,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor:
                                    const Color.fromARGB(255, 120, 120, 120),
                                child: Container(
                                  width: SizeVariables.getWidth(context) * 0.2,
                                  height:
                                      SizeVariables.getHeight(context) * 0.015,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
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
                            ],
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02),
                        Container(
                          width: double.infinity,
                          height: SizeVariables.getHeight(context) * 0.04,
                          // color: Colors.red,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  height: double.infinity,
                                  // color: Colors.green,
                                  child: Row(
                                    children: [
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
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  height: double.infinity,
                                  // color: Colors.blue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01),
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       width: SizeVariables.getWidth(
                        //               context) *
                        //           0.4,
                        //       height: SizeVariables.getHeight(
                        //               context) *
                        //           0.02,
                        //       color: Colors.red,
                        //     ),
                        //   ],
                        // )
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeVariables.getWidth(context) * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: const Color.fromARGB(255, 103, 122, 114)
                                    .withOpacity(0.1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    top: 2.5,
                                    bottom: 2.5),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.4,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.015,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: SizeVariables.getWidth(context) * 0.05),
                            // InkWell(
                            //   onTap: () => showDialog(context: context, builder: (context) => AlertDialog(
                            //     title: Text('Approved By ${provider['data']
                            //                                       [
                            //                                       index]}'),
                            //   )),
                            //   child: Text('View Remarks',
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .bodyText1!
                            //           .copyWith(
                            //               fontSize: 12,
                            //               color: Colors.white)),
                            // )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02)
          ],
        ),
      ),
    );
  }
}
