import 'package:claimz/main.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';
import '../widgets/regularisationWidget/regularisationContainer.dart';
import 'package:provider/provider.dart';

class RegularisationScreen extends StatefulWidget {
  // const RegularisationScreen({Key? key}) : super(key: key);
  String date;

  @override
  State<RegularisationScreen> createState() => _RegularisationScreenState();

  RegularisationScreen(this.date);
}

class _RegularisationScreenState extends State<RegularisationScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: [
        // Image.asset(
        //   "assets/img/bg.png",
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.02,
              right: SizeVariables.getWidth(context) * 0.02,
            ),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.025,
                    left: SizeVariables.getWidth(context) * 0.015,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.02,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Regularisation',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: (themeProvider.darkTheme)
                                ? Color.fromARGB(168, 94, 92, 92)
                                : Colors.amberAccent,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.viewRegularisations);
                          },
                          child: Text('View ',
                              style: (themeProvider.darkTheme)
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: Color(0xffF59F23),
                                      )
                                  : TextStyle(
                                      color: Colors.black,
                                    )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getWidth(context) * 0.03,
                ),
                RegularisationContainer(widget.date),
                // SizedBox(
                //   height: SizeVariables.getHeight(context) * 0.03,
                // ),
                // AttscreenWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
