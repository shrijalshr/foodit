import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/search_bar.dart';
import '../widgets/category_card.dart';
import '../widgets/featured_item_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const List<Widget> navIconList = [
    Icon(Icons.home_outlined, size: 24),
    Icon(Icons.search_outlined, size: 24),
    Icon(Icons.shopping_cart_outlined, size: 24),
    Icon(Icons.favorite_outline, size: 24),
  ];

  final List<Widget?> pages = [
    const HomeScreenBody(),
    null,
    const Text("Cart"),
    const Text("Fav"),
  ];

  //State class
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 56,
          animationDuration: const Duration(milliseconds: 200),
          items: navIconList,
          onTap: (index) {
            context.read<HomeProvider>().onNavTap(context, index);
          },
        ),
        body: pages.elementAt(context.watch<HomeProvider>().selectedIndex));
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                return FeaturedItemCard(
                  id: index,
                  itemName: "Jhol Momo",
                  imgPath: AssetPaths.jholMomo,
                  price: "250",
                  timeForPrep: "15-20 mins",
                  tags: const [
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
    );
  }
}
