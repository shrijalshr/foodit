import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';

class HomeScreenText extends StatelessWidget {
  const HomeScreenText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "What would you like to have today?",
      style: context.textStyles.headlineLarge,
    );
  }
}
