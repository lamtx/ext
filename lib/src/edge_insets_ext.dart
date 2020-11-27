import 'package:flutter/material.dart';

import 'int_ext.dart';

extension EdgeInsetsExt on EdgeInsets {
  EdgeInsets coerceAtLeast(EdgeInsets minimumValue) => EdgeInsets.only(
        left: left.coerceAtLeast(minimumValue.left),
        right: left.coerceAtLeast(minimumValue.right),
        top: left.coerceAtLeast(minimumValue.top),
        bottom: left.coerceAtLeast(minimumValue.bottom),
      );

  EdgeInsets coerceAtMost(EdgeInsets maximumValue) => EdgeInsets.only(
        left: left.coerceAtMost(maximumValue.left),
        right: left.coerceAtMost(maximumValue.right),
        top: left.coerceAtMost(maximumValue.top),
        bottom: left.coerceAtMost(maximumValue.bottom),
      );

  EdgeInsets get topInsets => EdgeInsets.only(top: top);

  EdgeInsets get bottomInsets => EdgeInsets.only(bottom: bottom);

  EdgeInsets get rightInsets => EdgeInsets.only(right: right);

  EdgeInsets get leftInsets => EdgeInsets.only(left: left);

  EdgeInsets get horizontalInsets => EdgeInsets.only(
        left: left,
        right: right,
      );

  EdgeInsets get vertical => EdgeInsets.only(
        top: top,
        bottom: bottom,
      );
}
