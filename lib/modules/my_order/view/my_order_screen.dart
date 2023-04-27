import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/modules/cart/provider/order_provider.dart';
import 'package:foodit/utils/widgets/custom_tab_indicator.dart';
import 'package:foodit/utils/widgets/dash_container.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
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
          "My Orders",
        ),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: context.color.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                splashFactory: InkRipple.splashFactory,
                automaticIndicatorColorAdjustment: false,
                tabs: const [Text("Actice"), Text("History")],
                labelColor: context.color.white,
                unselectedLabelColor: context.color.darkGrey,
                indicator: CustomTabIndicator(),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ).ph(16),
            Expanded(
              child:
                  TabBarView(physics: const BouncingScrollPhysics(), children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DashContainer(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                AssetPaths.jholMomo,
                                fit: BoxFit.cover,
                                height: 10.fh,
                                width: 10.fh,
                              ),
                            ).pr(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chicken Momo",
                                  style: context.textStyles.displayLarge,
                                ).pb(10),
                                Text(
                                  "x 2",
                                  style: context.textStyles.bodyMedium,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rs. 400",
                                      style: context.textStyles.displayMedium,
                                    ),
                                    Text("Status: ")
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.maxFinite,
                  child: Text("history"),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
