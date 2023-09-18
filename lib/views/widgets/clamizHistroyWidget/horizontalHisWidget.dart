import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';

class HorizontalHisWidget extends StatefulWidget {
  // const HorizontalHisWidget({Key? key}) : super(key: key);

  @override
  State<HorizontalHisWidget> createState() => _HorizontalHisWidgetState();
}

class _HorizontalHisWidgetState extends State<HorizontalHisWidget> {
  DateTime? _dateTime;
  DateFormat dateFormat = DateFormat('yyyy');
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String? selectedMonth;

  var myYears = "2022";
  List<String> year = ["2022", "2021", "2020", "2019", "2018"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   height: SizeVariables.getHeight(context) * 0.05,
        //   padding: EdgeInsets.only(
        //       left: SizeVariables.getWidth(context) *
        //           0.02), // width: double.infinity,
        //   // color: Colors.amber,
        //   child: InkWell(
        //     onTap: () {
        //       showDatePicker(
        //               context: context,
        //               initialDate: DateTime.now(),
        //               firstDate: DateTime(2010),
        //               lastDate: DateTime.now().add(const Duration(days: 365)))
        //           .then((date) {
        //         setState(() {
        //           _dateTime = date;
        //         });
        //         print('Date Time: ${dateFormat.format(_dateTime!)}');
        //       });
        //     },
        //     child: Padding(
        //       padding:  EdgeInsets.only(
        //         left: SizeVariables.getWidth(context)*0.7,
        //         right: SizeVariables.getWidth(context)*0.04,

        //       ),
        //       child: ContainerStyle(
        //         height: SizeVariables.getHeight(context) * 0.05,
        //         child: Center(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               FittedBox(
        //                 fit: BoxFit.contain,
        //                 child: Text(
        //                   _dateTime == null
        //                       ? 'Years'
        //                       : '${dateFormat.format(_dateTime!)}',
        //                   style: Theme.of(context).textTheme.bodyText1,
        //                 ),
        //               ),
        //               Container(
        //                 child: const Icon(
        //                   Icons.calendar_month_outlined,
        //                   color: Color(0xffF59F23),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: SizeVariables.getHeight(context) * 0.02,
        ),
        Padding(
          padding:
              EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.025),
          child: Container(
            height: SizeVariables.getHeight(context) * 0.1,
            // color: Colors.red,
            //width: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.04),

                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(174, 51, 51, 51),
                  radius: 40,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        months[index],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),

                // child: Container(
                //   height: SizeVariables.getHeight(context) * 0.16,
                //   width: SizeVariables.getWidth(context) * 0.33,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: ContainerStyle(
                //     height: double.infinity,
                //     child: Center(
                //       child: FittedBox(
                //         fit: BoxFit.contain,
                //         child: Text(
                //           months[index],
                //           style: Theme.of(context).textTheme.bodySmall,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ),
              itemCount: months.length,
            ),
          ),
        ),
      ],
    );
  }
}
