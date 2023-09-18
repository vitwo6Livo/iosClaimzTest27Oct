import 'dart:ui';

import 'package:claimz/models/ChartSampleData.dart';
import 'package:claimz/views/config/appColors.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/routes/routeNames.dart';

class ClaimzStatus_card extends StatelessWidget {
  final String title;
  final int number;
  final int total;

  ClaimzStatus_card({
    Key? key,
    required this.title,
    required this.number,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 120;
    double height = 140;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: GlassmorphicContainer(
        width: width,
        height: height,
        borderRadius: width * 0.05,
        border: 0.03,
        blur: 5,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.gradientStartColor, AppColors.gradientEndColor],
            stops: const [0.1, 1]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.borderGradientStartColor,
            AppColors.borderGradientEndColor
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                // color: Colors.amber,
                width: 200,
                height: 110,
                child: _buildElevationDoughnutChart(
                  title,
                  number.toString(),
                ),
              ),
              Container(
                // color: Colors.green,
                // height: SizeVariables.getHeight(context)*0.04,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the circular charts with center elevation dughnut series.
  SfCircularChart _buildElevationDoughnutChart(String title, String number) {
    return SfCircularChart(
      /// It used to set the annotation on circular chart.
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '100%',
            width: '100%',
            widget: PhysicalModel(
              shape: BoxShape.circle,
              elevation: 10,
              color: const Color.fromRGBO(230, 230, 230, 1),
              child: Container(),
            )),
        CircularChartAnnotation(
            widget: Text(number.toString(),
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 15)))
      ],
      series: _getElevationDoughnutSeries(
          int.parse(number.toString()), total - int.parse(number.toString())),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries(
      int gain, int left) {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'A',
                y: gain,
                // pointColor: const Color.fromRGBO(0, 220, 252, 1)
                pointColor: Colors.amber),
            ChartSampleData(
                x: 'B',
                y: left,
                pointColor: const Color.fromRGBO(230, 230, 230, 1))
          ],
          animationDuration: 0,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }
}
