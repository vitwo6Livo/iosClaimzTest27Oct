import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String emp;
  String total;
  int active;

  final charts.Color color;

  BarChartModel({
    required this.emp,
    required this.total,
    required this.active,
    required this.color,
  });
}
