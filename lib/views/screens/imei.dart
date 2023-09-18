import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

// void main() => runApp(new ImeiNumber());

class ImeiNumber extends StatefulWidget {
  @override
  _ImeiNumberState createState() => new _ImeiNumberState();
}

class _ImeiNumberState extends State<ImeiNumber> {
  String _identifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    // if (!mounted) return;

    _identifier = identifier;

    // setState(() {
    //   _identifier = identifier;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running on device with id: $_identifier\n'),
        ),
      ),
    );
  }
}
