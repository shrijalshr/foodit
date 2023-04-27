// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'item_model.dart';

class SingleItemOrderModel {
  final ItemModel? item;
  final int? qty;
  SingleItemOrderModel({
    this.item,
    this.qty,
  });

  SingleItemOrderModel copyWith({
    ItemModel? item,
    int? qty,
  }) {
    return SingleItemOrderModel(
      item: item ?? this.item,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item': item?.toMap(),
      'qty': qty,
    };
  }

  factory SingleItemOrderModel.fromMap(Map<String, dynamic> map) {
    return SingleItemOrderModel(
      item: map['item'] != null
          ? ItemModel.fromMap(map['item'] as Map<String, dynamic>)
          : null,
      qty: map['qty'] != null ? map['qty'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleItemOrderModel.fromJson(String source) =>
      SingleItemOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SingleOrderModel(item: $item, qty: $qty)';

  @override
  bool operator ==(covariant SingleItemOrderModel other) {
    if (identical(this, other)) return true;

    return other.item == item && other.qty == qty;
  }

  @override
  int get hashCode => item.hashCode ^ qty.hashCode;
}
