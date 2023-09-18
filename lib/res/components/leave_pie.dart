import 'dart:ui';
import 'package:claimz/models/ChartSampleData.dart';
import 'package:claimz/views/config/appColors.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import '../../viewModel/leaveRemainingViewModel.dart';
import 'containerStyle.dart';

class LeavePie_card extends StatefulWidget {
  LeavePie_cardState createState() => LeavePie_cardState();
}

class LeavePie_cardState extends State<LeavePie_card> {
  // final String number1;
  // final String number2;

  // const LeavePie_card({Key? key, required this.number1, required this.number2})
  //     : super(key: key);
  int totalLeaves = 0;
  int leaveBalance = 0;
  var provider;

  @override
  void initState() {
    // TODO: implement initState
    calculateTotalLeaves(context);
    balanceLeaves(context);
    super.initState();
  }

  int calculateTotalLeaves(BuildContext context) {
    var provider = Provider.of<LeaveRemainingViewModel>(context, listen: false)
        .leaveBalance;
    for (int indexTwo = 0;
        indexTwo < provider['data'][0][0].length;
        indexTwo++) {
      for (int index = 0; index <= indexTwo; index++) {
        totalLeaves += provider['data'][0][0][index]['total'] as int;
      }
    }
    print('Total Leaves: $totalLeaves');
    return totalLeaves;
  }

  int balanceLeaves(BuildContext context) {
    var provider = Provider.of<LeaveRemainingViewModel>(context, listen: false)
        .leaveBalance;
    for (int indexTwo = 0;
        indexTwo < provider['data'][0][0].length;
        indexTwo++) {
      for (int index = 0; index < provider['data'][0][0].length; index++) {
        leaveBalance += ((provider['data'][0][0][index]['total'] -
            provider['data'][0][0][index]['balance'])) as int;
      }
    }

    print('Leave Balance: $leaveBalance');
    return leaveBalance;
  }

  @override
  Widget build(BuildContext context) {
    double width = 100;
    double height = 250;
    final provider = Provider.of<LeaveRemainingViewModel>(context).leaveBalance;

    return ContainerStyle(
      height: SizeVariables.getHeight(context) * 0.9,
      child: Center(
        child: Column(
          children: [
            Container(
                width: 300,
                height: 280,
                // color: Colors.red,
                child: _buildElevationDoughnutChart(totalLeaves, leaveBalance)),
            Expanded(
                child: Container(
              width: double.infinity,
              // color: Colors.green,
              padding: EdgeInsets.all(SizeVariables.getHeight(context) * 0.02),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.03,
                        right: SizeVariables.getWidth(context) * 0.03),
                    margin: EdgeInsets.only(
                        bottom: SizeVariables.getHeight(context) * 0.02),
                    width: double.infinity,
                    height: SizeVariables.getHeight(context) * 0.1,
                    decoration: BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.circular(
                            SizeVariables.getHeight(context) * 0.02),
                        border: Border.all(color: Colors.blue, width: 2)),
                    child: Row(
                      children: [
                        // Center(child: Icon(Icons.circle, color: Colors.white)),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: SizeVariables.getWidth(context) * 0.02,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.05,
                                right: SizeVariables.getWidth(context) * 0.05),
                            height: double.infinity,
                            // color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(provider['data'][0][0][0]['name'],
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                Text(
                                    'Total ${provider['data'][0][0][0]['total']} leaves',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.grey))
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            provider['data'][0][0][0]['balance'].toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //       bottom: SizeVariables.getHeight(context) * 0.02),
                  //   width: double.infinity,
                  //   height: SizeVariables.getHeight(context) * 0.1,
                  //   decoration: BoxDecoration(
                  //       // color: Colors.amber,
                  //       borderRadius: BorderRadius.circular(
                  //           SizeVariables.getHeight(context) * 0.02),
                  //       border: Border.all(color: Colors.blue, width: 2)),
                  //       child: Row(
                  //     children: [
                  //       Center(child: Icon(Icons.circle, color: Colors.white)),
                  //       Expanded(
                  //         child: Container(
                  //           height: double.infinity,
                  //           color: Colors.red,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(provider['data'][0][0][1]['name'], style: Theme.of(context).textTheme.bodyText2),
                  //               Text('Total ${provider['data'][0][0][1]['total']} leaves',
                  //               style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //                 color: Colors.grey
                  //               ))
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Center(
                  //         child: Text(
                  //           provider['data'][0][0][1]['balance'].toString(),
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //       bottom: SizeVariables.getHeight(context) * 0.02),
                  //   width: double.infinity,
                  //   height: SizeVariables.getHeight(context) * 0.1,
                  //   decoration: BoxDecoration(
                  //       // color: Colors.amber,
                  //       borderRadius: BorderRadius.circular(
                  //           SizeVariables.getHeight(context) * 0.02),
                  //       border: Border.all(color: Colors.blue, width: 2)),
                  //       child: Row(
                  //     children: [
                  //       Center(child: Icon(Icons.circle, color: Colors.white)),
                  //       Expanded(
                  //         child: Container(
                  //           height: double.infinity,
                  //           color: Colors.red,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(provider['data'][0][0][2]['name'], style: Theme.of(context).textTheme.bodyText2),
                  //               Text('Total ${provider['data'][0][0][2]['total']} leaves',
                  //               style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //                 color: Colors.grey
                  //               ))
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Center(
                  //         child: Text(
                  //           provider['data'][0][0][2]['balance'].toString(),
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ))
            // ListView.builder(
            //   itemBuilder: (context, index) => Container(
            //     margin: EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.02),
            //     width: double.infinity,
            //     height: SizeVariables.getHeight(context) * 0.1,
            //     color: Colors.red,
            //   ),
            //   itemCount: 2)
          ],
        ),
      ),
    );
  }

  /// Returns the circular charts with center elevation dughnut series.
  SfCircularChart _buildElevationDoughnutChart(
      int totalLeaves, int leaveBalance) {
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
                    text: TextSpan(
                        text: leaveBalance.toString() + '\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        children: [
              TextSpan(
                text: "of " + totalLeaves.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ]))))
      ],
      series: _getElevationDoughnutSeries(
          int.parse(totalLeaves.toString()),
          int.parse(leaveBalance.toString()) -
              int.parse(totalLeaves.toString())),
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
