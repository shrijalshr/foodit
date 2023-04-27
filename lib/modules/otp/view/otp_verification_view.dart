import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/modules/auth/login/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/widgets/app_button.dart';
import '../../../utils/widgets/otp_field.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.number});
  final String number;
  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController optController1;
  late TextEditingController optController2;
  late TextEditingController optController3;
  late TextEditingController optController4;
  late TextEditingController optController5;
  late TextEditingController optController6;
  late AnimationController _animationController;
  late Animation<Duration> _timerAnimation;

  @override
  void initState() {
    // TODO: implement initState
    optController1 = TextEditingController();
    optController2 = TextEditingController();
    optController3 = TextEditingController();
    optController4 = TextEditingController();
    optController5 = TextEditingController();
    optController6 = TextEditingController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 120));

    _timerAnimation =
        Tween<Duration>(begin: const Duration(seconds: 120), end: Duration.zero)
            .animate(_animationController);
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    final AuthProvider provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verify your account",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          RichText(
              textAlign: TextAlign.left,
              text: TextSpan(children: [
                TextSpan(
                  text: "We have sent the otp code to the email address ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.apply(color: context.color.lightGrey),
                ),
                TextSpan(
                    text: widget.number,
                    style: Theme.of(context).textTheme.titleMedium)
              ])).pb(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: OtpField(
                textEditingController: optController1,
                validator: (value) {
                  return null;
                },
              ).pr(5)),
              Expanded(
                  child: OtpField(
                      textEditingController: optController2,
                      validator: (value) {
                        return null;
                      }).pr(5)),
              Expanded(
                  child: OtpField(
                      textEditingController: optController3,
                      validator: (value) {
                        return null;
                      }).pr(5)),
              Expanded(
                  child: OtpField(
                textEditingController: optController4,
                validator: (value) {
                  return null;
                },
              ).pr(5)),
              Expanded(
                  child: OtpField(
                      textEditingController: optController5,
                      validator: (value) {
                        return null;
                      }).pr(5)),
              Expanded(
                  child: OtpField(
                      textEditingController: optController6,
                      validator: (value) {
                        return null;
                      }).pr(5)),
            ],
          ).pb(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    final minutes = _timerAnimation.value.inMinutes;
                    final seconds = _timerAnimation.value.inSeconds % 60;
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Expires in $minutes:$seconds',
                          style: context.textStyles.displayMedium,
                        ));
                  }),
              GestureDetector(
                onTap: () {
                  // provider.sendVerificationCode(widget.number);
                  // _animationController.reset();
                  // _animationController.forward();
                },
                child: Text(
                  "Re-send Code",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.apply(color: context.color.primaryColor),
                ),
              )
            ],
          ).pb(32),
          AppButton(
              onPressed: () {
                String otp = optController1.text +
                    optController2.text +
                    optController3.text +
                    optController4.text +
                    optController5.text +
                    optController6.text;
                print(otp);
                // provider.signInWithSmsCode(otp);
              },
              label: "Continue"),
        ],
      ).pa(16)),
    );
  }
}
