import 'dart:io';

import 'string_ext.dart';

extension FileSystemEntityExt on FileSystemEntity {
  String get fileName => path.substringAfterLast(Platform.pathSeparator, "");
}
