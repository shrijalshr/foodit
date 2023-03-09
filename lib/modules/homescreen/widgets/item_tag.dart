
import 'package:flutter/material.dart';
import 'package:foodit/core/extensions/app_extensions.dart';

class ItemTag extends StatelessWidget {
  const ItemTag({
    super.key,
    required this.tagName,
  });

  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.color.backgroundColor,
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(tagName),
    );
  }
}
