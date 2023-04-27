import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

///[ItemList] curates item based on the category.
class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.item});
  final List<ItemModel> item;
  @override
  Widget build(BuildContext context) {
    return item.isEmpty
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: Text("${item[0].catName}"),
            ),
            body: Consumer<HomeProvider>(
              builder: (context, provider, child) => GridView.builder(
                scrollDirection: Axis.vertical,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 19,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: provider.catItemList.length,
                itemBuilder: (context, index) {
                  final ItemModel item = provider.catItemList[index];
                  return ItemCard(
                    item: item,
                  );
                },
              ),
            ),
          );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
  });
  final ItemModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetail, arguments: item);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.color.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Hero(
                        tag: "item-img-${item.id}",
                        child: Image.network(
                          "${item.image?.img()}",
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
                          "${item.name}",
                          style: context.textStyles.bodyMedium!.apply(
                              fontWeightDelta: 500,
                              color: context.color.darkGrey),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Rs. ${item.price}",
                          style: context.textStyles.titleMedium!
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
