import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:intl/intl.dart';

class ordersScreen extends StatefulWidget {
  @override
  _ordersScreenState createState() => _ordersScreenState();
}

class _ordersScreenState extends State<ordersScreen> {
  bool _expanded = false;
  Map<String, int> visited = {};
  double min(int a, int b) {
    if (a > b)
      return b.toDouble();
    else
      return a.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final myorder = Provider.of<orderITem>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Shop App'),
          backgroundColor: Colors.yellow[800],
        ),
        body: ListView.builder(
          itemCount: myorder.items.length,
          itemBuilder: (ctx, i) {
            print(myorder.items[i].products.length);
            if (myorder.items[i].expanded == false) {
              return Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_downward_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          myorder.items[i].expanded = true;
                        });
                      },
                    ),
                    title: Text(myorder.items[i].total.toStringAsFixed(2)),
                    subtitle: Text(DateFormat.yMMMMEEEEd()
                        .format(myorder.items[i].dateTime)),
                  ),
                ),
              );
            } else {
              return Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(children: [
                    ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_upward,
                        ),
                        onPressed: () {
                          setState(() {
                            myorder.items[i].expanded = false;
                          });
                        },
                      ),
                      title: Text(myorder.items[i].total.toStringAsFixed(2)),
                      subtitle: Text(DateFormat.yMMMMEEEEd()
                          .format(myorder.items[i].dateTime)),
                    ),
                    Container(
                      height: min(100, myorder.items[i].products.length * 50),
                      child: ListView.builder(
                          itemCount: myorder.items[i].products.length,
                          itemBuilder: (ctx, j) {
                            return ListTile(
                              title: Text(myorder.items[i].products[j].title),
                              trailing: Text('X ' +
                                  myorder.items[i].products[j].quantity
                                      .toString()),
                            );
                          }),
                    ),
                  ]),
                ),
              );
            }
          },
        ));
  }
}
