import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/mediaQuery.dart';

class AnnouncementShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // color: Colors.amber,
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.025,
        right: SizeVariables.getWidth(context) * 0.025,
      ),
      child: Container(
        // color: Colors.blue,
        height: SizeVariables.getHeight(context) * 0.99,
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            // height: SizeVariables.getHeight(context) * 0.1,
            // height: SizeVariables.getHeight(context) * 0.99,
            margin:
                EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.02),
            height: SizeVariables.getHeight(context) * 0.18,
            width: double.infinity,
            // color: Colors.red,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: double.infinity,
                    // color: Colors.orange,
                    padding: EdgeInsets.all(
                        SizeVariables.getHeight(context) * 0.005),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: CircleAvatar(
                            radius: SizeVariables.getWidth(context) * 0.1,
                            backgroundImage:
                                const AssetImage('assets/img/profilePic.jpg'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: double.infinity,
                    // color: Colors.pink,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            width: double.infinity,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 120, 120, 120),
                                  child: Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.4,
                                    height:
                                        SizeVariables.getHeight(context) * 0.02,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.01),
                                Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: const Color.fromARGB(
                                        255, 120, 120, 120),
                                    child: Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.2,
                                      height: SizeVariables.getHeight(context) *
                                          0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor:
                                    const Color.fromARGB(255, 120, 120, 120),
                                child: Container(
                                  width: SizeVariables.getWidth(context) * 0.3,
                                  height:
                                      SizeVariables.getHeight(context) * 0.012,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
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
                                            0.6,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.015,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: const Color.fromARGB(
                                        255, 120, 120, 120),
                                    child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.6,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.015,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: const Color.fromARGB(
                                        255, 120, 120, 120),
                                    child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.6,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.015,
                                        color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          itemCount: 4,
        ),
      ),
    );
  }
}
