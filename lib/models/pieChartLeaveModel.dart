import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(leaves: 'Amber', percent: 70, color: Colors.amber),
    Data(leaves: 'Grey', percent: 30, color: Colors.grey)
  ];
}

class Data {
  final String? leaves;
  final double? percent;
  final Color? color;

  Data({this.leaves, this.percent, this.color});
}
