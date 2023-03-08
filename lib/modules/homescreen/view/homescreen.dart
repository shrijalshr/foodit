import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';

import '../../../widgets/search_bar.dart';

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

class FeaturedItemCard extends StatelessWidget {
  const FeaturedItemCard({
    super.key,
    required this.itemName,
    required this.price,
    this.timeForPrep,
    required this.tags,
    this.rating,
    this.noOfRating,
    required this.id,
    required this.imgPath,
  });

  final int id;
  final String imgPath;
  final String itemName;
  final String price;
  final String? timeForPrep;
  final List<String> tags;
  final String? rating;
  final String? noOfRating;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36.fh,
        height: 36.fh,
        decoration: BoxDecoration(
          color: context.color.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 36.fh,
                  height: 20.fh,
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.color.backgroundColor.withOpacity(.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rating ?? "4.5",
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: context.color.darkGrey),
                        ),
                        Icon(
                          Icons.star,
                          color: context.color.secondaryColor,
                          size: 16,
                        ).ph(4),
                        Text(
                          noOfRating ?? "(25+)",
                          style: context.textTheme.bodySmall!
                              .copyWith(color: context.color.lightGrey),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 8,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: context.color.whiteSmoke,
                        )))
              ],
            ),
            SizedBox(
              height: 16.fh,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Tooltip(
                          message: itemName,
                          child: Text(
                            itemName,
                            style: context.textTheme.displayLarge,
                            overflow: TextOverflow.ellipsis,
                          ).pv(8),
                        ),
                      ),
                      Text(
                        "Rs. $price",
                        style: context.textTheme.displayLarge,
                      )
                    ],
                  ),
                  if (timeForPrep != null)
                    Row(
                      children: [
                        Icon(
                          Icons.timer_rounded,
                          color: context.color.primaryColor,
                          size: 20,
                        ).pr(4),
                        Text(
                          timeForPrep ?? "Unknown",
                          style: context.textTheme.bodySmall,
                        ).pr(10),
                      ],
                    ).pb(8),
                  Wrap(
                    children: tags.map((e) => ItemTag(tagName: e)).toList(),
                  )
                ],
              ),
            ).ph(16)
          ],
        ),
      ),
    );
  }
}

class ItemTag extends StatelessWidget {
  const ItemTag({
    super.key,
    required this.tagName,
  });

  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.color.backgroundColor,
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(tagName),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.label,
    required this.imgPath,
    required this.id,
  });

  final String label;
  final String imgPath;
  final int id;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: context.color.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 80,
              child: Image.asset(
                imgPath,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ).pb(8),
            ),
            SizedBox(
              height: 15,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium
                    ?.copyWith(color: context.color.lightGrey),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
