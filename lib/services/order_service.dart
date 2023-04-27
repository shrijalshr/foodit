import 'dart:convert';

import 'package:foodit/core/export.dart';

import '../utils/helper/custom_snackbars.dart';

class OrderService {
  Future<bool> postOrder(data) async {
    try {
      bool res =
          await ApiService().postAuthData(data, ApiEndPoints.order).then((res) {
        print("<------form order service order ------->");
        print(res?.body);
        if (res != null) {
          Map body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            print("ordered");

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
      return false;
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
      return false;
    } catch (e) {
      print(e);
      errorSnackbar("Something went wrong.", "Please try again later ");
      return false;
    }
  }

  Future<bool> getOrderList() async {
    try {
      bool res = await ApiService()
          .postAuthData("", ApiEndPoints.orderList)
          .then((res) {
        print("<------form order service order ------->");
        print(res?.body);
        if (res != null) {
          Map body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            print("ordered");

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
      return false;
    } on ApiNotRespondingException {
      errorSnackbar("Api Not Responding", "Please try again later ");
      return false;
    } catch (e) {
      print(e);
      errorSnackbar("Something went wrong.", "Please try again later ");
      return false;
    }
  }
}
