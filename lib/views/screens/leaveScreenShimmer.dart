import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/components/containerStyle.dart';
import '../config/mediaQuery.dart';

class LeaveScreenShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 1,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          children: [
            ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.12,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // color: Colors.red,
                child: Row(
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
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Container(
                                width: SizeVariables.getWidth(context) * 0.25,
                                height:
                                    SizeVariables.getHeight(context) * 0.015,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                                height:
                                    SizeVariables.getHeight(context) * 0.002),
                            Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 120, 120, 120),
                                  child: Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.3,
                                    height: SizeVariables.getHeight(context) *
                                        0.015,
                                    color: Colors.grey,
                                  ),
                                ),
                                // Text(
                                //   '-',
                                //   style: Theme.of(context).textTheme.bodyText1,
                                // ),
                                SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.002),

                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 120, 120, 120),
                                  child: Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.3,
                                    height: SizeVariables.getHeight(context) *
                                        0.015,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: Container(
                        height: double.infinity,
                        // color: Colors.green,
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: const Color.fromARGB(
                                        255, 120, 120, 120),
                                    child: Container(
                                      width: SizeVariables.getWidth(context) *
                                          0.15,
                                      height: SizeVariables.getHeight(context) *
                                          0.04,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.01),
                                  Column(
                                    children: [
                                      Text(
                                        'Day(s)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  )
                                ])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02)
          ],
        ),
        itemCount: 10,
      ),
    );
  }
}
