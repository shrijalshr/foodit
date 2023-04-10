
import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';

import 'featured_item_card.dart';

class FeaturedItemCarousel extends StatelessWidget {
  const FeaturedItemCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}