import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';

class MenudedarWidget extends StatefulWidget {
  // const MenudedarWidget({Key? key}) : super(key: key);

  @override
  State<MenudedarWidget> createState() => _MenudedarWidgetState();
}

class _MenudedarWidgetState extends State<MenudedarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.10,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'My Menu',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
