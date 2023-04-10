import 'package:flutter/material.dart';

import '../../../core/export.dart';
import 'category_card.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: context.textTheme.headlineMedium,
        ).pb(10),
        SizedBox(
          height: 120,
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
      ],
    );
  }
}