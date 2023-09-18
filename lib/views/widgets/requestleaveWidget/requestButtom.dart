import 'package:flutter/material.dart';

import '../../../res/components/buttonStyle.dart';

class RequestButtom extends StatefulWidget {
  // const RequestButtom({Key? key}) : super(key: key);

  @override
  State<RequestButtom> createState() => _RequestButtomState();
}

class _RequestButtomState extends State<RequestButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AppButtonStyle(
          label: 'Submit',
          onPressed: () {},
        ),
      ),
    );
  }
}
