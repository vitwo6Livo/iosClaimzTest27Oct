import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import '../../../views/config/mediaQuery.dart';

class ReportTable extends StatefulWidget {
  const ReportTable({Key? key}) : super(key: key);

  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  List<Map<String, dynamic>> attendanceReport = [
    {
      'date': '26',
      'month': 'AUG',
      'in': '10:00',
      'out': '10:00',
      'duration': '0800'
    },
    {
      'date': '26',
      'month': 'AUG',
      'in': '10:00',
      'out': '10:00',
      'duration': '0800'
    },
    {
      'date': '26',
      'month': 'AUG',
      'in': '10:00',
      'out': '10:00',
      'duration': '0800'
    },
    {
      'date': '26',
      'month': 'AUG',
      'in': '10:00',
      'out': '10:00',
      'duration': '0800'
    },
    {
      'date': '26',
      'month': 'AUG',
      'in': '10:00',
      'out': '10:00',
      'duration': '0800'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.01),
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.only(
            left: SizeVariables.getWidth(context) * 0.01,
            top: SizeVariables.getHeight(context) * 0.01,
            right: SizeVariables.getWidth(context) * 0.01),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              ContainerStyle(
                  height: SizeVariables.getHeight(context) * 0.1,
                  child: Container(
                    height: double.infinity,
                    color: Colors.green,
                    // child: Row(
                    //   children: [

                    //   ],
                    // ),
                  )),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              )
            ],
          ),
          itemCount: 10,
        ),
      ),
    );
  }
}
