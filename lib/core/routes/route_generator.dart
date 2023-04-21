import 'package:flutter/material.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/modules/auth/login/view/login_screen.dart';
import 'package:foodit/modules/auth/register/view/register_screen.dart';
import 'package:foodit/modules/favorite/view/favorite_screen.dart';
import 'package:foodit/modules/homescreen/view/homescreen.dart';
import 'package:foodit/modules/item_detail/view/item_detail.dart';
import 'package:foodit/modules/item_list/view/item_list.dart';
import 'package:foodit/modules/my_order/view/my_order_screen.dart';
import 'package:foodit/modules/order_confirmation/view/order_confirmation_screen.dart';
import 'package:foodit/modules/profile/view/profile_screen.dart';
import 'package:foodit/modules/settings/view/profile_form.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return getPage(const LoginScreen());

      case Routes.login:
        return getPage(const LoginScreen());

      case Routes.register:
        return getPage(const RegisterScreen());

      case Routes.homescreen:
        return getPage(HomeScreen());

      case Routes.itemDetail:
        return getPage(
          ItemDetailScreen(
          item: settings.arguments as ItemModel,
          ),
        );
      case Routes.itemList:
        return getPage(
          const ItemList(),
        );

      case Routes.myOrder:
        return getPage(
          const MyOrderScreen(),
        );
      case Routes.favorites:
        return getPage(
          const FavoriteScreen(),
        );

      case Routes.profile:
        return getPage(
          const ProfileScreen(),
        );

      case Routes.orderConfirmation:
        return getPage(
          const OrderConfirmationScreen(),
        );
      case Routes.profileForm:
        return getPage(
          const ProfileForm(),
        );
      default:
        return getPage(const LoginScreen());
    }
  }

  static getPage(page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: a.drive(tween),
            child: c,
          );
        });
  }
}
