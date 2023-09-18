import 'package:flutter/material.dart';

class HomeButtonObserver with WidgetsBindingObserver {
  final Function() onHomeButtonPressed;

  HomeButtonObserver({required this.onHomeButtonPressed}) {
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // onHomeButtonPressed();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        onHomeButtonPressed();
      });
    }
  }

  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
  }
}
