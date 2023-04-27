// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  }) {
    return ItemModel(
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
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'desc': desc,
      'price': price,
      'category_id': categoryId,
      'is_featured': isFeatured,
      'cat_name': catName,
      'cat_image': catImage,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      categoryId: map['category_id'] != null ? map['category_id'] as int : null,
      isFeatured: map['is_featured'] != null ? map['is_featured'] as int : null,
      catName: map['cat_name'] != null ? map['cat_name'] as String : null,
      catImage: map['cat_image'] != null ? map['cat_image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, image: $image, desc: $desc, price: $price, category_id: $categoryId, is_featured: $isFeatured, cat_name: $catName, cat_image: $catImage)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.desc == desc &&
        other.price == price &&
        other.categoryId == categoryId &&
        other.isFeatured == isFeatured &&
        other.catName == catName &&
        other.catImage == catImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        categoryId.hashCode ^
        isFeatured.hashCode ^
        catName.hashCode ^
        catImage.hashCode;
  }
}
