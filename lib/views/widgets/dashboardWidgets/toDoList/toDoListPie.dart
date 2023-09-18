import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../../../utils/routes/routeNames.dart';
import '../../../../viewModel/toDoViewModel/todaysTask.dart';
import '../../../screens/taskListScreen.dart';

class ToDoListPie extends StatefulWidget {
  ToDoListPieState createState() => ToDoListPieState();
}

class ToDoListPieState extends State<ToDoListPie> {
  int? index;
  double? percent;
  int? taskCount;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodaysTaskList>(context).getToDoList;

    // TODO: implement build
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CustomBottomNavigation(3))),
      child: Stack(
        children: [
          PieChart(PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 5,
              centerSpaceRadius: !isClicked ? 70 : 75,
              sections: provider['today'].isEmpty &&
                      provider['upcoming'].isEmpty &&
                      provider['previous'].isEmpty
                  ? [
                      PieChartSectionData(
                          color: Colors.grey, title: '', value: 100, radius: 30)
                    ]
                  : [
                      PieChartSectionData(
                          color: Color.fromARGB(255, 103, 103, 101),
                          title: provider['upcoming'].length.toString(),
                          value: double.parse(
                              provider['upcoming'].length.toString()),
                          radius: index == 0 ? 15 : 20,
                          titleStyle:
                              TextStyle(fontSize: index == 0 ? 20 : 15)),
                      PieChartSectionData(
                          color: Color(0xffF59F23),
                          title: provider['today'].length.toString(),
                          // value: double.parse(provider['today'].length.toString()),
                          value:
                              double.parse(provider['today'].length.toString()),
                          radius: index == -1 ? 15 : 20,
                          titleStyle:
                              TextStyle(fontSize: index == -1 ? 20 : 15)),
                      PieChartSectionData(
                          color: Color.fromARGB(255, 224, 202, 4),
                          title: provider['previous'].length.toString(),
                          value: double.parse(
                              provider['previous'].length.toString()),
                          radius: index == 1 ? 15 : 20,
                          titleStyle: TextStyle(fontSize: index == 1 ? 20 : 15))
                    ])),
          Positioned(
            left: 0,
            top: SizeVariables.getHeight(context) * 0.08,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    // '11',
                    '${provider['upcoming'].length + provider['today'].length + provider['previous'].length}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: !isClicked ? 60 : 70),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
