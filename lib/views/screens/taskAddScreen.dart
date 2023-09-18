import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';
import '../widgets/taskaddWidget/taskaddContainer.dart';
// import '../widgets/taskaddWidget/taskaddHeader.dart';

class TaskAdd extends StatefulWidget {
  const TaskAdd({Key? key}) : super(key: key);

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   "assets/img/bg.png",
        //   height: MediaQuery.of(context).size.height * 1,
        //   width: MediaQuery.of(context).size.width * 1,
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
                      top: SizeVariables.getHeight(context) * 0.02),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(RouteNames.menu);
                        },
                        child: SvgPicture.asset(
                          "assets/icons/back button.svg",
                        ),
                      ),
                    ],
                  ),
                ),
                // taskaddHeader(),
                TaskaddContainer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
