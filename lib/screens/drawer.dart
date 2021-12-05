import 'package:flutter/material.dart';

class appDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.yellow[800],
            title: Text('Shop App'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/cartScreen2');
            },
            title: Text('Your Orders'),
            leading: Icon(Icons.shopping_bag),
          ),
          Divider(
            height: 5.0,
            thickness: 2.0,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            title: Text('My Shop'),
            leading: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}
