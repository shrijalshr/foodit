import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/modules/search_screen/search_screen.dart';

import '../../../data/models/category.dart';

class HomeProvider with ChangeNotifier {
  int selectedIndex = 0;
  onNavTap(BuildContext context, int index) {
    if (index == 1) {
      showSearch(context: context, delegate: SearchBarDelegate());
    }
    selectedIndex = index;
    notifyListeners();
  }

  List<Category> categoryList = List.generate(
    5,
    (index) => Category(
        id: index, imgPath: AssetPaths.frenchFries, name: "French Fries"),
  );

  bool isFav = false;
  void onFav(bool value) {
    isFav = !value;
    notifyListeners();
  }
}
