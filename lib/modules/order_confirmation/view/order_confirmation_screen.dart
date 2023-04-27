import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:foodit/utils/widgets/dash_container.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Confirmation"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, Routes.myOrder);
            },
          ),
        ),
        body: Center(
          child: DashContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            borderRadius: 30,
            width: 100.fw,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    size: 30.fw,
                    color: context.color.primaryColor,
                  ).pb(16),
                  Text(
                    "Order Placed Successfully.",
                    style: context.textStyles.headlineMedium
                        ?.copyWith(color: context.color.successColor),
                  ).pb(8),
                  Text(
                    "Your order id is: EWI2423H34.",
                    style: context.textStyles.bodyMedium,
                  ).pb(4),
                  Text(
                    "Estimated Prepatation Time is 12 mins",
                    style: context.textStyles.bodyMedium,
                  ).pb(4),
                  Text(
                    "Order Amount is Rs. 1400",
                    style: context.textStyles.bodyMedium,
                  ).pb(20),
                  AppButton.secondary(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.myOrder,
                                (Route route) =>
                                    route.settings.name == Routes.homescreen);
                          },
                          label: "View Your Orders")
                      .pb(16),
                  AppButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.homescreen);
                          },
                          label: "Go to Home")
                      .pb(16),
                ],
              ),
            ),
          ).ph(20),
        ));
  }
}
