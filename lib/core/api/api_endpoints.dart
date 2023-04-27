class ApiEndPoints {
  ApiEndPoints._();

  static const _office = "192.168.1.103:8000";
  static const _home = "192.168.254.167:8000";
  static const _home2 = "192.168.1.84:8000";
  static const ip = _office;
  static const BASE_URL = "http://$ip/api/";
  static const IMG_URL = "http://$ip/";
  static const GET_URL = ip;

  static const categories = "cats";
  static const items = "items";
  static const user = "user";
  static const userUpdate = "api/user/update";
  static const order = "api/user/order";
  static const orderList = "api/user/order/list";
}
