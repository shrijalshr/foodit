import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/data/models/user_model.dart';
import 'package:foodit/utils/helper/sp.dart';
import 'package:foodit/utils/widgets/app_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    getUser();
    super.initState();
  }

  UserModel? user;
  getUser() async {
    String? userStr = await getStringFromSP("user");
    if (userStr != null) {
      Map<String, dynamic> userMap = jsonDecode(userStr);
      setState(() {
        user = UserModel.fromMap(userMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.color.white),
        title: Text(
          "Profile",
          style: context.textStyles.bodyLarge
              ?.copyWith(color: context.color.white),
        ),
        backgroundColor: context.color.secondaryColor,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: context.color.secondaryColor),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30.fh,
                    child: Stack(
                      children: [
                        Container(
                          height: 10.fh,
                          width: 100.fw,
                          color: context.color.secondaryColor,
                        ),
                        Positioned(
                          top: 30,
                          child: SizedBox(
                            // height: 60.fh,
                            width: 100.fw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 10.fw,
                                  backgroundImage:
                                      CachedNetworkImageProvider(user!.image!),
                                ),
                                Text(
                                  user!.name ?? "Shrijal Shrestha",
                                  style: context.textStyles.headlineSmall,
                                ).pb(4),
                                Text(
                                  user!.email ?? "shrijalisdev@gmail.com",
                                  style: context.textStyles.bodyMedium,
                                ),
                                Text(
                                  user!.phone ?? "9804320218",
                                  style: context.textStyles.bodyMedium,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: context.color.lightGrey,
                                      size: 20,
                                    ).pr(4),
                                    Flexible(
                                      child: Text(
                                        user!.address ?? "Biratnagar-12 ",
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ).ph(16)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "General",
                        style: context.textStyles.headlineMedium,
                      ).pb(10),
                      ProfileTile(
                        icon: Icons.settings_outlined,
                        title: "Profile Settings",
                        onTap: () async {
                          if (context.mounted) {
                            Navigator.pushNamed(context, Routes.profileForm,
                                arguments: user);
                          }
                        },
                      ),
                      ProfileTile(
                        icon: Icons.restaurant_menu_outlined,
                        title: "My Orders",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.myOrder);
                        },
                      ),
                      ProfileTile(
                        icon: Icons.notifications_none,
                        title: "Favorites",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.myOrder);
                        },
                      ),
                      ProfileTile(
                        icon: Icons.favorite_outline,
                        title: "Notifications",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.myOrder);
                        },
                      ),
                      ProfileTile(
                          title: "Log Out",
                          icon: Icons.logout_outlined,
                          onTap: () {
                            showDialog(
                              context: context,
                              useSafeArea: true,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  titlePadding: const EdgeInsets.all(
                                    20,
                                  ),
                                  title: Text(
                                    "Are you sure you want to log out?",
                                    style: context.textStyles.displayMedium,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  actions: [
                                    SizedBox(
                                      width: 100,
                                      child: AppButton.secondary(
                                          onPressed: () async {
                                            final GoogleSignIn googleSignIn =
                                                GoogleSignIn();
                                            googleSignIn.signOut();
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.clear();
                                            if (context.mounted) {
                                              Navigator.pushReplacementNamed(
                                                  context, Routes.login);
                                            }
                                          },
                                          label: "Yes"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: AppButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          label: "No"),
                                    ),
                                  ],
                                );
                              },
                            );
                          })
                    ],
                  ).ph(16),
                ],
              ),
            ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: context.textStyles.displayMedium,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
