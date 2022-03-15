import 'package:flutter/material.dart';

enum RestAPIEndPoint { get, put, post, delete, patch }

ThemeData lightTheme = ThemeData(
  fontFamily: 'Helvetica',
  primaryColor: const Color(0xFF0C54BE),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF0C54BE),
    secondary: Color(0xFFF5F9FD),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black),
  ),
);
