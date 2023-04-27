import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/services/home_screen_service.dart';

import '../../../data/models/category.dart';
import '../../../data/models/user_model.dart';
import '../../../utils/helper/sp.dart';

class HomeProvider with ChangeNotifier {
  void initS() {
    getUser();
    getCategories();
    getAllItems();
    getFeaturedItems();
  }

  UserModel? user;
  getUser() async {
    String? userStr = await getStringFromSP("user");
    if (userStr != null) {
      Map<String, dynamic> userMap = jsonDecode(userStr);
      user = UserModel.fromMap(userMap);
    }
    notifyListeners();
  }

  bool isLoading = false;

  List<ItemModel> favItems = [];

  int selectedIndex = 0;
  onNavTap(BuildContext context, int index) {
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

  List<CategoryModel> categoryList = [];
  Future<void> getCategories() async {
    isLoading = true;
    HomeScreenService service = HomeScreenService();
    await service.getCategoryList().then(
      (value) {
        categoryList = service.catList;
      },
    );
    // print(categoryList[0].name);
    isLoading = false;

    notifyListeners();
  }

  List<ItemModel> itemList = [];
  Future<void> getAllItems() async {
    HomeScreenService service = HomeScreenService();
    await service.getItemList();
    itemList = service.itemList;
    notifyListeners();
  }

  List<ItemModel> featuredItemList = [];
  Future<void> getFeaturedItems() async {
    isLoading = true;
    HomeScreenService service = HomeScreenService();
    await service.getFeaturedItems();
    featuredItemList = service.featuredItemList;
    isLoading = false;
    notifyListeners();
  }

  List<ItemModel> catItemList = [];
  Future<bool?> getCategoryItems(int id) async {
    HomeScreenService service = HomeScreenService();
    bool? isSuccess = await service.getCatItems(id);
    catItemList = service.catItemList;
    notifyListeners();
    return isSuccess;
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
