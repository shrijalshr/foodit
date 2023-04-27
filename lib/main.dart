import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/modules/cart/provider/order_provider.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:foodit/modules/item_detail/provider/item_detail_provider.dart';
import 'package:foodit/modules/item_list/provider/item_provider.dart';
import 'package:foodit/modules/item_list/view/item_list.dart';
import 'package:foodit/modules/search_screen/provider/search_provider.dart';
import 'package:foodit/modules/settings/provider/profile_form_provider.dart';
import 'package:foodit/utils/helper/sp.dart';
import 'package:foodit/utils/widgets/password_field/password_provider.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'modules/auth/login/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(FirebaseAppCheck.instance.app.name);
  await FirebaseAppCheck.instance.activate(
    // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.playIntegrity,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color

    statusBarColor: Colors.transparent, // status bar color
  ));
  //the app shall only support portrait orientation in upside direction.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(height: 844, width: 390, allowFontScaling: true);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemCardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileFormProvider(),
        ),
      ],
      child: KhaltiScope(
        publicKey: "test_public_key_5ea672937d324aaf8619f502279167fe",

        ///TODO: Add public key
        builder: (context, navigatorKey) => GetMaterialApp(
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'FoodIt',
          theme: AppTheme.lightTheme,
          builder: (context, child) {
            return StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  final conenctivityResult = snapshot.data;
                  if (conenctivityResult == ConnectivityResult.none ||
                      conenctivityResult == null) {
                    return const NoInternetScreen();
                  }

                  return child!;
                });
          },
          home: const RootApp(),
          onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
        ),
      ),
    );
  }
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _AppState();
}

class _AppState extends State<RootApp> {
  bool isLoggedIn = false;
  @override
  void initState() {
    checkIfLoggedIn();
    getUser();
    super.initState();
  }

  getUser() async {
    String? userStr = await getStringFromSP("user");
    print("From root app");
    print(userStr);
    if (userStr != null) {
      Map<String, dynamic> userMap = jsonDecode(userStr);
      setState(() {
        // user = UserModel.fromMap(userMap);
      });
    }
  }

  checkIfLoggedIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? currentUser;
    currentUser = googleSignIn.currentUser;

    String? token = await ApiService().getAccessToken();

    if (token != null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }

    Timer(
        const Duration(seconds: 1),
        () => isLoggedIn
            ? Navigator.pushReplacementNamed(context, Routes.homescreen)
            : Navigator.pushReplacementNamed(context, Routes.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.fh,
        width: 100.fh,
        child: Center(
          child: Image.asset(AssetPaths.logo),
        ),
      ),
    );
  }
}

// isLoggedIn ? HomeScreen() : const LoginScreen();

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Internent Connections"),
      ),
    );
  }
}
