// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodit/data/models/item_model.dart';

import '../../../core/export.dart';
import '../../../utils/widgets/dash_container.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    Key? key,
    required this.item,
    required this.qty,
    this.incr,
    this.decr,
  }) : super(key: key);
  final ItemModel item;
  final int qty;
  final void Function()? incr;
  final void Function()? decr;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetail, arguments: item);
      },
      child: DashContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Hero(
                tag: "item-img-${item.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.image!.img(),
                    fit: BoxFit.cover,
                    height: 12.fh,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.name}",
                    style: context.textStyles.displayLarge,
                  ).pb(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item.catName}",
                            style: context.textStyles.bodyMedium,
                          ).pb(8),
                          Text(
                            "Rs. ${item.price}",
                            style: context.textStyles.displayLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: context.color.primaryColor,
                              ),
                              onPressed: decr,
                            ),
                            Text(
                              "$qty",
                              style: context.textStyles.displayLarge,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: context.color.primaryColor,
                                ),
                                onPressed: incr),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ).pl(10),
            )
          ],
        ),
      ),
    );
  }
}
