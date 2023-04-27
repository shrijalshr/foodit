// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/core/theme/app_color.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.label,
    this.initialText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.readOnly = false,
    this.validator,
    this.inputType,
    this.textController,
    this.borderRadius,
    this.textInputAction,
    this.onChanged,
    this.onSaved,
    this.inputFormatters,
    this.maxLength,
    this.autoFocus = false,
    this.counter,
    this.hintText,
  }) : super(key: key);

  final String? label;
  final String? initialText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? counter;
  final String? hintText;
  final int? maxLines;
  final bool readOnly;
  final bool autoFocus;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final double? borderRadius;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final AppColor color =
        Theme.of(context).extension<AppColor>() ?? AppColor.light;
    return TextFormField(
      autofocus: autoFocus,
      maxLength: maxLength,
      validator: validator,
      controller: textController,
      initialValue: initialText,
      keyboardType: inputType,
      readOnly: readOnly,
      inputFormatters: const [],
      textInputAction: textInputAction,
      maxLines: maxLines,
      style: TextStyle(
        color: color.darkGrey,
      ),
      decoration: InputDecoration(
        fillColor: color.white,
        filled: true,
        focusColor: color.mistGrey,
        hintText: hintText,
        hintStyle: context.textStyles.bodyMedium,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        labelText: label ?? '',
        prefixIcon: prefixIcon,
        labelStyle: const TextStyle(fontSize: 15),
        counter: counter,
      ),
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
