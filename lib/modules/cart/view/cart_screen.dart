import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/widgets/dash_container.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            DashContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        AssetPaths.jholMomo,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Chicken Jhol Momo",
                        style: context.textTheme.displayLarge,
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
