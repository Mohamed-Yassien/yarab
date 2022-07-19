import 'package:flutter/material.dart';

import '../modules/login_screen.dart';
import '../network/local/cache_helper.dart';

void navigateToAndFinish({
  required Widget widget,
  required context,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

void navigateTo({
  required Widget widget,
  required context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void logOut(context) {
  CacheHelper.remove(key: 'token').then((value) {
    if (value) {
      navigateToAndFinish(
        widget: LoginScreen(),
        context: context,
      );
    }
  });
}
