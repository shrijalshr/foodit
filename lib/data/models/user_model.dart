// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.phone,
    this.address,
    this.name,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  final String? email;
  final String? phone;
  final String? address;
  final String? name;
  final String? image;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  UserModel copyWith({
    String? email,
    String? phone,
    String? address,
    String? name,
    String? image,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      name: name ?? this.name,
      image: image ?? this.image,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'phone': phone,
      'address': address,
      'name': name,
      'image': image,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, phone: $phone, address: $address, name: $name, image: $image, updatedAt: $updatedAt, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.name == name &&
        other.image == image &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        name.hashCode ^
        image.hashCode ^
        updatedAt.hashCode ^
        createdAt.hashCode ^
        id.hashCode;
  }
}
