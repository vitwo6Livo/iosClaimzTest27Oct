import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class OrgHeaderWidget extends StatefulWidget {
  // const OrgHeaderWidget({Key? key}) : super(key: key);

  @override
  State<OrgHeaderWidget> createState() => _OrgHeaderWidgetState();
}

class _OrgHeaderWidgetState extends State<OrgHeaderWidget> {
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
                'Organization List',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
