import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';

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
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        style: TextStyle(
          color: context.color.darkGrey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: textEditingController,
        maxLength: 1,
        cursorColor: context.color.primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.color.white,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: context.color.mistGrey),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: context.color.errorColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: context.color.primaryColor),
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
