// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    this.id,
    this.name,
    this.image,
    this.desc,
    this.price,
    this.categoryId,
    this.isFeatured,
    this.catName,
    this.catImage,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? desc;
  final String? price;
  final int? categoryId;
  final int? isFeatured;
  final String? catName;
  final String? catImage;

  ItemModel copyWith({
    int? id,
    String? name,
    String? image,
    String? desc,
    String? price,
    int? categoryId,
    int? isFeatured,
    String? catName,
    String? catImage,
  }) =>
      ItemModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        desc: desc ?? this.desc,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
        isFeatured: isFeatured ?? this.isFeatured,
        catName: catName ?? this.catName,
        catImage: catImage ?? this.catImage,
      );

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        desc: json["desc"],
        price: json["price"],
        categoryId: json["category_id"],
        isFeatured: json["is_featured"],
        catName: json["cat_name"],
        catImage: json["cat_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "desc": desc,
        "price": price,
        "category_id": categoryId,
        "is_featured": isFeatured,
        "cat_name": catName,
        "cat_image": catImage,
      };
}
