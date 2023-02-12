import 'package:flutter/material.dart';
import 'package:foodit/core/responsive/screen_util.dart';
import 'package:foodit/core/theme/app_theme.dart';
import 'package:foodit/modules/auth/login/view/login_screen.dart';
import 'package:foodit/widgets/password_field/password_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PasswordProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodIt',
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
  }
}
