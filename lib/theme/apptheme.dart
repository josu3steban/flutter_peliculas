import 'package:flutter/material.dart';

class AppTheme {

  static final Color primary    = Colors.indigo.shade900;
  static final Color secondary  = Colors.tealAccent.shade100;
  
  static final ThemeData lightTheme = ThemeData.light().copyWith(

    appBarTheme: AppBarTheme(
      color: primary
    ),
    
  );
}