import 'package:flutter/material.dart';
import 'package:foodit/core/theme/app_color.dart';
import 'package:foodit/widgets/password_field/password_provider.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    this.textEditingController,
    this.label,
    this.textInputAction,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);
  final String? label;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    final PasswordProvider passwordProvider = Provider.of<PasswordProvider>(
      context,
    );
    print(passwordProvider.showPassword);

    final AppColor color =
        Theme.of(context).extension<AppColor>() ?? AppColor.light;
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      obscureText: !passwordProvider.showPassword,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: color.mistGrey,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        labelText: label ?? 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        labelStyle: const TextStyle(fontSize: 15),
        suffixIcon: GestureDetector(
          onTap: () {
            passwordProvider.togglePassword(passwordProvider.showPassword);
          },
          child: passwordProvider.showPassword
              ? const Icon(
                  Icons.visibility_off,
                )
              : const Icon(Icons.visibility),
        ),
      ),
    );
  }
}
