import 'dart:async';

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

  bool onHomeScreen = false;
  checkIfOnHomeScreen() {
    onHomeScreen = selectedIndex == 0;
    if (!onHomeScreen) {
      selectedIndex = 0;
    }
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

  DateTime now1 = DateTime.now();
  Stream<DateTime> getTime() async* {
    DateTime now = DateTime.now();
    Stream<DateTime> timer = Stream.periodic(const Duration(seconds: 1), (i) {
      now = now.add(const Duration(seconds: 1));
      return now;
    });
    String message = '';
    yield* timer;
  
  }

}
