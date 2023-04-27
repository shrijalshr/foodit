import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';

class MyDropDown<T> extends StatelessWidget {
  const MyDropDown({
    super.key,
    required this.items,
    required this.hintText,
    required this.value,
    required this.onChanged,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.autofocus = false,
    this.contentPadding = const EdgeInsets.only(
      top: 14,
      bottom: 14,
      right: 8,
    ),
    this.isExpanded = true,
    this.fillColor,
  });
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hintText;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry contentPadding;
  final bool autofocus;
  final FocusNode? focusNode;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool isExpanded;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            items: items,
            hint: Text(
              hintText,
              style: TextStyle(
                color: context.color.lightGrey,
              ),
            ),
            isExpanded: isExpanded,
            iconEnabledColor: context.color.lightGrey,
            value: value,
            autofocus: autofocus,
            focusNode: focusNode,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            borderRadius: BorderRadius.circular(8.0),
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: contentPadding,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.color.lightGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.color.lightGrey,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.color.errorColor,
                ),
              ),
              filled: true,
              fillColor: fillColor ?? context.color.white,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
