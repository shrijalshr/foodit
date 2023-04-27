import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/services/auth_service.dart';
import 'package:foodit/utils/helper/sp.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? userModel;

  String? profileUrl;

  // Method to sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // Trigger a state change to notify listeners that user is signed out
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? currentUser;
  Future signInWithGoogle(BuildContext context) async {
    // FirebaseUser _user;
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // _googleSignIn.signOut();
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // addStringToSP("accessToken", googleSignInAuthentication.accessToken);

      UserCredential authResult = await _auth.signInWithCredential(credential);

      User? user = authResult.user;
      print(user?.displayName);
      if (user != null && user.uid != currentUser?.id) {
        print(user);
        print("User name: ${user.displayName}");
        print("User name: ${user.email}");

        String? email = user.email;
        String? name = user.displayName;
        String? photo = user.photoURL;
        photo = user.photoURL;
        profileUrl = user.photoURL;
        AuthService service = AuthService();
        await service.login(email!, name!, photo!).then((isSuccess) async {
          if (isSuccess) {
            if (service.isNewUser!) {
              String? userStr = await getStringFromSP("user");
              Map<String, dynamic> userJson = jsonDecode(userStr!);
              UserModel userModel = UserModel.fromMap(userJson);
              if (context.mounted) {
                Navigator.pushNamed(context, Routes.profileForm,
                    arguments: userModel);
              }
            } else {
              if (context.mounted) {
                Navigator.pushNamed(context, Routes.homescreen);
              }
            }
          }
        });

        notifyListeners();
        // UserController controller = Get.put(UserController());
        // controller.loadUser(userModel);
        return true;

        ///TODO: Check if any error or exception and navigate.
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> submitForm(Map data) async {
    AuthService service = AuthService();
    bool isSuccess = await service.updateUser(data);
    return isSuccess;
  }
}
