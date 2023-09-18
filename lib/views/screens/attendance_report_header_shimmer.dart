import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/components/containerStyle.dart';
import '../config/mediaQuery.dart';

class AttendanceReportHeaderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: mediaQuery.height * 0.08,
        //color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                height: double.infinity,
                // color: Colors.red,
                padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.5,
                        height: SizeVariables.getHeight(context) * 0.02,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.002),
                    // Column(
                    //   children: [
                    //     Shimmer.fromColors(
                    //       baseColor: Colors.grey[400]!,
                    //       highlightColor:
                    //           const Color.fromARGB(255, 120, 120, 120),
                    //       child: Container(
                    //         width: SizeVariables.getWidth(context) * 0.3,
                    //         height: SizeVariables.getHeight(context) * 0.015,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     // Text(
                    //     //   '-',
                    //     //   style: Theme.of(context).textTheme.bodyText1,
                    //     // ),
                    //     SizedBox(
                    //         height: SizeVariables.getHeight(context) * 0.002),

                    //     Shimmer.fromColors(
                    //       baseColor: Colors.grey[400]!,
                    //       highlightColor:
                    //           const Color.fromARGB(255, 120, 120, 120),
                    //       child: Container(
                    //         width: SizeVariables.getWidth(context) * 0.3,
                    //         height: SizeVariables.getHeight(context) * 0.015,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.01,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                height: double.infinity,
                // color: Colors.red,
                padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.5,
                        height: SizeVariables.getHeight(context) * 0.02,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.002),
                    // Column(
                    //   children: [
                    //     Shimmer.fromColors(
                    //       baseColor: Colors.grey[400]!,
                    //       highlightColor:
                    //           const Color.fromARGB(255, 120, 120, 120),
                    //       child: Container(
                    //         width: SizeVariables.getWidth(context) * 0.3,
                    //         height: SizeVariables.getHeight(context) * 0.015,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     // Text(
                    //     //   '-',
                    //     //   style: Theme.of(context).textTheme.bodyText1,
                    //     // ),
                    //     SizedBox(
                    //         height: SizeVariables.getHeight(context) * 0.002),

                    //     Shimmer.fromColors(
                    //       baseColor: Colors.grey[400]!,
                    //       highlightColor:
                    //           const Color.fromARGB(255, 120, 120, 120),
                    //       child: Container(
                    //         width: SizeVariables.getWidth(context) * 0.3,
                    //         height: SizeVariables.getHeight(context) * 0.015,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Row(
  //                 children: [
  //                   Flexible(
  //                     flex: 1,
  //                     fit: FlexFit.tight,
  //                     child: Container(
  //                       height: double.infinity,
  //                       // color: Colors.red,
  //                       padding: EdgeInsets.only(
  //                           left: SizeVariables.getWidth(context) * 0.05),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Shimmer.fromColors(
  //                             baseColor: Colors.grey[400]!,
  //                             highlightColor:
  //                                 const Color.fromARGB(255, 120, 120, 120),
  //                             child: Container(
  //                               width: SizeVariables.getWidth(context) * 0.25,
  //                               height:
  //                                   SizeVariables.getHeight(context) * 0.015,
  //                               color: Colors.grey,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                               height:
  //                                   SizeVariables.getHeight(context) * 0.002),
  //                           Column(
  //                             children: [
  //                               Shimmer.fromColors(
  //                                 baseColor: Colors.grey[400]!,
  //                                 highlightColor:
  //                                     const Color.fromARGB(255, 120, 120, 120),
  //                                 child: Container(
  //                                   width:
  //                                       SizeVariables.getWidth(context) * 0.3,
  //                                   height: SizeVariables.getHeight(context) *
  //                                       0.015,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                               // Text(
  //                               //   '-',
  //                               //   style: Theme.of(context).textTheme.bodyText1,
  //                               // ),
  //                               SizedBox(
  //                                   height: SizeVariables.getHeight(context) *
  //                                       0.002),

  //                               Shimmer.fromColors(
  //                                 baseColor: Colors.grey[400]!,
  //                                 highlightColor:
  //                                     const Color.fromARGB(255, 120, 120, 120),
  //                                 child: Container(
  //                                   width:
  //                                       SizeVariables.getWidth(context) * 0.3,
  //                                   height: SizeVariables.getHeight(context) *
  //                                       0.015,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Flexible(
  //                     flex: 1,
  //                     fit: FlexFit.tight,
  //                     child: Container(
  //                       height: double.infinity,
  //                       // color: Colors.red,
  //                       padding: EdgeInsets.only(
  //                           left: SizeVariables.getWidth(context) * 0.05),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Shimmer.fromColors(
  //                             baseColor: Colors.grey[400]!,
  //                             highlightColor:
  //                                 const Color.fromARGB(255, 120, 120, 120),
  //                             child: Container(
  //                               width: SizeVariables.getWidth(context) * 0.25,
  //                               height:
  //                                   SizeVariables.getHeight(context) * 0.015,
  //                               color: Colors.grey,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                               height:
  //                                   SizeVariables.getHeight(context) * 0.002),
  //                           Column(
  //                             children: [
  //                               Shimmer.fromColors(
  //                                 baseColor: Colors.grey[400]!,
  //                                 highlightColor:
  //                                     const Color.fromARGB(255, 120, 120, 120),
  //                                 child: Container(
  //                                   width:
  //                                       SizeVariables.getWidth(context) * 0.3,
  //                                   height: SizeVariables.getHeight(context) *
  //                                       0.015,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                               // Text(
  //                               //   '-',
  //                               //   style: Theme.of(context).textTheme.bodyText1,
  //                               // ),
  //                               SizedBox(
  //                                   height: SizeVariables.getHeight(context) *
  //                                       0.002),

  //                               Shimmer.fromColors(
  //                                 baseColor: Colors.grey[400]!,
  //                                 highlightColor:
  //                                     const Color.fromARGB(255, 120, 120, 120),
  //                                 child: Container(
  //                                   width:
  //                                       SizeVariables.getWidth(context) * 0.3,
  //                                   height: SizeVariables.getHeight(context) *
  //                                       0.015,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   // Flexible(
  //                   //   flex: 2,
  //                   //   fit: FlexFit.loose,
  //                   //   child: Container(
  //                   //     height: double.infinity,
  //                   //     // color: Colors.green,
  //                   //     padding: EdgeInsets.only(
  //                   //         left: SizeVariables.getWidth(context) * 0.05),
  //                   //     child: Column(
  //                   //       mainAxisAlignment: MainAxisAlignment.center,
  //                   //       crossAxisAlignment: CrossAxisAlignment.center,
  //                   //       children: [
  //                   //         Row(
  //                   //             mainAxisAlignment: MainAxisAlignment.start,
  //                   //             children: [
  //                   //               Shimmer.fromColors(
  //                   //                 baseColor: Colors.grey[400]!,
  //                   //                 highlightColor: const Color.fromARGB(
  //                   //                     255, 120, 120, 120),
  //                   //                 child: Container(
  //                   //                   width: SizeVariables.getWidth(context) *
  //                   //                       0.15,
  //                   //                   height: SizeVariables.getHeight(context) *
  //                   //                       0.04,
  //                   //                   color: Colors.grey,
  //                   //                 ),
  //                   //               ),
  //                   //               SizedBox(
  //                   //                   width: SizeVariables.getWidth(context) *
  //                   //                       0.01),
  //                   //               Column(
  //                   //                 children: [
  //                   //                   Text(
  //                   //                     'Day(s)',
  //                   //                     style: Theme.of(context)
  //                   //                         .textTheme
  //                   //                         .bodyText2!
  //                   //                         .copyWith(fontSize: 12),
  //                   //                   ),
  //                   //                 ],
  //                   //               )
  //                   //             ])
  //                   //       ],
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
}
