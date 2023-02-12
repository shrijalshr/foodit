import 'package:flutter/material.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/modules/auth/login/view/login_screen.dart';
import 'package:foodit/modules/auth/register/view/register_screen.dart';
import 'package:foodit/modules/homescreen/view/homescreen.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.homescreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
