import 'package:flutter/foundation.dart';
import 'package:foodit/data/models/item_model.dart';

import '../../../services/home_screen_service.dart';

class SearchProvider extends ChangeNotifier {
  List<String> searchHistory = [];
  List<ItemModel> searchedResult = <ItemModel>[];

  bool isLoading = false;
  Future<List<ItemModel>?> getSearchedItems(String keyword) async {
    HomeScreenService service = HomeScreenService();
    bool? isSuccess = await service.getSearchedItems(keyword);
    searchedResult = service.searchedItemList;
    if (searchedResult.isNotEmpty) {
      print(searchedResult[0]);
    }
    notifyListeners();
    return searchedResult;
  }
}
