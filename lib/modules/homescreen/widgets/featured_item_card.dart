import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

import 'item_tag.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetail, arguments: id);
      },
      child: ClipRRect(
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
                    child: Hero(
                      tag: "item-img-$id",
                      child: Image.asset(
                        imgPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
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
                        onPressed: () {
                          context
                              .read<HomeProvider>()
                              .onFav(context.read<HomeProvider>().isFav);
                        },
                        icon: Consumer<HomeProvider>(
                          builder: (context, provider, child) => Icon(
                            Icons.favorite,
                            color: provider.isFav
                                ? context.color.primaryColor
                                : context.color.backgroundColor,
                          ),
                        ),
                      ))
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
                            child: Hero(
                              tag: "item-name-$itemName-$id",
                              child: Text(
                                itemName,
                                style: context.textTheme.displayLarge,
                                overflow: TextOverflow.ellipsis,
                              ).pv(8),
                            ),
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
      ),
    );
  }
}
