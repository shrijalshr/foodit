import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';
import 'package:foodit/core/routes/routes.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.label,
    required this.imgPath,
    required this.id,
  });

  final String label;
  final String imgPath;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemList);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: context.color.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 80,
                child: Image.asset(
                  imgPath,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ).pb(8),
              ),
              SizedBox(
                height: 15,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayMedium
                      ?.copyWith(color: context.color.lightGrey),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
