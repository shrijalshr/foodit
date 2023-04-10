import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/widgets/custom_tab_indicator.dart';
import 'package:foodit/widgets/dash_container.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            ),
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
