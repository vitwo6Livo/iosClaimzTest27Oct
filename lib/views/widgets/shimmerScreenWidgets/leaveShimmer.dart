import 'dart:ui';
import 'package:claimz/models/ChartSampleData.dart';
import 'package:claimz/views/config/appColors.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import '../../../../viewModel/leaveRemainingViewModel.dart';
import '../../../../res/components/containerStyle.dart';
import 'leaveCardShimmer.dart';

class LeaveShimmer extends StatefulWidget {
  LeaveShimmerState createState() => LeaveShimmerState();
}

class LeaveShimmerState extends State<LeaveShimmer> {
  @override
  Widget build(BuildContext context) {
    double width = 100;
    double height = 250;
    final provider = Provider.of<LeaveRemainingViewModel>(context).leaveBalance;
    final totalLeavesProvider =
        Provider.of<LeaveRemainingViewModel>(context).totalLeaves;

    return ContainerStyle(
      height: SizeVariables.getHeight(context) * 0.81,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.015,
                      left: SizeVariables.getWidth(context) * 0.04),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: const Color.fromARGB(255, 120, 120, 120),
                    child: Container(
                      height: SizeVariables.getHeight(context) * 0.05,
                      width: SizeVariables.getWidth(context) * 0.6,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Container(
                width: 300,
                height: 280,
                // color: Colors.red,
                child: _buildElevationDoughnutChart(0.0, 0.0)),
            Expanded(
                child: Container(
              width: double.infinity,
              // color: Colors.green,
              padding: EdgeInsets.all(SizeVariables.getHeight(context) * 0.02),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => LeaveCardShimmer(),
                  itemCount: 3),
            ))
          ],
        ),
      ),
    );
  }

  /// Returns the circular charts with center elevation dughnut series.
  SfCircularChart _buildElevationDoughnutChart(
      double provider, double balance) {
    return SfCircularChart(
      /// It used to set the annotation on circular chart.
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '130%',
            width: '130%',
            widget: PhysicalModel(
              shape: BoxShape.circle,
              elevation: 4,
              // color: const Color.fromRGBO(230, 230, 230, 1),
              color: Colors.black,
              child: Container(),
            )),
        CircularChartAnnotation(
            widget: Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: balance.toString() + '\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                        children: const [
                          TextSpan(
                            text: "of " + '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ]))))
      ],
      series: _getElevationDoughnutSeries(0, 0),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries(
      int gain, int left) {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'A', y: gain, pointColor: AppColors.buttonColor2),
            ChartSampleData(
                x: 'B',
                y: left,
                pointColor: const Color.fromRGBO(49, 49, 49, 54))
            //pointColor: Colors.black54)
          ],
          animationDuration: 0,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }
}
