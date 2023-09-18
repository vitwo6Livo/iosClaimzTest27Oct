import 'package:claimz/models/dashboardModel.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/response/status.dart';
import '../../../res/components/containerStyle.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../config/mediaQuery.dart';
import 'package:intl/intl.dart';
import '../../../viewModel/holidayViewModel.dart';
import 'package:provider/provider.dart';

class UpcomingHolidaysShimmerState extends StatelessWidget {
  DateFormat dateFormat = DateFormat('EEE');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ContainerStyle(
      height: SizeVariables.getHeight(context) * 0.61,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.015,
                left: SizeVariables.getWidth(context) * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: const Color.fromARGB(255, 120, 120, 120),
                  child: Container(
                    height: SizeVariables.getHeight(context) * 0.05,
                    width: SizeVariables.getWidth(context) * 0.8,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeVariables.getHeight(context) * 0.005),
          Padding(
            padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.04,
                top: SizeVariables.getHeight(context) * 0.005,
                right: SizeVariables.getWidth(context) * 0.04),
            child: Container(
              height: SizeVariables.getHeight(context) * 0.53,
              // color: Colors.red,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.03,
                          // right: SizeVariables.getWidth(context) * 0.01
                        ),
                        margin: EdgeInsets.only(
                            bottom: SizeVariables.getHeight(context) * 0.02),
                        width: double.infinity,
                        height: SizeVariables.getHeight(context) * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                                SizeVariables.getHeight(context) * 0.02),
                            border: Border.all(
                                color: Color.fromARGB(255, 123, 125, 125),
                                width: 1)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.05,
                                    right:
                                        SizeVariables.getWidth(context) * 0.05),
                                height: double.infinity,
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.02,
                                        width: SizeVariables.getWidth(context) *
                                            0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.02,
                                        width: SizeVariables.getWidth(context) *
                                            0.2,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          SizeVariables.getHeight(context) *
                                              0.02),
                                      bottomRight: Radius.circular(
                                          SizeVariables.getHeight(context) *
                                              0.02)),
                                  child: Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.047,
                                    width:
                                        SizeVariables.getWidth(context) * 0.2,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  itemCount: 4),
            ),
          )
        ],
      ),
    );
  }
}
