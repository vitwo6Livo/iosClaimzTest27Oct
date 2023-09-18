import 'package:flutter/material.dart';

class ManagerAttendance extends StatefulWidget {
  ManagerAttendanceState createState() => ManagerAttendanceState();
}

class ManagerAttendanceState extends State<ManagerAttendance> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(
          'Manager Attandance Approve',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
