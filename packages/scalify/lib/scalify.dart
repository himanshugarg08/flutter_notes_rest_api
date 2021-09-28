library scalify;

import 'package:flutter/material.dart';
part 'num_extension.dart';
part 'widgets.dart';

class Scalify {
  static late MediaQueryData mediaQuery;
  static late double screenHeight;
  static late double screenWidth;
  static late double screenHeightWithPadding;
  static late double screenWidthWithPadding;
  static late double screenWidthPadding;
  static late double screenHeightPadding;

  static void init(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height;
    screenWidth = mediaQuery.size.width;
    screenWidthPadding = mediaQuery.padding.left + mediaQuery.padding.right;
    screenHeightPadding = mediaQuery.padding.top + mediaQuery.padding.bottom;
    screenHeightWithPadding = screenHeight - screenHeightPadding;
    screenWidthWithPadding = screenWidth - screenWidthPadding;
  }

  static double getHeight(double height) {
    return (screenHeightWithPadding / 100) * height;
  }

  static double getWidth(double width) {
    return (screenWidthWithPadding / 100) * width;
  }
}
