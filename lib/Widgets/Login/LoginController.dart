import 'package:flutter/material.dart';

class LoginController {
  List<Widget> listWidget = [];

  int count = 1;
  Widget getWidget() {
    return Text(
      '$count Bismillah',
      style: TextStyle(
          color: Colors.black, fontSize: 48.0, fontWeight: FontWeight.bold),
    );
  }
}
