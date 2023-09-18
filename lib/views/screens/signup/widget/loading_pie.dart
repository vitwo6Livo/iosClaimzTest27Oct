import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartScreenState();
}

class PieChartScreenState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: 39,
      // color: Colors.amber,
      child: AspectRatio(
        aspectRatio: 1,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  PieChart(
                    swapAnimationCurve: Curves.linear,
                    swapAnimationDuration: const Duration(milliseconds: 500),
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      // centerSpaceColor: Colors.amber,

                      sectionsSpace: 0.9,
                      centerSpaceRadius: 15,
                      sections: showingSections(),
                    ),
                  ),
                  Positioned(
                    left: 1,
                    top: 13,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '70 %',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 8,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      // final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 5.0 : 7.0;
      const shadows = [Shadow(color: Colors.white, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xfffFDBE39),
            value: 70,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey,
            value: 30,
            title: '',
            radius: radius,
          );

        default:
          throw Error();
      }
    });
  }
}
