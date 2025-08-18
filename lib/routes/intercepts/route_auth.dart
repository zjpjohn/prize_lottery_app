import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/store.dart';

class RouteAuthMiddleware extends GetMiddleware {
  ///
  ///
  RouteAuthMiddleware({this.priority = 0});

  @override
  int? priority = 0;

  @override
  RouteSettings? redirect(String? route) {
    String token = UserStore().authToken;
    if (token.isNotEmpty || route == AppRoutes.login) {
      return null;
    }
    ConfigStore().saveHistory();
    return const RouteSettings(name: AppRoutes.login);
  }
}
