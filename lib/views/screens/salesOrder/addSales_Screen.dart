// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Add_salesOder_Screen extends StatelessWidget {
  const Add_salesOder_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:
              Theme.of(context).appBarTheme.systemOverlayStyle?.statusBarColor,
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                "assets/icons/back button.svg",
              ),
            ),
            const SizedBox(width: 5),
            FittedBox(
              child: Text(
                'Sales Order',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 24,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
