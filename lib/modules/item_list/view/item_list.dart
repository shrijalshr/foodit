import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:provider/provider.dart';

///[ItemList] curates item based on the category.
class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                title: const Text("Momo"),
              ),
            ];
          },
          body: GridView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 19,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ItemCard(
                id: index,
                name: "Chicken Jhol Momo",
                price: "250",
              );
            },
          )),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.name,
    required this.id,
    required this.price,
    this.noOfRating,
    this.rating,
  });
  final String name;
  final int id;
  final String price;
  final String? noOfRating;
  final String? rating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetail, arguments: id);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.color.white),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Hero(
                        tag: "item-img-$id",
                        child: Image.asset(
                          AssetPaths.jholMomo,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                context.color.backgroundColor.withOpacity(.8),
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
                              context.read<ItemCardProvider>().onFav(
                                  context.read<ItemCardProvider>().isFav);
                            },
                            icon: Consumer<ItemCardProvider>(
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
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Text(
                          name,
                          style: context.textTheme.bodyMedium!.apply(
                              fontWeightDelta: 500,
                              color: context.color.darkGrey),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Rs. $price",
                          style: context.textTheme.titleMedium!
                              .apply(fontWeightDelta: 500),
                        ),
                      ),
                    ],
                  ).pa(8),
                )
              ],
            ),
          )),
    );
  }
}

class ItemCardProvider extends ChangeNotifier {
  bool isFav = false;
  void onFav(bool value) {
    isFav = !value;
    notifyListeners();
  }
}
