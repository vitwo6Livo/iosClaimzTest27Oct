import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../viewModel/toDoViewModel.dart';

class PastData {
  final String name;
  final int? percent;
  final int? tasks;
  final Color color;

  PastData(
      {this.name = 'Past', this.percent, this.tasks, this.color = Colors.red});
}

class PastPieData {
  List<PastData> data = [];
}
