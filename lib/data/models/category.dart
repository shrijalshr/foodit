// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  int id;
  String name;
  String imgPath;
  Category({
    required this.id,
    required this.name,
    required this.imgPath,
  });

  Category copyWith({
    int? id,
    String? name,
    String? imgPath,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imgPath': imgPath,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      imgPath: map['imgPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(id: $id, name: $name, imgPath: $imgPath)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.imgPath == imgPath;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imgPath.hashCode;
}
