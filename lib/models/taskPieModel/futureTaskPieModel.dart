import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../viewModel/toDoViewModel.dart';

class FutureData {
  final String name;
  final int? percent;
  final int? tasks;
  final Color color;

  FutureData(
      {this.name = 'Future',
      this.percent,
      this.tasks,
      this.color = Colors.amber});
}

class FuturePieData {
  List<FutureData> data = [];
}
