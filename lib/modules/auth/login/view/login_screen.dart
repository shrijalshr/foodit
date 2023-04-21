import 'package:flutter/material.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:foodit/utils/widgets/my_textfield.dart';

import '../../../../core/theme/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AppColor color =
        Theme.of(context).extension<AppColor>() ?? AppColor.light;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: color.backgroundColor,
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            left: -30,
            top: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: color.primaryColor,
            ),
          ),
          Positioned(
            right: -50,
            top: 200,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: color.primaryColor,
            ),
          ),
          Positioned(
            left: -50,
            bottom: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: color.primaryColor,
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.fh,
                  ),
                  Image.asset(AssetPaths.googleLogo).pb(16),
                  Text(
                    "Welcome to FoodIt",
                    style: textTheme.headlineLarge,
                  ).pb(8),
                  Text(
                    "Order your food with ease",
                    style: textTheme.bodyMedium
                        ?.apply(color: color.lightGrey, fontWeightDelta: 300),
                  ).pb(24),
                  MyTextField(
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your mobile number.";
                      }
                      if (!value.isMobileNum()) {
                        return "Please enter valid mobile number.";
                      }
                      return null;
                    },
                    label: "Mobile number",
                    prefixIcon: const Icon(Icons.phone_android_outlined),
                  ).pb(20),
                  AppButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, Routes.homescreen);
                            }
                          },
                          label: "Login")
                      .pb(8),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: RichText(
                  //     text: TextSpan(
                  //       children: [
                  //         TextSpan(
                  //           text: "Don't have an account? ",
                  //           style: textTheme.bodyMedium?.apply(
                  //             fontWeightDelta: 400,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //           text: "Register now",
                  //           style: textTheme.bodyMedium?.apply(
                  //             fontWeightDelta: 400,
                  //             color: color.primaryColor,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ).pb(24),
                  // ),
                  // Row(
                  //   children: [
                  //     const Expanded(
                  //       child: Divider(),
                  //     ),
                  //     Text(
                  //       "OR",
                  //       style: textTheme.bodyLarge?.apply(
                  //           color: color.mistGrey, fontWeightDelta: 300),
                  //     ).ph(8),
                  //     const Expanded(child: Divider())
                  //   ],
                  // ).pb(8),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //       backgroundColor: color.white, elevation: 0),
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 12),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(
                  //           AssetPaths.googleLogo,
                  //           height: 24,
                  //         ).pr(16),
                  //         Text(
                  //           "Sign in with Google",
                  //           style: textTheme.labelMedium,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ).pb(24),
                ],
              ).ph(24),
            ),
          ),
        ],
      ),
    );
  }
}
