import 'package:flutter/material.dart';

class NavigationController {
  static void navigateToNewReport(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/report');
  }

  static void navigateToConsult(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/consult');
  }
}
