import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodit/core/responsive/screen_util.dart';
import 'package:foodit/core/routes/route_generator.dart';
import 'package:foodit/core/theme/app_theme.dart';
import 'package:foodit/modules/auth/login/view/login_screen.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:foodit/modules/item_detail/provider/item_detail_provider.dart';
import 'package:foodit/widgets/password_field/password_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color

    statusBarColor: Colors.transparent, // status bar color
  ));
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
          create: (_) => ItemDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
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
