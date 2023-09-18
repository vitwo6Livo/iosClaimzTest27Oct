import 'package:flutter/material.dart';
import '../../../../models/pieChartLeaveModel.dart';
import 'package:fl_chart/fl_chart.dart';

List<PieChartSectionData> getSection() => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      // final isTouched = index == touchedIndex;
      final double fontSize = 25;
      final double radius = 60;

      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: '${data.percent}',
        radius: radius,
      );
      return MapEntry(index, value);
    })
    .values
    .toList();
