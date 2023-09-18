import 'package:flutter/cupertino.dart';
import 'Resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}
