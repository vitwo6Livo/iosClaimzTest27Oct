import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';
import '../widgets/taskEditWidget/taskEditContainer.dart';
import '../widgets/taskEditWidget/taskEditHeader.dart';

class EditTaskS extends StatefulWidget {
  // const EditTask({Key? key}) : super(key: key);

  @override
  State<EditTaskS> createState() => _EditTaskSState();
}

class _EditTaskSState extends State<EditTaskS> {
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
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/back button.svg",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.01,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Task Edit',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EdittaskHeader(),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.03,
                ),
                EdittaskContainer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
