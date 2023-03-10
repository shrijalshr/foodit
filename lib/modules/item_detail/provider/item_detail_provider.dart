import 'package:flutter/material.dart';

class ItemDetailProvider extends ChangeNotifier {
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

  bool isFav = false;
  void onFav(bool value) {
    isFav = !value;
    notifyListeners();
  }
}
