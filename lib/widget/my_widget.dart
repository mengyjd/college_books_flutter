import 'package:flutter/material.dart';

class MyWidget {
  static Widget buildSnackBar(String text) {
    return SnackBar(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: Text(text),
      duration: Duration(seconds: 3),
      //持续时间
      backgroundColor: Colors.red,
      onVisible: () => print('onVisible'),
      action: SnackBarAction(
          textColor: Colors.white, label: '确定', onPressed: () {}),
    );
  }
}