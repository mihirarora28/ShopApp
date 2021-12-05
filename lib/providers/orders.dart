import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';

class order {
  @required
  final String id;
  @required
  final List<Cartitem> products;
  @required
  final double total;
  @required
  final DateTime dateTime;
  bool expanded;
  order({
    required this.dateTime,
    this.id = '1',
    this.products = const [],
    this.total = 12.1,
    this.expanded = false,
  });
}

class orderITem with ChangeNotifier {
  List<order> orders = [];
  List<order> get items {
    return [...orders];
  }

  void addOrder(List<Cartitem> carts, double price) {
    orders.insert(
        0,
        order(
            id: DateTime.now().toString(),
            products: carts,
            total: price,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
