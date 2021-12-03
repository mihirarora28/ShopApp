import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';

class cartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        backgroundColor: Colors.yellow[800],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Chip(
                      label: Text(
                        product.totalAmount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.purple[400],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: FlatButton(
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(color: Colors.purple),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: product.itemcounts,
                itemBuilder: (ctx, i) {
                  return Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: FittedBox(
                              child: Text(
                                ((product.item.values.toList()[i].price) *
                                        (product.item.values
                                            .toList()[i]
                                            .quantity))
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        title: Text(product.item.values.toList()[i].title),
                        subtitle: Text('Total Amount: ' +
                            ((product.item.values.toList()[i].price) *
                                    (product.item.values.toList()[i].quantity))
                                .toString()),
                        trailing: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('X ' +
                              product.item.values
                                  .toList()[i]
                                  .quantity
                                  .toString()),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
