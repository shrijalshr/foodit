import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/data/models/user_model.dart';
import 'package:foodit/modules/auth/login/provider/auth_provider.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:foodit/utils/widgets/my_textfield.dart';
import 'package:foodit/utils/widgets/scrollable_column.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key, this.userModel});

  final UserModel? userModel;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.userModel?.name);
    numberController = TextEditingController(text: widget.userModel?.phone);
    emailController = TextEditingController(text: widget.userModel?.email);
    addressController = TextEditingController(text: widget.userModel?.address);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile Settings"),
        ),
        body: ScrollableColumn(
          children: [
            SizedBox(
              width: 100.fw,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12.fw,
                      backgroundImage: NetworkImage(authProvider.profileUrl!),
                    ).pb(4),
                    // InkWell(
                    //   onTap: () {
                    //     provider.pickImage(context);
                    //   },
                    //   splashColor: context.color.secondaryColor,
                    //   child: Text(
                    //     "Change Profile Picture",
                    //     style: context.textTheme.labelSmall,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ).pb(16),
            SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    height: 3.fh,
                  ),
                  MyTextField(
                    textController: nameController,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your name";
                      }
                      if (value.length <= 1) {
                        return "Length of name should be greater than 1";
                      }
                      return null;
                    },
                    label: "Full Name",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                  ).pb(16),
                  MyTextField(
                    textController: emailController,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your email";
                      }
                      if (value.isEmail()) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                    label: "Email",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                  ).pb(16),
                  MyTextField(
                    textController: numberController,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your mobile number";
                      }
                      if (value.isMobileNum()) {
                        return "Please enter a valid mobile number";
                      }
                      return null;
                    },
                    label: "Mobile Number",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.phone,
                  ).pb(16),
                  MyTextField(
                    textController: addressController,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your address";
                      }
                      if (value.length < 2) {
                        return "Length of address should be greater than 2";
                      }
                      return null;
                    },
                    label: "Address",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.streetAddress,
                  ).pb(24),
                  AppButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map data = {
                            "image": widget.userModel?.image,
                            "name": widget.userModel?.name,
                            "email": widget.userModel?.email,
                            "address": addressController.text,
                            "phone": numberController.text,
                          };

                          authProvider.submitForm(data).then((isSuccess) {
                            if (isSuccess) {
                              if (context.mounted) {
                                Navigator.pushNamed(context, Routes.homescreen);
                              }
                            }
                          });
                        }
                      },
                      label: "Save")
                ],
              ),
            ).ph(16),
          ],
        ));
  }
}
