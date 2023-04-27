import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

import 'featured_item_card.dart';

class FeaturedItemCarousel extends StatelessWidget {
  const FeaturedItemCarousel({
    super.key,
    required this.featuredItems,
  });

  final List<ItemModel> featuredItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Items",
          style: context.textStyles.headlineMedium,
        ).pb(10),
        SizedBox(
          height: 36.fh,
          child: context.read<HomeProvider>().featuredItemList.isEmpty
              ? Center(
                  child: GestureDetector(
                      onTap: () {
                        context.read<HomeProvider>().getFeaturedItems();
                      },
                      child: const Text("No Featured Items")),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: featuredItems.length,
                  itemBuilder: (context, index) {
                    final ItemModel item = featuredItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.itemDetail,
                            arguments: item);
                      },
                      child: FeaturedItemCard(
                        id: item.id!,
                        itemName: item.name ?? "",
                        imgPath: item.image ?? "",
                        price: item.price ?? "0",
                        timeForPrep: "15-20 mins",
                        isFav: false,
                        onFav: (){},
                        tags: const [
                          "Momo",
                          "Chicken",
                          "Nepali Food",
                        ],
                        rating: "4.5",
                        noOfRating: "23",
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 16,
                  ),
                ),
        ),
      ],
    );
  }
}
