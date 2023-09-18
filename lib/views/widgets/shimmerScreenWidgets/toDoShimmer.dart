import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';
import './toDoPieShimmer.dart';

class ToDoShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toDoList =
        Provider.of<TodaysTaskList>(context, listen: true).getToDoList;

    // TODO: implement build
    return ContainerStyle(
      height: SizeVariables.getHeight(context) * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.015,
                left: SizeVariables.getWidth(context) * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: const Color.fromARGB(255, 120, 120, 120),
                  child: Container(
                    height: SizeVariables.getHeight(context) * 0.04,
                    width: SizeVariables.getWidth(context) * 0.5,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeVariables.getHeight(context) * 0.01),
          Expanded(
            child: Container(
              // color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  // ToDoListPie()
                  Container(
                    height: SizeVariables.getHeight(context) * 0.38,
                    width: double.infinity,
                    // color: Colors.red,
                    child: ToDoPieShimmer(),
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Icon(Icons.circle,
                                  color: const Color(0xffF59F23),
                                  size: SizeVariables.getWidth(context) * 0.03),
                            ),
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Container(
                                height: SizeVariables.getHeight(context) * 0.02,
                                width: SizeVariables.getWidth(context) * 0.15,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Icon(Icons.circle,
                                  color: const Color.fromARGB(255, 224, 202, 4),
                                  size: SizeVariables.getWidth(context) * 0.03),
                            ),
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Container(
                                height: SizeVariables.getHeight(context) * 0.02,
                                width: SizeVariables.getWidth(context) * 0.15,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Icon(Icons.circle,
                                  color:
                                      const Color.fromARGB(255, 103, 103, 101),
                                  size: SizeVariables.getWidth(context) * 0.03),
                            ),
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Container(
                                height: SizeVariables.getHeight(context) * 0.02,
                                width: SizeVariables.getWidth(context) * 0.15,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          SizedBox(height: SizeVariables.getHeight(context) * 0.01),
          Padding(
            padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.04,
                top: SizeVariables.getHeight(context) * 0.005,
                right: SizeVariables.getWidth(context) * 0.04),
            child: SizedBox(
              height: SizeVariables.getHeight(context) * 0.28,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: const Color.fromARGB(255, 120, 120, 120),
                child: Container(
                  color: Colors.red,
                  margin: EdgeInsets.only(
                      bottom: SizeVariables.getHeight(context) * 0.02),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
