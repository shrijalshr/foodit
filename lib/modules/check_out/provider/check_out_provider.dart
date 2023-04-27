// ignore: constant_identifier_names
enum OrderType { Delivery, TakeOut }

extension SessionEx on OrderType {
  int getInt() {
    switch (this) {
      case OrderType.Delivery:
        return 0;
      case OrderType.TakeOut:
        return 1;
      default:
        return 0;
    }
  }
}
