import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:foodit/core/const/assets_path.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';
import 'package:foodit/modules/cart/view/cart_screen.dart';
import 'package:foodit/modules/favorite/view/favorite_screen.dart';
import 'package:foodit/modules/homescreen/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/search_bar.dart';
import '../widgets/categories_carousel.dart';
import '../widgets/featured_item_carousel.dart';
import '../widgets/greeting_text.dart';
import '../widgets/homescreen_text.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const List<Widget> navIconList = [
    Icon(Icons.home_outlined, size: 24),
    Icon(Icons.explore_outlined, size: 24),
    Icon(Icons.shopping_cart_outlined, size: 24),
    Icon(Icons.favorite_outline, size: 24),
  ];

  final List<Widget> pages = [
    HomeScreenBody(),
    const SizedBox(),
    const CartScreen(),
    const FavoriteScreen()
  ];

  //State class
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 56,
          index: context.read<HomeProvider>().selectedIndex,
          animationDuration: const Duration(milliseconds: 200),
          items: navIconList,
          onTap: (index) {
            context.read<HomeProvider>().onNavTap(context, index);
          },
        ),
        body: WillPopScope(
            onWillPop: () {
              context.read<HomeProvider>().checkIfOnHomeScreen();
              if (!context.read<HomeProvider>().onHomeScreen) {
                return Future.value(false);
              }
              return Future.value(true);
            },
            child:
                pages.elementAt(context.watch<HomeProvider>().selectedIndex)));
  }
}

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    super.key,
  });

  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: context.color.white,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      drawer: SafeArea(
          child: Column(
        children: [
          Container(
            // width: 128.0,
            height: 128.0,
            margin: const EdgeInsets.only(
              top: 24.0,
              bottom: 64.0,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AssetPaths.defaultAvatar,
            ),
          ),
          ListTile(
            onTap: () {
              _advancedDrawerController.hideDrawer();
            },
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.account_circle_rounded),
            title: const Text('Profile'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.myOrder);
            },
            leading: const Icon(Icons.list_alt_outlined),
            title: const Text('My Orders'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.favorites);
            },
            leading: const Icon(Icons.favorite),
            title: const Text('Favourites'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: const Text('Terms of Service | Privacy Policy'),
          ),
        ],
      )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("FoodIt"),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_2_outlined,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 05.fh,
              ),
              const GreetingText(),
              const HomeScreenText().pb(24),
              const SearchBar().pb(24),
              const CategoriesCarousel(),
              const FeaturedItemCarousel(),
              const SizedBox(
                height: 20,
              )
            ],
          ).ph(16),
        ),
      ),
    );
  }
}
