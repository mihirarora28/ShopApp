import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product.dart';
import 'package:shop_app/widgets/productDetails.dart';
import 'package:shop_app/widgets/productsGrid.dart';
import 'models/product.dart';
import 'package:shop_app/screens/cart_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: orderITem(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: MyHomePage(),
        routes: {
          '/categories': (ctx) => ProductDetails(),
          '/cartScreen': (ctx) => cartScreen(),
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
    final conf = Provider.of<Cart>(context, listen: true);
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
              }),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/cartScreen');
              },
              child: Badge(
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  color: Colors.red,
                  value: conf.itemcounts.toString()),
            ),
          )
        ],
        backgroundColor: Colors.yellow[800],
        title: Text('Shop App'),
      ),
      body: ProductsGrid(),
    );
  }
}
