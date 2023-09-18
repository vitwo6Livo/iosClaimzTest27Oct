import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';

class ProfileInfoContainer extends StatefulWidget {
  // const ProfileInfoContainer({Key? key}) : super(key: key);

  @override
  State<ProfileInfoContainer> createState() => _ProfileInfoContainerState();
}

class _ProfileInfoContainerState extends State<ProfileInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.025,
        right: SizeVariables.getWidth(context) * 0.025,
      ),
      child: Column(
        children: [
          ContainerStyle(
            height: SizeVariables.getHeight(context) * 0.13,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.027),
                  child: CircleAvatar(
                    radius: SizeVariables.getWidth(context) * 0.1,
                    backgroundColor: Colors.green,
                    backgroundImage:
                        const AssetImage('assets/img/profilePic.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.08,
                      top: SizeVariables.getHeight(context) * 0.034),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Joy Shil',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Flutter Developer',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.02,
          ),
          ContainerStyle(
            height: SizeVariables.getHeight(context) * 0.25,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02,
                      left: SizeVariables.getWidth(context) * 0.04),
                  child: Row(
                    children: [
                      FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Department:',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.1),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Primary Reporting:',
                              style: Theme.of(context).textTheme.bodyText2,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.09),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'IT',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.25),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Shaikh Salim Akhtar',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02,
                      left: SizeVariables.getHeight(context) * 0.02),
                  child: Row(
                    children: [
                      FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'EmpId:',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.2),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Secondary Reporting:',
                              style: Theme.of(context).textTheme.bodyText2,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'EMP000',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.2),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Shaikh Salim Akhtar',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02,
                      left: SizeVariables.getHeight(context) * 0.02),
                  child: Row(
                    children: [
                      FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Email:',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.22),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Contract:',
                              style: Theme.of(context).textTheme.bodyText2,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'jshil@vitwo.in',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.11),
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '+919062050556',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
