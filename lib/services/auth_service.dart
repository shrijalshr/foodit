import 'dart:convert';

import 'package:foodit/core/api/api.dart';
import 'package:foodit/core/api/api_endpoints.dart';
import 'package:foodit/core/api/api_exceptions.dart';
import 'package:foodit/data/models/user_model.dart';
import 'package:foodit/utils/helper/sp.dart';

import '../utils/helper/custom_snackbars.dart';

class AuthService {
  bool? isNewUser;
  Future<bool> login(String email, String name, String photo) async {
    try {
      bool res = await ApiService()
          .postData({"email": email}, ApiEndPoints.user).then((res) {
        print("<------form auth service login ------->");
        print(res?.body);
        if (res != null) {
          Map body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            user = UserModel.fromMap(body["user"]);
            print("from auth serive---");
            print(user.toString());
            String token = body["token"];
            Map userMap = {
              "id": user?.id,
              "name": name,
              "email": email,
              "image": photo,
              "phone": user?.phone,
              "address": user?.address,
            };
            print("from auth service login----");
            print(userMap);
            addStringToSP("accessToken", token);

            addJsonToSP("user", userMap);
            isNewUser = body["newUser"];
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

  UserModel? user;
  Future<bool> updateUser(Map data) async {
    try {
      bool res = await ApiService()
          .postAuthData(data, ApiEndPoints.userUpdate)
          .then((res) {
        print("<------form auth service update------->");
        if (res != null) {
          print(res.body);
          Map body = jsonDecode(res.body);
          if (res.statusCode == 200) {
            // body["user"]["image"]=
            user = UserModel.fromMap(body["user"]);
            print(user.toString());
            // addStringToSP("accessToken", token);
            addJsonToSP("user", body["user"]);
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
