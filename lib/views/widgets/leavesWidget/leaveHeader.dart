// import 'dart:html';

import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';
import '../../screens/requestLeaveScreen.dart';
import 'package:provider/provider.dart';

class LeaveHeader extends StatefulWidget {
  // const LeaveHeader({Key? key}) : super(key: key);

  @override
  State<LeaveHeader> createState() => _LeaveHeaderState();
}

class _LeaveHeaderState extends State<LeaveHeader> {
  // var paysilp = "2021-2022";
  // List<String> payYear = ["2021-2022", "2020-2021", "2019-2020", "2018-2019", "2017-2018"];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.02),
      child: Container(
        height: height > 800
            ? 10.h
            : height < 650
                ? 11.h
                : 13.h,
        // width: double.infinity,
        // color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Leaves',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),

                InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, RouteNames.requestleave);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RequestLeave(0, '', '', '', 0)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50
                          // topLeft: Radius.circular(10),
                          // topRight: Radius.circular(10),
                          // bottomLeft: Radius.circular(10),
                          // bottomRight: Radius.circular(10),
                          ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 71, 69, 69)
                                .withOpacity(0.4),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: Offset(5, 5),
                            blurStyle: BlurStyle.inner),
                      ],
                    ),
                    // color: Colors.amber,
                    // height: 100,
                    child: CircleAvatar(
                      backgroundColor: (themeProvider.darkTheme)
                          ? Color.fromARGB(255, 35, 35, 35)
                          : Theme.of(context).colorScheme.onPrimary,
                      // Color.fromARGB(255, 31, 31, 31),
                      radius: 30,
                      child: Text(
                        "Apply",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.only(left: SizeVariables.getWidth(context)*0.35),
                //   child: Container(
                //     height: SizeVariables.getHeight(context)*0.04,
                //     width: SizeVariables.getWidth(context)*0.27,
                //     child: AppButtonStyle(
                //       label: 'Apply',
                //       onPressed: () {
                //         Navigator.pushNamed(context, RouteNames.requestleave);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
            // FittedBox(
            //   fit: BoxFit.contain,
            //   child: DropdownButton<String>(
            //     iconSize: 35,
            //     icon: Icon(
            //       Icons.expand_more,
            //       color: Colors.white,
            //     ),
            //     dropdownColor: Colors.black87,
            //     onChanged: (value) {
            //       paysilp = value!;
            //       setState(() {

            //       });
            //     },
            //     value: paysilp,
            //     items: payYear.map((item) {
            //       return DropdownMenuItem(
            //         value: item,
            //         child: Text(item, style: TextStyle(color: Colors.white),));
            //       }).toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
