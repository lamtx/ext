import 'package:flutter/widgets.dart';

extension NavigatorExt on NavigatorState {
  void popIf(RoutePredicate predicate) {
    var checked = false;
    popUntil((route) {
      if (checked) {
        return true;
      }
      checked = true;
      return !predicate(route);
    });
  }
}
