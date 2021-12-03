import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product.dart';

class Cartitem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  Cartitem(
      {this.id = '1', this.title = '2', this.quantity = 1, this.price = 31.1});
}

class Cart with ChangeNotifier {
  late Map<String, Cartitem> _items = {};

  Map<String, Cartitem> get item {
    return {..._items};
  }

  int get itemcounts {
    return _items.length;
  }

  void addItem(String ProductId, String title, double price) {
    if (_items.containsKey(ProductId)) {
      _items.update(ProductId, (value) {
        return Cartitem(
            id: value.id,
            title: value.title,
            quantity: _items[ProductId]!.quantity + 1,
            price: price);
      });
    } else {
      _items.putIfAbsent(
          ProductId,
          () => Cartitem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }
}
