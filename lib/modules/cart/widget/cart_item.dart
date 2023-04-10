import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/export.dart';
import '../../../widgets/dash_container.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.name,
    required this.id,
    required this.price,
    required this.category,
    required this.imgPath,
  });
  final int id;
  final String name;
  final String price;
  final String category;
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetail, arguments: id);
      },
      child: DashContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: "item-img-$id",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.cover,
                    height: 12.fh,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.textTheme.displayLarge,
                  ).pb(4),
                  Row(  
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: context.textTheme.bodyMedium,
                          ).pb(8),
                          Text(
                            "Rs. $price",
                            style: context.textTheme.displayLarge,
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
                              onPressed: () {
                                context.read<CartItemProvider>().dcrItem();
                              },
                            ),
                            Text(
                              "${context.watch<CartItemProvider>().noOfItem}",
                              style: context.textTheme.displayLarge,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: context.color.primaryColor,
                              ),
                              onPressed: () {
                                context.read<CartItemProvider>().incItem();
                              },
                            ),
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

class CartItemProvider extends ChangeNotifier {
  int noOfItem = 1;
  void incItem() {
    noOfItem++;
    notifyListeners();
  }

  void dcrItem() {
    if (noOfItem == 1) return;
    noOfItem--;
    notifyListeners();
  }
}
