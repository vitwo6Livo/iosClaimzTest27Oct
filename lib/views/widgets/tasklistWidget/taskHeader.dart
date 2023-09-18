import 'package:flutter/material.dart';

import '../../../res/components/buttonStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';

class TaskHeader extends StatefulWidget {
  const TaskHeader({Key? key}) : super(key: key);

  @override
  State<TaskHeader> createState() => _TaskHeaderState();
}

class _TaskHeaderState extends State<TaskHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.1,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.03,
                left: SizeVariables.getWidth(context) * 0.025),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Task List',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
