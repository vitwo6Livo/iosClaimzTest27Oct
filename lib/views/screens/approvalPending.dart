import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';

class ApprovalPending extends StatefulWidget {
  // const ApprovalPending({Key? key}) : super(key: key);

  @override
  State<ApprovalPending> createState() => _ApprovalPendingState();
}

class _ApprovalPendingState extends State<ApprovalPending> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   "assets/img/bg.png",
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.01),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/back button.svg",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Ragularisation History',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                      right: SizeVariables.getWidth(context) * 0.025),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.02,
                                right: SizeVariables.getWidth(context) * 0.1),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Category: Forgot to Sign in',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.16),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From Date: 19 Apr, 2022',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.22),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From Time: 10:30:00',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.27),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'To Time: 18:30:00',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.2),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Deception: Traffic jam',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                      right: SizeVariables.getWidth(context) * 0.025),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.02,
                                right: SizeVariables.getWidth(context) * 0.1),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Category: Forgot to Sign in',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.16),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From Date: 19 Apr, 2022',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.22),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From Time: 10:30:00',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.27),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'To Time: 18:30:00',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.2),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Deception: Traffic jam',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                      right: SizeVariables.getWidth(context) * 0.025),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.18,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.02,
                                right: SizeVariables.getWidth(context) * 0.1),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Category: Forgot to Sign in',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.16),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From Date: 19 Apr, 2022',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.22),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From Time: 10:30:00',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.27),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'To Time: 18:30:00',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.01,
                                right: SizeVariables.getWidth(context) * 0.2),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Deception: Traffic jam',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
