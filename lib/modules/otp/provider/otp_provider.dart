import 'package:flutter/cupertino.dart';

class OTPProvider with ChangeNotifier {
  // ignore: non_constant_identifier_names
  List<String> message = [];
  bool isVerified = false;
}
