import 'package:flutter/material.dart';
import '../../views/config/mediaQuery.dart';

class NewAlertDialog extends StatelessWidget {
  final Widget child;

  NewAlertDialog(this.child);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 104, 94, 94),
      title: Text(
        'Details',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      content: child,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Ok',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.amber)))
      ],
    );
  }
}
