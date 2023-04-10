import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/otp_field.dart';
import '../provider/otp_provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.email});
  final String email;
  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController optController1;
  late TextEditingController optController2;
  late TextEditingController optController3;
  late TextEditingController optController4;
  late AnimationController _animationController;
  late Animation<Duration> _timerAnimation;

  @override
  void initState() {
    // TODO: implement initState
    optController1 = TextEditingController();
    optController2 = TextEditingController();
    optController3 = TextEditingController();
    optController4 = TextEditingController();
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
    final OTPProvider provider = Provider.of<OTPProvider>(context);
    final AppColor color = Theme.of(context).extension<AppColor>()!;
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
                      ?.apply(color: color.lightGrey),
                ),
                TextSpan(
                    text: widget.email,
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
              ).pr(15)),
              Expanded(
                  child: OtpField(
                      textEditingController: optController2,
                      validator: (value) {
                        return null;
                      }).pr(15)),
              Expanded(
                  child: OtpField(
                      textEditingController: optController3,
                      validator: (value) {
                        return null;
                      }).pr(15)),
              Expanded(
                  child: OtpField(
                textEditingController: optController4,
                validator: (value) {
                  return null;
                },
              ).pr(15)),
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
                          style: context.textTheme.displayMedium,
                        ));
                  }),
              GestureDetector(
                onTap: () {
                  _animationController.reset();
                  _animationController.forward();
                },
                child: Text(
                  "Re-send Code",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.apply(color: color.primaryColor),
                ),
              )
            ],
          ).pb(32),
          AppButton(
              onPressed: () {
                String otp = optController1.text +
                    optController2.text +
                    optController3.text +
                    optController4.text;
                print(otp);
              },
              label: "Continue"),
        ],
      ).pa(16)),
    );
  }
}
