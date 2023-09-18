import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';
import '../widgets/edittaskWidget/edittaskContainer.dart';
import '../widgets/edittaskWidget/edittaskHeader.dart';

class EditTask extends StatefulWidget {
  // const EditTask({Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
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
          backgroundColor: Colors.transparent,
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
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/back button.svg",
                        ),
                      ),
                    ],
                  ),
                ),
                EdittaskHeader(),
                EdittaskContainer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
