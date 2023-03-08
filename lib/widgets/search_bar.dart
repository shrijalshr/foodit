import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';

import '../modules/search_screen/search_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: SearchBarDelegate());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: context.color.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: context.color.darkGrey,
              size: 20,
            ).pr(5),
            Text(
              "Search...",
              style: context.textTheme.bodyMedium!
                  .copyWith(color: context.color.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
