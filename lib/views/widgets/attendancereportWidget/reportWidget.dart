import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/attendanceReportViewModel.dart';
import './reportTable.dart';

class ReportContainer extends StatefulWidget {
  // const ReportContainer({Key? key}) : super(key: key);

  @override
  State<ReportContainer> createState() => _ReportContainerState();
}

class _ReportContainerState extends State<ReportContainer> {
  var myMonth = "January";
  var myYears = "2022";
  bool isLoading = true;

  List<String> month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> month_num = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

  List<String> year = ["2022", "2021", "2020", "2019", "2018"];

  List<Map<String, dynamic>> attendanceType = [
    {'type': 'Present', 'count': '25'},
    {'type': 'Half Day', 'count': '25'},
    {'type': 'Leaves', 'count': '25'},
    {'type': 'Absent', 'count': '25'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeVariables.getHeight(context) * 0.01,
        left: SizeVariables.getWidth(context) * 0.05,
        right: SizeVariables.getWidth(context) * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: SizeVariables.getHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                  child: DropdownButton<String>(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.black87,
                    onChanged: (value) {
                      myMonth = value!;
                      print(value);

                      setState(() {});
                    },
                    value: myMonth,
                    items: month.map((item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.03),
                            child: Text(
                              item,
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: SizeVariables.getWidth(context) * 0.14,
                ),
                Container(
                  height: SizeVariables.getHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                  ),
                  child: DropdownButton<String>(
                    iconSize: 30,
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.black87,
                    onChanged: (value) {
                      print(value);
                      myYears = value!;
                      Map<String, dynamic> _data = {
                        'month': '8',
                        'year': myYears.toString()
                      };

                      // Provider.of<AttendanceReportViewModel>(context, listen: false).getAttendanceReport(_data);
                      setState(() {});
                    },
                    value: myYears,
                    items: year.map((item1) {
                      return DropdownMenuItem(
                          value: item1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.02),
                            child: Text(
                              item1,
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeVariables.getHeight(context) * 0.02),
          ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.1,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.red,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: double.infinity,
                              color: Colors.amber,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02,
                                  right:
                                      SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Colors.green,
                                    ),
                                    SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.002),
                                    Text(
                                      'Priviledge Leaves:',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      '15',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: double.infinity,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.green,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: double.infinity,
                              color: Colors.pink,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: double.infinity,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
