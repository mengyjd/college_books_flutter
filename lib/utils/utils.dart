import 'package:college_books/widget/my_widget.dart';
import 'package:flutter/material.dart';

class Utils {
  static String validateEmpty(value,String text) {
    if (value.isEmpty) {
      return '$text不能为空';
    }
    return null;
  }

  static void showSnackBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(MyWidget.buildSnackBar(text));
  }
}