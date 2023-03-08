import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';

import '../../../data/models/category.dart';

class HomeProvider with ChangeNotifier {
  List<Category> categoryList = List.generate(
    5,
    (index) => Category(
        id: index, imgPath: AssetPaths.frenchFries, name: "French Fries"),
  );
}
