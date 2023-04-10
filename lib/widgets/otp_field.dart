import 'package:flutter/material.dart';

import '../../core/theme/app_color.dart';

class OtpField extends StatelessWidget {
  final TextEditingController textEditingController;
  final double width;
  final double height;
  final String? Function(String?) validator;

  const OtpField(
      {Key? key,
      required this.textEditingController,
      this.width = 70,
      this.height = 60,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).extension<AppColor>()!;

    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        style: TextStyle(
          color: appColor.darkGrey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: textEditingController,
        maxLength: 1,
        cursorColor: appColor.lightGrey,
        decoration: InputDecoration(
          filled: true,
          fillColor: appColor.backgroundColor,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: appColor.mistGrey),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, style: BorderStyle.solid, color: appColor.errorColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: appColor.infoColor),
          ),
        ),
        onTap: () {
          textEditingController.clear();
        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
