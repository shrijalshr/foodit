import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';

import '../../../widgets/search_bar.dart';
import '../widgets/category_card.dart';
import '../widgets/featured_item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FoodIt"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_2_outlined,
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 05.fh,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Good Morning, ",
                    style: context.textTheme.headlineMedium,
                  ),
                  TextSpan(
                    text: "Shrijal",
                    style: context.textTheme.headlineMedium!
                        .copyWith(color: context.color.primaryColor),
                  ),
                ],
              ),
            ).pb(8),
            Text(
              "What would you like to have today?",
              style: context.textTheme.headlineLarge,
            ).pb(24),
            const SearchBar().pb(24),
            Text(
              "Categories",
              style: context.textTheme.headlineMedium,
            ).pb(10),
            SizedBox(
              height: 110,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CategoryCard(
                        label: "Momo", imgPath: AssetPaths.burger, id: index);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 16,
                      ),
                  itemCount: 5),
            ).pb(16),
            Text(
              "Featured Items",
              style: context.textTheme.headlineMedium,
            ).pb(10),
            SizedBox(
              height: 36.fh,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return const FeaturedItemCard(
                    id: 1,
                    itemName: "Jhol Momo",
                    imgPath: AssetPaths.jholMomo,
                    price: "250",
                    timeForPrep: "15-20 mins",
                    tags: [
                      "Momo",
                      "Chicken",
                      "Nepali Food",
                    ],
                    rating: "4.5",
                    noOfRating: "23",
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
                itemCount: 5,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ).ph(16),
      ),
    );
  }
}
