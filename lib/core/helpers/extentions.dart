import 'package:flutter/material.dart';

extension BuildContextExtentions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
