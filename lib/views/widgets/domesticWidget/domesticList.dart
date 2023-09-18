import 'package:flutter/material.dart';

class DomesticList extends StatefulWidget {
  const DomesticList({Key? key}) : super(key: key);

  @override
  State<DomesticList> createState() => _DomesticListState();
}

class _DomesticListState extends State<DomesticList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // padding: EdgeInsets.only(bottom: 53),
            color: Colors.amber,
            height: 140,
          ),
        ),
      ),
    );
  }
}
