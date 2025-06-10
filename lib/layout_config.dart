import 'package:flutter/material.dart';

class LayoutConfig {
  static double width = 0;
  static double height = 0;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
  }
}
