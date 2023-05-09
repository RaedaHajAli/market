import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market/helper/cache_helper.dart';
import 'package:market/helper/constant.dart';
import 'package:market/screens/login_screen.dart';

navigateTo(BuildContext context, Widget widget) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

navigateToAndFinish(BuildContext context, Widget widget) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

buildToast({required String message, required ToastState state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: chooseColor(state),
      textColor: Colors.white,
      fontSize: 16,
      timeInSecForIosWeb: 1);
}

enum ToastState { ERORR, WARNING, SUCCESS }

Color chooseColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.ERORR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
  }
  return color;
}

signOut(BuildContext context) {
  CacheHelper.remove(key: kToken).then((value) {
    navigateToAndFinish(context, LoginScreen());
  });
}
