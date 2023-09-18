import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class Pie_Card extends StatefulWidget {
  // const Pie_Card({Key? key}) : super(key: key);

  final Map<String, dynamic> pieStats;

  @override
  State<Pie_Card> createState() => _Pie_CardState();

  Pie_Card(this.pieStats);
}

class _Pie_CardState extends State<Pie_Card> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.05,
            ),
            height: SizeVariables.getHeight(context) * 0.08,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(show: false),
                startDegreeOffset: 450,
                sectionsSpace: 3,
                centerSpaceRadius: 20,
                sections: [
                  PieChartSectionData(
                    color: const Color.fromARGB(255, 10, 98, 13),
                    title: widget.pieStats['present'].toString(),
                    titleStyle: Theme.of(context).textTheme.bodyText1,
                    value: double.parse(widget.pieStats['present'].toString()),
                    radius: 30,
                  ),
                  PieChartSectionData(
                    color: const Color.fromARGB(255, 29, 108, 187),
                    title: widget.pieStats['leave'].toString(),
                    titleStyle: Theme.of(context).textTheme.bodyText1,
                    value: double.parse(widget.pieStats['leave'].toString()),
                    radius: 30,
                  ),
                  PieChartSectionData(
                    color: const Color.fromARGB(255, 148, 25, 16),
                    title: widget.pieStats['absent'].toString(),
                    titleStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                        ),
                    value: double.parse(widget.pieStats['absent'].toString()),
                    radius: 30,
                  ),
                  PieChartSectionData(
                    color: const Color.fromARGB(255, 181, 140, 18),
                    title: widget.pieStats['checkout'].toString(),
                    value: double.parse(widget.pieStats['checkout'].toString()),
                    titleStyle: Theme.of(context).textTheme.bodyText1,
                    radius: 30,
                  ),
                  // PieChartSectionData(
                  //   color: Colors.grey,
                  //   // title: weekend.toString(),
                  //   value: 25,
                  //   radius: 50,
                  //   // titleStyle: TextStyle(fontSize: index == -1 ? 25 : 16)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
