import 'package:flutter/material.dart';

class Theme {
  Color primaryColor;
  Theme({required this.primaryColor});
}

class Themes {
  Theme defaultTheme = Theme(primaryColor: Colors.lightBlueAccent);

  Theme get theme => defaultTheme;

  String headerFont1 = 'headerFont1';
  String headerFont2 = 'headerFont2';
}