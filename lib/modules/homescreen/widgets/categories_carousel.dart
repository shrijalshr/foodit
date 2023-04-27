import 'package:flutter/material.dart';
import 'package:foodit/data/models/category.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/export.dart';
import 'category_card.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    final HomeProvider provider =
        Provider.of<HomeProvider>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: context.textStyles.headlineMedium,
        ).pb(10),
        Consumer<HomeProvider>(
          builder: (context, value, child) => SizedBox(
            height: 120,
            child: provider.categoryList.isEmpty
                ? const Center(child: Text("No Categories Added."))
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cat = provider.categoryList[index];
                      return CategoryCard(
                          label: cat.name ?? "",
                          imgPath: cat.image ??
                              "https://th.bing.com/th/id/R.35a16aa6743a594d9a13883d71ad32cd?rik=r65LNwx8FIpelw&riu=http%3a%2f%2fwww.sagaflor.de%2ffileadmin%2f_processed_%2fcsm_final_Category_Management_Website_shutterstock_290636426_86304a41f0.jpg&ehk=OM3ysZk1v0t%2bSp8H8tCyKRa2V%2fxuu3iixtWMXPZFHds%3d&risl=&pid=ImgRaw&r=0",
                          id: cat.id ?? index);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                    itemCount: provider.categoryList.length),
          ).pb(16),
        ),
      ],
    );
  }
}
