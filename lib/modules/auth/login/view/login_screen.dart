import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/modules/auth/login/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController mobileController;

  @override
  void initState() {
    mobileController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider provider = Provider.of(context);

    return Scaffold(
      backgroundColor: context.color.backgroundColor,
      appBar: null,
      body: Stack(
        children: [
          Positioned(
            left: -30,
            top: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: context.color.primaryColor,
            ),
          ),
          Positioned(
            right: -50,
            top: 200,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: context.color.primaryColor,
            ),
          ),
          Positioned(
            left: -50,
            bottom: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: context.color.primaryColor,
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
                  Image.asset(AssetPaths.logo).pb(16),
                  Text(
                    "Welcome to FoodIt",
                    style: context.textStyles.headlineLarge,
                  ).pb(8),
                  Text(
                    "Order your food with ease",
                    style: context.textStyles.bodyMedium?.apply(
                        color: context.color.lightGrey, fontWeightDelta: 300),
                  ).pb(24),
                  // MyTextField(
                  //   textController: mobileController,
                  //   validator: (value) {
                  //     if (value == null || value.trim() == "") {
                  //       return "Please enter your mobile number.";
                  //     }
                  //     if (!value.isMobileNum()) {
                  //       return "Please enter valid mobile number.";
                  //     }
                  //     return null;
                  //   },
                  //   label: "Mobile number",
                  //   inputType: TextInputType.phone,
                  //   prefixIcon: const Icon(Icons.phone_android_outlined),
                  // ).pb(20),
                  // AppButton(
                  //         onPressed: () {
                  //           if (_formKey.currentState!.validate()) {
                  //             String number =
                  //                 "+977${mobileController.text.trim()}";
                  //             // provider.sendVerificationCode(number);
                  //             Navigator.pushNamed(context, Routes.otpScreen,
                  //                 arguments: number);
                  //           }
                  //         },
                  //         label: "Login")
                  //     .pb(8),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: RichText(
                  //     text: TextSpan(
                  //       children: [
                  //         TextSpan(
                  //           text: "Don't have an account? ",
                  //           style: context.textTheme.bodyMedium?.apply(
                  //             fontWeightDelta: 400,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //           text: "Register now",
                  //           style: context.textTheme.bodyMedium?.apply(
                  //             fontWeightDelta: 400,
                  //             color: context.color.primaryColor,
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
                  //       style: context.textTheme.bodyLarge?.apply(
                  //           color: context.color.mistGrey,
                  //           fontWeightDelta: 300),
                  //     ).ph(8),
                  //     const Expanded(child: Divider())
                  //   ],
                  // ).pb(8),
                  ElevatedButton(
                    onPressed: () async {
                      provider.signInWithGoogle(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.color.white, elevation: 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetPaths.googleLogo,
                            height: 24,
                          ).pr(16),
                          Text(
                            "Sign in with Google",
                            style: context.textStyles.labelMedium,
                          )
                        ],
                      ),
                    ),
                  ).pb(24),
                ],
              ).ph(24),
            ),
          ),
        ],
      ),
    );
  }
}
