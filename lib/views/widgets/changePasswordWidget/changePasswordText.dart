import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class ChangePasswordText extends StatefulWidget {
  // const ChangePasswordText({Key? key}) : super(key: key);

  @override
  State<ChangePasswordText> createState() => _ChangePasswordTextState();
}

class _ChangePasswordTextState extends State<ChangePasswordText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.1,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.045,
                    top: SizeVariables.getHeight(context) * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Create New Password!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    // FittedBox(
                    //   fit: BoxFit.contain,
                    //   child: Text(
                    //     'Change Password',
                    //     style: TextStyle(
                    //       fontSize: 15,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
