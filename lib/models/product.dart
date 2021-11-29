import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product(
      {this.imageUrl = '31',
      this.description = '13',
      this.price = 31.1,
      this.id = '12',
      this.isFavourite = false,
      this.title = '12'});
}
