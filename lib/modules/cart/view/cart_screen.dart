import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/widgets/app_button.dart';
import 'package:foodit/widgets/dash_container.dart';
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.showAppBar = false});
  final bool showAppBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: const Text(
                "My Cart",
              ),
            )
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: 40.fh,
                minHeight: 10.fh,
                maxWidth: 100.fw,
                minWidth: 100.fw),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => CartItemTile(
                      id: index,
                      name: "Chicken Jhol Momo",
                      category: "Nepali Food",
                      price: "250",
                      imgPath: AssetPaths.jholMomo,
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: 2),
          ),
          Expanded(
            child: DashContainer(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub total",
                          style: context.textTheme.displayMedium,
                        ),
                        Text(
                          "Rs. 750",
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: context.textTheme.displayMedium,
                        ),
                        Text(
                          "Rs. 0",
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: context.textTheme.displayMedium,
                        ),
                        Text(
                          "Rs. 0",
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: context.textTheme.displayMedium,
                        ),
                        Text(
                          "Rs. 750",
                          style: context.textTheme.displayMedium,
                        ),
                      ],
                    ).pb(16),
                    AppButton(onPressed: () {}, label: "Proceed To Checkout")
                  ],
                ).pa(16),
              ),
            ).pt(10),
          ),
        ],
      ).ph(16),
    );
  }
}
