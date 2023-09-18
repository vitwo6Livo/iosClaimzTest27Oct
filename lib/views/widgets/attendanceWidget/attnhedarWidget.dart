import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/components/buttonStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';

class AttnhedarWidget extends StatefulWidget {
  const AttnhedarWidget({Key? key}) : super(key: key);

  @override
  State<AttnhedarWidget> createState() => _AttnhedarWidgetState();
}

class _AttnhedarWidgetState extends State<AttnhedarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.07,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.02,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/back button.svg",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.024,
                      left: SizeVariables.getWidth(context) * 0.01),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Attendance',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.02,
            ),
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(168, 94, 92, 92),
                ),
                //     disabledColor: Colors.red,
                // disabledTextColor: Colors.black,
                // padding: const EdgeInsets.all(8),
                // textColor: Color(0xffF59F23),
                // color: Color.fromARGB(168, 81, 80, 80),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.attendancereport);
                },
                child: Text('View Report',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Color(0xffF59F23),
                        )),
              ),
              decoration: new BoxDecoration(
                // color: Color.fromARGB(168, 94, 92, 92),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 74, 74, 70),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),

          //   // child: AppButtonStyle(
          //   //   label: 'Attendance Report',
          //   //   onPressed: () {
          //   //     Navigator.pushNamed(context, RouteNames.attendancereport);
          //   //   },
          //   // ),
          // ),
        ],
      ),
    );
  }
}
