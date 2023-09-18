import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../../../utils/routes/routeNames.dart';
import '../../../../viewModel/toDoViewModel/todaysTask.dart';

class ToDoPieShimmer extends StatelessWidget {
  int? index;
  double? percent;
  int? taskCount;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodaysTaskList>(context).getToDoList;

    // TODO: implement build
    return Stack(
      children: [
        PieChart(PieChartData(
            borderData: FlBorderData(show: false),
            sectionsSpace: 5,
            centerSpaceRadius: 95,
            sections: [
              PieChartSectionData(
                  color: Colors.grey, title: '', value: 100, radius: 30)
            ])),
        Positioned(
          left: 0,
          top: SizeVariables.getHeight(context) * 0.14,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '0',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 70),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
