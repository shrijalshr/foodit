import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodit/core/export.dart';
import 'package:foodit/data/models/item_model.dart';
import 'package:foodit/data/models/order_model.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../data/models/user_model.dart';
import '../../../services/order_service.dart';
import '../../../utils/helper/sp.dart';
import '../../check_out/provider/check_out_provider.dart';

class OrderProvider extends ChangeNotifier {
  initS() {
    calculateTotal();
    getUser();
    getOrderList();
  }

  final List<SingleItemOrderModel> _items = [];

  get cartItems => _items;

  addToCart(ItemModel item, int qty) async {
    for (var cartItem in _items) {
      if (item.id == cartItem.item?.id) {
        SingleItemOrderModel newItem = cartItem.copyWith(
          qty: cartItem.qty! + qty,
        );
        _items.add(newItem);
        _items.remove(cartItem);
        notifyListeners();
        return;
      }
    }
    SingleItemOrderModel itemModel = SingleItemOrderModel(item: item, qty: qty);
    _items.add(itemModel);
    print(_items);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(SingleItemOrderModel item) {
    _items.remove(item);
    notifyListeners();
  }

  void incItem(SingleItemOrderModel item) {
    SingleItemOrderModel newItem = item.copyWith(qty: item.qty! + 1);
    _items.add(newItem);
    _items.remove(item);
    calculateTotal();
    notifyListeners();
  }

  void dcrItem(item) {
    if (item.qty == 1) {
      _items.remove(item);

      calculateTotal();
      notifyListeners();
      return;
    }
    SingleItemOrderModel newItem = item.copyWith(qty: item.qty! - 1);
    _items.add(newItem);
    _items.remove(item);
    calculateTotal();
    notifyListeners();
  }

  double _total = 0.0;
  double get total => _total;
  calculateTotal() {
    _total = 0;
    for (var item in _items) {
      double itotal = item.item!.price!.toDouble()! * item.qty!;
      _total = _total + itotal;
    }
    notifyListeners();
  }

  List orderItems = [];
  getOrderItemList() {
    for (var item in _items) {
      Map<String, dynamic> oItem = {
        "item_id": item.item?.id,
        "qty": item.qty,
      };
      orderItems.add(oItem);
    }
  }

  int? orderTypeInt;
  OrderType? selectedOrderType;
  onSelectOrderType(value) {
    selectedOrderType = value;
    orderTypeInt = selectedOrderType?.getInt();
    print(orderTypeInt);
    notifyListeners();
  }

  UserModel? user;

  getUser() async {
    String? userStr = await getStringFromSP("user");
    print(userStr);
    if (userStr != null) {
      Map<String, dynamic> userMap = jsonDecode(userStr);
      UserModel u = UserModel.fromMap(userMap);
      print(u.toString());
      user = u;
    }
    notifyListeners();
  }

  final config = PaymentConfig(
    amount: 2, // Amount should be in paisa
    productIdentity: 'dell-g5-g5510-2021',
    productName: '',
    // productUrl: 'https://www.khalti.com/#/bazaar',
    additionalData: {
      // Not mandatory; can be used for reporting purpose
      'vendor': 'Khalti Bazaar',
    },
    mobile:
        '9800000001', // Not mandatory; can be used to fill mobile number field
    mobileReadOnly: true, // Not mandatory; makes the mobile field not editable
  );

  postOrder(context, data) async {
    OrderService service = OrderService();
    await service.postOrder(data).then((isSuccess) {
      if (isSuccess) {
        Navigator.pushNamed(context, Routes.orderConfirmation);
      }
    });
  }

  getOrderList() async {
    OrderService service = OrderService();
    await service.getOrderList().then((isSuccess) {
      // if (isSuccess) {
      //   Navigator.pushNamed(context, Routes.orderConfirmation);
      // }
    });
  }
}
