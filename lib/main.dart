import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodit/core/responsive/screen_util.dart';
import 'package:foodit/core/routes/route_generator.dart';
import 'package:foodit/core/theme/app_theme.dart';
import 'package:foodit/modules/auth/login/view/login_screen.dart';
import 'package:foodit/modules/cart/provider/cart_provider.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:foodit/modules/homescreen/view/homescreen.dart';
import 'package:foodit/modules/item_detail/provider/item_detail_provider.dart';
import 'package:foodit/modules/item_list/provider/item_provider.dart';
import 'package:foodit/modules/item_list/view/item_list.dart';
import 'package:foodit/modules/my_order/provider/my_order_provider.dart';
import 'package:foodit/modules/settings/provider/profile_form_provider.dart';
import 'package:foodit/utils/widgets/password_field/password_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'modules/cart/widget/cart_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileFormProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodIt',
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
        onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
      ),
    );
  }
}
