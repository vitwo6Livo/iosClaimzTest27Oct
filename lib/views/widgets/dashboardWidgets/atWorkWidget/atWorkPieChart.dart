import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sizer/sizer.dart';
import '../../../../viewModel/attendanceViewModel.dart';
import '../../../config/mediaQuery.dart';
import '../../../../models/dashboardModel.dart';

class AtWorkPieChart extends StatefulWidget {
  final List<dynamic> attendaceViewModel;
  final bool isLoading;

  AtWorkPieChartState createState() => AtWorkPieChartState();

  AtWorkPieChart(this.attendaceViewModel, this.isLoading);
}

class AtWorkPieChartState extends State<AtWorkPieChart> {
  int present = 0;
  int absent = 0;
  int leave = 0;
  int checkOut = 0;
  int weekend = 0;

  @override
  void initState() {
    // TODO: implement initState
    calculateNumber();
    super.initState();
  }

  void calculateNumber() {
    for (int i = 0; i < widget.attendaceViewModel.length; i++) {
      if (widget.attendaceViewModel[i]['status'] == 'Absent' &&
          widget.attendaceViewModel[i]['checkout_time'] == '') {
        absent++;
      } else if (widget.attendaceViewModel[i]['status'] == 'Leave' &&
          widget.attendaceViewModel[i]['checkout_time'] == '') {
        leave++;
      } else if (widget.attendaceViewModel[i]['status'] == 'Present' &&
          widget.attendaceViewModel[i]['checkout_time'] == '') {
        present++;
      } else if (widget.attendaceViewModel[i]['status'] == 'Weekend' &&
          widget.attendaceViewModel[i]['checkout_time'] == '') {
        weekend++;
      } else {
        checkOut++;
      }
    }
    print('Data Couunnnntttttttttt: ${widget.attendaceViewModel.length}');
    print('Absenttttttt: $absent');
    print('Leaveeeeeeeee: $leave');
    print('Presenttttttt: $present');
    print('Checked Out: $checkOut');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Stack(
      children: [
        widget.isLoading == true
            ? PieChart(PieChartData(
                borderData: FlBorderData(show: false),
                sectionsSpace: 5,
                centerSpaceRadius: height > 750
                    ? 8.h
                    : height < 650
                        ? 9.h
                        : 7.h,
                sections: [
                    PieChartSectionData(
                        color: Colors.grey, title: '', value: 100, radius: 30)
                  ]))
            : PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 5,
                  centerSpaceRadius: height > 750
                      ? 8.h
                      : height < 650
                          ? 9.h
                          : 7.h,
                  sections: [
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 93, 238, 98),
                      title: present.toString(),
                      value: double.parse(present.toString()),
                      radius: 50,
                      // titleStyle: TextStyle(fontSize: index == 0 ? 25 : 16)
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 41, 139, 236),
                      title: leave.toString(),
                      value: double.parse(leave.toString()),
                      radius: 50,
                      // titleStyle: TextStyle(fontSize: index == 0 ? 25 : 16)
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      title: absent.toString(),
                      value: double.parse(absent.toString()),
                      radius: 50,
                      // titleStyle: TextStyle(fontSize: index == -1 ? 25 : 16)
                    ),
                    PieChartSectionData(
                      color: Colors.amber,
                      title: checkOut.toString(),
                      value: double.parse(checkOut.toString()),
                      radius: 50,
                      // titleStyle: TextStyle(fontSize: index == -1 ? 25 : 16)
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
                      title: weekend.toString(),
                      value: double.parse(weekend.toString()),
                      radius: 50,
                      // titleStyle: TextStyle(fontSize: index == -1 ? 25 : 16)
                    ),
                  ],
                ),
              ),
        Positioned(
          left: 0,
          top: height > 750
              ? 13.h
              : height < 650
                  ? 14.h
                  : 10.h,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: widget.isLoading == true
                    ? Text(
                        '0',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 30),
                      )
                    : Text(
                        present.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18.sp),
                      ),
              ),
              Text(
                'Present',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 10.sp),
              )
            ],
          ),
        ),
      ],
    );
  }
}
