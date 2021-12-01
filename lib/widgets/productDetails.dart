import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final idd = ModalRoute.of(context)?.settings.arguments as String;
    final Product loadedProducts = Provider.of<Products>(context)
        .items
        .firstWhere((element) => element.id == idd);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow[800],
          title: Text(loadedProducts.title.toString())),
    );
  }
}
