import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: 14),
        bodyText1: TextStyle(fontSize: 16),
        headline6: TextStyle(fontSize: 16),
        subtitle2: TextStyle(fontSize: 12),
        caption: TextStyle(fontSize: 14),
        subtitle1: TextStyle(fontSize: 16),
        headline5: TextStyle(fontSize: 16),
      ),
    );
  }
}
