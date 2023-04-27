import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/data/models/order_model.dart';
import 'package:foodit/modules/cart/provider/order_provider.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:foodit/utils/widgets/dash_container.dart';
import 'package:provider/provider.dart';
import '../widget/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderProvider>().initS();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OrderProvider provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: 40.fh,
                  minHeight: 10.fh,
                  maxWidth: 100.fw,
                  minWidth: 100.fw),
              child: Consumer<OrderProvider>(
                builder: (context, provider, child) => provider
                        .cartItems.isEmpty
                    ? const Center(child: Text("No Items added to cart"))
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final SingleItemOrderModel cartItem =
                              provider.cartItems[index];
                          return CartItemTile(
                            item: cartItem.item!,
                            qty: cartItem.qty ?? 1,
                            incr: () {
                              provider.incItem(cartItem);
                            },
                            decr: () {
                              provider.dcrItem(cartItem);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: provider.cartItems.length,
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
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
                          "Total",
                          style: context.textStyles.displayMedium,
                        ),
                        Text(
                          "Rs. ${provider.total}",
                          style: context.textStyles.displayMedium,
                        ),
                      ],
                    ).pb(16),
                    AppButton(
                        onPressed: () {
                          provider.getOrderItemList();
                          Navigator.pushNamed(context, Routes.checkOut);
                        },
                        label: "Proceed To Checkout")
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
