import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/modules/item_detail/provider/item_detail_provider.dart';
import 'package:foodit/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../homescreen/widgets/item_tag.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, this.id, this.itemName, this.price});

  final int? id;
  final String? itemName;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.white,
      appBar: AppBar(title: const Text("Jhol Momo"), actions: [
        IconButton(
          onPressed: () {
            context
                .read<ItemDetailProvider>()
                .onFav(context.read<ItemDetailProvider>().isFav);
          },
          icon: Consumer<ItemDetailProvider>(
            builder: (context, provider, child) => Icon(
              provider.isFav ? Icons.favorite : Icons.favorite_outline,
              color: context.color.primaryColor,
            ),
          ),
        ).pr(8),
      ]),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: "item-img-$id",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 48.fh,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(),
                      child: Image.asset(
                        AssetPaths.jholMomo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ).pa(16),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      // color: context.color.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: "item-name-$itemName-$id",
                          child: Text(
                            "Chicken Jhol Momo ",
                            style: context.textTheme.headlineLarge,
                            overflow: TextOverflow.visible,
                            maxLines: null,
                            softWrap: true,
                          ).pb(4),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "4.5",
                              style: context.textTheme.bodyMedium!
                                  .copyWith(color: context.color.darkGrey),
                            ),
                            Icon(
                              Icons.star,
                              color: context.color.secondaryColor,
                              size: 16,
                            ).ph(4),
                            Text(
                              "(25+)",
                              style: context.textTheme.bodySmall!
                                  .copyWith(color: context.color.lightGrey),
                            ).pr(4),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "See Reviews",
                                style: context.textTheme.bodySmall!.apply(
                                    color: context.color.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ).pb(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs. 250",
                              style: context.textTheme.headlineLarge
                                  ?.copyWith(color: context.color.primaryColor),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: context.color.primaryColor,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ItemDetailProvider>()
                                          .dcrItem();
                                    },
                                  ),
                                  Text(
                                    "${context.watch<ItemDetailProvider>().noOfItem}",
                                    style: context.textTheme.displayLarge,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: context.color.primaryColor,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ItemDetailProvider>()
                                          .incItem();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ).pb(8),
                        Text(
                          "Jhol Momo refers to momos drowned in a bowl of hot, liquid chutney. ",
                          style: context.textTheme.bodyMedium,
                        ).pb(4),
                        Wrap(
                          children: [
                            "Momo",
                            "Chicken",
                            "Warm",
                          ]
                              .map((e) => ItemTag(tagName: e).pr(10).pb(8))
                              .toList(),
                        ).pb(8),
                      ],
                    ),
                  ).ph(16),
                ),
                const SizedBox(
                  height: 52,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppButton(
                label: "Add to Cart",
                onPressed: () {},
              ).p(16, 16, 0, 8))
        ],
      ),
    );
  }
}
