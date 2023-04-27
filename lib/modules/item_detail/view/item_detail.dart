import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/modules/cart/provider/order_provider.dart';
import 'package:foodit/modules/item_detail/provider/item_detail_provider.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/routes.dart';
import '../../homescreen/widgets/item_tag.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.white,
      appBar: AppBar(title: Text("${item.name}"), actions: [
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: "item-img-${item.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 48.fh,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(),
                      child: CachedNetworkImage(
                        imageUrl: item.image!.img(),
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
                          tag: "item-name-${item.name}-${item.id}",
                          child: Text(
                            "${item.name}",
                            style: context.textStyles.headlineLarge,
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
                              style: context.textStyles.bodyMedium!
                                  .copyWith(color: context.color.darkGrey),
                            ),
                            Icon(
                              Icons.star,
                              color: context.color.secondaryColor,
                              size: 16,
                            ).ph(4),
                            Text(
                              "(25+)",
                              style: context.textStyles.bodySmall!
                                  .copyWith(color: context.color.lightGrey),
                            ).pr(4),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "See Reviews",
                                style: context.textStyles.bodySmall!.apply(
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
                              "Rs. ${item.price}",
                              style: context.textStyles.headlineLarge
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
                                    style: context.textStyles.displayLarge,
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
                          "${item.desc}",
                          style: context.textStyles.bodyMedium,
                        ).pb(4),
                        Wrap(
                          children: [
                            "${item.catName}",
                          ]
                              .map((e) => ItemTag(tagName: e).pr(10).pb(8))
                              .toList(),
                        ).pb(8),

                        ///TODO: Add Addons Section
                        // Text("Add Extra",
                        //         style: context.textTheme.displayMedium)
                        //     .pb(16),
                      ],
                    ),
                  ).ph(16),
                ),
                const SizedBox(
                  height: 60,
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
                onPressed: () {
                  int qty = context.read<ItemDetailProvider>().noOfItem;
                  context.read<OrderProvider>().addToCart(item, qty);
                  Navigator.pushNamed(context, Routes.cart);
                },
              ).p(16, 16, 0, 8))
        ],
      ),
    );
  }
}
