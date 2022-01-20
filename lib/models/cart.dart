import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product.dart';

class Cartitem {
  final String id;
  final String title;

  final int quantity;
  final double price;
  final String image;
  Cartitem(
      {this.id = '1',
      this.title = '2',
      this.quantity = 1,
      this.price = 31.1,
      this.image = '1'});
}

class Cart with ChangeNotifier {
  late Map<String, Cartitem> _items = {};

  Map<String, Cartitem> get item {
    return {..._items};
  }

  int get itemcounts {
    return _items.length;
  }

  double get totalAmount {
    double totalsum = 0;
    _items.forEach((key, value) {
      totalsum = totalsum + (value.price) * (value.quantity);
    });
    return totalsum;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void addItem(String ProductId, String title, double price, String url) {
    if (_items.containsKey(ProductId)) {
      _items.update(ProductId, (value) {
        return Cartitem(
          id: value.id,
          title: value.title,
          quantity: _items[ProductId]!.quantity + 1,
          price: price,
          image: url,
        );
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
  void removeAnItem(String id){
    if(_items.containsKey(id)){
      if(_items[id]!.quantity > 1){
        _items.update(id, (value) {
          return Cartitem(
            id: value.id,
            title: value.title,
            quantity: _items[id]!.quantity - 1,
            price: value.price,
            image: value.image,
          );
        });
      }
      else{
        _items.remove(id);
      }
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
