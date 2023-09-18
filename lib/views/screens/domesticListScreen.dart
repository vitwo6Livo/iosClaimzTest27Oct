import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/components/containerStyle.dart';
import '../config/mediaQuery.dart';

class DomesticListScreen extends StatefulWidget {
  // const TravelClaimList({Key? key}) : super(key: key);

  @override
  State<DomesticListScreen> createState() => _DomesticListScreenState();
}

class _DomesticListScreenState extends State<DomesticListScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: ListView(
          children: [
            Container(
              height: SizeVariables.getHeight(context) * 0.07,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02),
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02,
                        left: SizeVariables.getWidth(context) * 0.01),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Travel Claimlist Status',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeVariables.getHeight(context) * 0.9,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.17,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.001,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.035,
                                top: SizeVariables.getHeight(context) * 0.02,
                              ),
                              child: Container(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Travel Id: 1234567890',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 14, color: Colors.amber),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.26,
                                top: SizeVariables.getHeight(context) * 0.02,
                              ),
                              child: Container(
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '\₹12345676',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.amber,
                                              fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.461,
                              ),
                              child: Container(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Kolkata',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 16, color: Colors.amber),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Mumbai',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16, color: Colors.amber),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.45,
                              ),
                              child: Container(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '12/10/2022',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '15/10/2022',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.002,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.5,
                              ),
                              child: Container(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '10:30 AM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '10:00 PM',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.64,
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Icon(Icons.check_box,
                                      color: Colors.orangeAccent),
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Icon(Icons.do_disturb_on_rounded,
                                      color: Colors.orangeAccent),
                                ),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Icon(Icons.cancel,
                                      color: Colors.orangeAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.002,
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.002,
            ),
          ],
        ),
      ),
    );
  }
}
