// ignore_for_file: prefer_const_constructors

import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class EdittaskHeader extends StatefulWidget {
  // const EdittaskHeader({Key? key}) : super(key: key);

  @override
  State<EdittaskHeader> createState() => _EdittaskHeaderState();
}

class _EdittaskHeaderState extends State<EdittaskHeader> {
  String type_selected = "";

  var types = "No Category";

  List<String> type = [
    "No Category",
    "work",
    "Personal",
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      iconSize: 30,
      icon: Icon(
        Icons.expand_more,
        color: Colors.white,
      ),
      dropdownColor: Colors.black87,
      onChanged: (value) {
        types = value!;
        setState(() {
          type_selected = value.toString();
          print(value.toString());
        });
      },
      value: types,
      items: type.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Padding(
            padding:
                EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.04),
            child: Text(
              item,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }
}
