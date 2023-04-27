import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

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
    return GestureDetector(
      onTap: () async {
        await context
            .read<HomeProvider>()
            .getCategoryItems(id)
            .then((isSuccess) {
          if (context.mounted) {
            List<ItemModel> itemList = context.read<HomeProvider>().catItemList;
            print(itemList);
            Navigator.pushNamed(context, Routes.categoryScreen,
                arguments: itemList);
          }
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: context.color.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: imgPath.img(),
                  width: 100,
                  height: 80,
                  fit: BoxFit.fitHeight,
                ).pb(8),
              ),
              Flexible(
                // height: 20,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.textStyles.displayMedium
                      ?.copyWith(color: context.color.lightGrey),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ).pb(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
