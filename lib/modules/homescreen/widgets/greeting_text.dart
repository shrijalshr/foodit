import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
        stream: context.read<HomeProvider>().getTime(),
        builder: ((context, snapshot) {
          String message = '';
          int hours =
              snapshot.hasData ? snapshot.data!.hour : DateTime.now().hour;
          print(hours);
          if (hours >= 0 && hours < 12) {
            message = "Good Morning🌄, ";
          } else if (hours >= 12 && hours < 16) {
            message = "Good Afternoon🌞, ";
          } else if (hours >= 16 && hours < 21) {
            message = "Good Evening🌇, ";
          } else if (hours >= 21 && hours < 24) {
            message = "Good Night🌛, ";
          }
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: message,
                  style: context.textTheme.headlineMedium,
                ),
                TextSpan(
                  text: " Shrijal",
                  style: context.textTheme.headlineMedium!
                      .copyWith(color: context.color.primaryColor),
                ),
              ],
            ),
          ).pb(8);
        }));
  }
}
