import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/mediaQuery.dart';

class PieChartCards extends StatelessWidget {
  String leaveTypes;
  // int totalLeaves;
  String leaveBalance;
  String path;
  String totalLeaves;

  PieChartCards(
      this.leaveTypes,
      // this.totalLeaves,
      this.leaveBalance,
      this.path,
      this.totalLeaves);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.03,
          right: SizeVariables.getWidth(context) * 0.03),
      margin: EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.02),
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 0.1,
      decoration: BoxDecoration(
          boxShadow: (themeProvider.darkTheme)
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 7,
                    //offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
          // color: Colors.amber,
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius:
              BorderRadius.circular(SizeVariables.getHeight(context) * 0.02),
          border: Border.all(
              color: Theme.of(context).colorScheme.outline, width: 1)),
      child: Row(
        children: [
          // Center(child: Icon(Icons.circle, color: Colors.white)),
          Container(
            height: SizeVariables.getHeight(context) * 0.05,
            width: SizeVariables.getWidth(context) * 0.10,
            // color: Colors.red,
            child: Image.asset(path, fit: BoxFit.cover),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.05,
                  right: SizeVariables.getWidth(context) * 0.05),
              height: double.infinity,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(leaveTypes,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2! //Tanay--- I have made this change of bang operator
                          .copyWith(
                            fontSize: 16,
                          )),
                  // Text('Total $totalLeaves leaves',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyText1!
                  //         .copyWith(color: Colors.grey)
                  //         )
                ],
              ),
            ),
          ),
          // Center(
          //   child: Text(
          //     leaveBalance.toString(),
          //     style: Theme.of(context).textTheme.bodyText1,
          //   ),
          // )
          Container(
            width: SizeVariables.getWidth(context) * 0.2,
            height: double.infinity,
            // color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(leaveBalance.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1! //Tanay--- I have made this change of bang operator
                        .copyWith(fontSize: 25)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('of',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: SizeVariables.getWidth(context) * 0.01),
                    Text(totalLeaves.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1! //Tanay---  I  have made this change of bang operator
                            .copyWith(
                              fontSize: 12,
                            ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
