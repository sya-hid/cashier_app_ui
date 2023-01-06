import 'dart:developer';

import 'package:cashier_app_ui/model/cart.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyData {
  List<Cart> carts = [];
  final _myBox = Hive.box('cashier_app');

  void initData() {
    carts = [];
    log('init data');
  }

  void loadData() {
    carts = _myBox.get('carts');
    log('load data');
  }

  void updateData() {
    _myBox.put('carts', carts);
  }
}
