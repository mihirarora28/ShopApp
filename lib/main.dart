import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product.dart';
import 'package:shop_app/widgets/productDetails.dart';
import 'package:shop_app/widgets/productsGrid.dart';
import 'models/product.dart';

void main() {
  runApp(MyApp());
}

enum FilterSelection {
  OnlyFavourites,
  ShowAll,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: MyHomePage(),
        routes: {
          '/categories': (ctx) => ProductDetails(),
        },
      ),
    );
  }
}

FilterSelection isSelected = FilterSelection.ShowAll;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final container = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: (FilterSelection value) {
                isSelected = value;
                if (isSelected == FilterSelection.OnlyFavourites) {
                  setState(() {
                    container.isFavourties = true;
                  });
                } else {
                  setState(() {
                    container.isFavourties = false;
                  });
                }
                print(isSelected);
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text('Only Favourites'),
                    value: FilterSelection.OnlyFavourites,
                  ),
                  PopupMenuItem(
                      child: Text('Show me All'),
                      value: FilterSelection.ShowAll),
                ];
              })
        ],
        backgroundColor: Colors.yellow[800],
        title: Text('Shop App'),
      ),
      body: ProductsGrid(),
    );
  }
}
