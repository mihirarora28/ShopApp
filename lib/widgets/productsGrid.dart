import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatefulWidget {
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: true);
    List<Product> items1 = products.items;
    // for (int i = 0; i < items1.length; i++) {
    //   print(items1[i].title);
    //   print(items1.length);
    // }
    if (products.isFavourties == true) {
      items1 = items1.where((element) => element.isFavourite == true).toList();
    } else {
      items1 = products.items;
    }
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: items1.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
              value: items1[i], child: myTile());
        });
  }
}
