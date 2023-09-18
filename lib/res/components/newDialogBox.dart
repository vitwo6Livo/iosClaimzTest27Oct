import 'package:flutter/material.dart';

class NewDialogBox extends StatelessWidget {
  final String title;
  final String message;

  NewDialogBox(this.title, this.message);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(title),
      content: Text(message),
    );
  }
}
