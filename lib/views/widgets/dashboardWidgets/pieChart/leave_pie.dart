import 'dart:ui';
import 'package:claimz/models/ChartSampleData.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/views/config/appColors.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import '../../../../viewModel/leaveRemainingViewModel.dart';
import '../../../../res/components/containerStyle.dart';
import './pieChartCards.dart';

class LeavePie_card extends StatefulWidget {
  LeavePie_cardState createState() => LeavePie_cardState();
}

class LeavePie_cardState extends State<LeavePie_card> {
  @override
  Widget build(BuildContext context) {
    // double width = 100;
    // double height = 250;
    final provider = Provider.of<LeaveRemainingViewModel>(context).leaveBalance;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final totalLeavesProvider =
        Provider.of<LeaveRemainingViewModel>(context).totalLeaves;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      // color: Colors.red,
      child: ContainerStyle(
        height: height > 750
            ? 87.h
            : height < 650
                ? 104.h
                : 99.h,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.015,
                      left: SizeVariables.getWidth(context) * 0.04,
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Leave Summary',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height > 750
                    ? 0.h
                    : height < 650
                        ? 5.h
                        : 4.h,
              ),
              Container(
                height: height > 750
                    ? 30.h
                    : height < 650
                        ? 35.h
                        : 32.h,

                width: 300,
                // color: Colors.amber,

                // color: Colors.red,
                // child:
                //     _buildElevationDoughnutChart(provider, totalLeavesProvider),
                child: Stack(
                  children: [
                    PieChart(PieChartData(
                        borderData: FlBorderData(show: false),
                        startDegreeOffset: 270.0,
                        sectionsSpace: 5,
                        centerSpaceRadius: 95,
                        //centerSpaceColor: Color.fromARGB(255, 33, 33, 33),
                        centerSpaceColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        sections: [
                          PieChartSectionData(
                              color: Colors.black,
                              showTitle: false,
                              // title: provider['upcoming'].length.toString(),
                              value:
                                  double.parse(provider['total'].toString()) -
                                      totalLeavesProvider,
                              radius: 22,
                              titleStyle: const TextStyle(fontSize: 15)),
                          PieChartSectionData(
                              color: const Color(0xFFf59f23),
                              showTitle: false,
                              title: totalLeavesProvider.toString(),
                              value: totalLeavesProvider,
                              radius: 22,
                              titleStyle: const TextStyle(fontSize: 15)),
                        ])),
                    Positioned(
                      left: 0,
                      top: SizeVariables.getHeight(context) * 0.06,
                      right: 0,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.18,
                        // width: SizeVariables.getWidth(context) * 0.05,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(totalLeavesProvider.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold)),
                            Text('of',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15)),
                            Text(provider['total'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height > 750
                    ? 0.h
                    : height < 650
                        ? 5.h
                        : 5.h,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: height > 750
                      ? 30.h
                      : height < 650
                          ? 35.h
                          : 32.h,
                  // color: Colors.green,
                  padding:
                      EdgeInsets.all(SizeVariables.getHeight(context) * 0.01),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => PieChartCards(
                          provider['data'][index]['leave_types'],
                          provider['data'][index]['number'].toString(),
                          provider['data'][index]['image'],
                          provider['data'][index]['total_leave'].toString()),
                      itemCount: provider['data'].length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the circular charts with center elevation dughnut series.
  SfCircularChart _buildElevationDoughnutChart(
      Map<String, dynamic> provider, double balance) {
    return SfCircularChart(
      /// It used to set the annotation on circular chart.
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          height: '140%',
          width: '140%',
          widget: PhysicalModel(
            shape: BoxShape.circle,
            elevation: 4,
            // color: const Color.fromRGBO(230, 230, 230, 1),

            // color: Colors.black,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(),
          ),
        ),
        CircularChartAnnotation(
          widget: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: balance.toString() + '\n',
                style: TextStyle(
                  //color: Colors.white,
                  color: Theme.of(context).canvasColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                children: [
                  TextSpan(
                    text: "of " + provider['total'].toString(),
                    style: TextStyle(
                      // color: Colors.white,
                      color: Theme.of(context).canvasColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      series: _getElevationDoughnutSeries(
          int.parse(provider['total'].toString()),
          // int.parse(
          //   balance.toString().replaceAll(RegExp(r'.0'), ''),
          // ),
          balance),
    );
  }

  /// Returns the doughnut series which need to be center elevation.
  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries(
      int gain, double left) {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'A',
                y: gain,
                pointColor: const Color.fromRGBO(49, 49, 49, 54)),
            ChartSampleData(x: 'B', y: left, pointColor: AppColors.buttonColor2)
            //pointColor: Colors.black54)
          ],
          animationDuration: 0,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }
}
