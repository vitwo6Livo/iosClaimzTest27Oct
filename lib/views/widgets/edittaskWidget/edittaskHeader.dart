import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class EdittaskHeader extends StatefulWidget {
  // const EdittaskHeader({Key? key}) : super(key: key);

  @override
  State<EdittaskHeader> createState() => _EdittaskHeaderState();
}

class _EdittaskHeaderState extends State<EdittaskHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.10,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Edit Task',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
