import 'dart:convert';
import 'package:foodit/core/api/api.dart';
import 'package:foodit/core/api/api_endpoints.dart';
import 'package:foodit/core/api/api_exceptions.dart';
import 'package:foodit/data/models/category.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/utils/helper/custom_snackbars.dart';

class HomeScreenService {
  List<ItemModel> itemList = <ItemModel>[];
  List<ItemModel> featuredItemList = <ItemModel>[];
  List<ItemModel> catItemList = <ItemModel>[];
  List<ItemModel> searchedItemList = <ItemModel>[];
  List<CategoryModel> catList = <CategoryModel>[];

  getItemList() async {
    try {
      bool res = await ApiService().getAuthData(ApiEndPoints.items).then((res) {
        print(res);
        if (res != null) {
          var body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            for (var item in body) {
              ItemModel itemModel = ItemModel();
              itemModel = ItemModel.fromMap(item);
              itemList.add(itemModel);
            }
            return true;
          } else if (res.statusCode == 401) {
            errorSnackbar("Invalid Username/Password",
                "Username or password did not match. Try again");
            return false;
          } else if (res.statusCode == 400) {
            errorSnackbar(
                "Invalid Login", "Please provide valid email/password.");
            return false;
          } else {
            errorSnackbar("Something went wrong", "Please try again later");
            return false;
          }
        } else {
          return false;
        }
      });
    } on FetchDataException {
      errorSnackbar(
          "Unable to fetch data", "Check your connection and please try again");
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
    } catch (e) {
      print(e);
      errorSnackbar("Something went wrong.", "Please try again later ");
    }
  }

  getFeaturedItems() async {
    try {
      bool res = await ApiService().postData(
          {"is_featured": "1", "paginate": "10"},
          ApiEndPoints.items).then((res) {
        print("<----- Featured Items   ----->");
        if (res != null) {
          print(res.body);
          var body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            for (var item in body["data"]) {
              ItemModel itemModel = ItemModel();
              itemModel = ItemModel.fromMap(item);
              featuredItemList.add(itemModel);
            }
            return true;
          } else if (res.statusCode == 401) {
            errorSnackbar("Invalid Username/Password",
                "Username or password did not match. Try again");
            return false;
          } else if (res.statusCode == 400) {
            errorSnackbar(
                "Invalid Login", "Please provide valid email/password.");
            return false;
          } else {
            errorSnackbar("Something went wrong", "Please try again later");
            return false;
          }
        } else {
          return false;
        }
      });
      return res;
    } on FetchDataException {
      errorSnackbar(
          "Unable to fetch data", "Check your connection and please try again");
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
    } catch (e) {
      print(e);
      errorSnackbar("Something went wrong.", "Please try again later ");
    }
  }

  getCatItems(int catId) async {
    try {
      bool res = await ApiService()
          .postData({"category_id": catId}, ApiEndPoints.items).then((res) {
        print("<-----  Items based on Category   ----->");
        if (res != null) {
          print(res.body);
          var body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            for (var item in body) {
              ItemModel itemModel = ItemModel();
              itemModel = ItemModel.fromMap(item);
              catItemList.add(itemModel);
            }
            return true;
          } else if (res.statusCode == 401) {
            errorSnackbar("Invalid Username/Password",
                "Username or password did not match. Try again");
            return false;
          } else if (res.statusCode == 400) {
            errorSnackbar(
                "Invalid Login", "Please provide valid email/password.");
            return false;
          } else {
            errorSnackbar("Something went wrong", "Please try again later");
            return false;
          }
        } else {
          return false;
        }
      });
      return res;
    } on FetchDataException {
      errorSnackbar(
          "Unable to fetch data", "Check your connection and please try again");
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
    } catch (e) {
      print(e);
      errorSnackbar("Something went wrong.", "Please try again later ");
    }
  }

  getSearchedItems(String keyword) async {
    try {
      bool res = await ApiService().postData({
        "search_keyword": keyword,
      }, ApiEndPoints.items).then((res) {
        print("<-----  Items based on Search Keyword   ----->");
        if (res != null) {
          print(res.body);
          var body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            for (var item in body) {
              ItemModel itemModel = ItemModel();
              itemModel = ItemModel.fromMap(item);
              searchedItemList.add(itemModel);
            }
            return true;
          } else if (res.statusCode == 401) {
            errorSnackbar("Invalid Username/Password",
                "Username or password did not match. Try again");
            return false;
          } else if (res.statusCode == 400) {
            errorSnackbar(
                "Invalid Login", "Please provide valid email/password.");
            return false;
          } else {
            errorSnackbar("Something went wrong", "Please try again later");
            return false;
          }
        } else {
          return false;
        }
      });
      return res;
    } on FetchDataException {
      errorSnackbar(
          "Unable to fetch data", "Check your connection and please try again");
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
    } catch (e) {
      print(e);

      errorSnackbar("Something went wrong.", "Please try again later ");
    }
  }

  Future getCategoryList() async {
    try {
      bool res = await ApiService()
          .getData(ApiEndPoints.categories, {"paginate": "10"}).then((res) {
        if (res != null) {
          print(res.body);
          var body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            for (var cat in body) {
              CategoryModel catModel = CategoryModel();
              catModel = CategoryModel.fromJson(cat);
              catList.add(catModel);
            }
            return true;
          } else if (res.statusCode == 401) {
            errorSnackbar("Invalid Username/Password",
                "Username or password did not match. Try again");
            return false;
          } else if (res.statusCode == 400) {
            errorSnackbar(
                "Invalid Login", "Please provide valid email/password.");
            return false;
          } else {
            errorSnackbar("Something went wrong", "Please try again later");
            return false;
          }
        } else {
          return false;
        }
      });
      return res;
    } on FetchDataException {
      errorSnackbar(
          "Unable to fetch data", "Check your connection and please try again");
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
    } catch (e) {
      print(e);

      errorSnackbar("Something went wrong.", "Please try again later ");
    }
  }
}
