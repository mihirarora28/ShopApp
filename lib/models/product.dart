import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
   String id;
   String title;
   String description;
   double price;
   String imageUrl;
  bool isFavourite;
  Product(
      {this.imageUrl = '31',
      this.description = '13',
      this.price = 31.1,
      this.id = '12',
      this.isFavourite = false,
      this.title = '12'});

  void toggle() {
    isFavourite = !isFavourite;
    print(isFavourite);
    notifyListeners();
  }
}
