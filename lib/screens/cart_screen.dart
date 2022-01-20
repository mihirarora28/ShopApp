import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/providers/orders.dart';

class cartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Cart>(context);
    final orders = Provider.of<orderITem>(context, listen: false);

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
                        product.totalAmount.toStringAsFixed(3),
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
                      onPressed: () {
                        orders.addOrder(
                            product.item.values.toList(), product.totalAmount);
                        product.clear();
                      },
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
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                    ),
                    confirmDismiss: (direction) =>showDialog(context: context,
                        builder: (ctx)=>  AlertDialog(
                        title: Text('Do you really want to delete the Row'),
                        actions: [
                          FlatButton(onPressed: (){
                            Navigator.of(context).pop(true);
                          }, child: Text('YES')),
                          FlatButton(onPressed: (){
                            Navigator.of(context).pop(false);
                          }, child: Text('NO')),
                        ],
                      )
                    ),
                    onDismissed: (direction) {
                      product.removeItem(product.item.keys.toList()[i]);

                    },
                    child: Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: FittedBox(
                                child: Text(
                                  ((product.item.values.toList()[i].price) *
                                          (product.item.values
                                              .toList()[i]
                                              .quantity))
                                      .toStringAsFixed(2),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          title: Text(product.item.values.toList()[i].title),
                          subtitle: Text('Total Amount: ' +
                              ((product.item.values.toList()[i].price) *
                                      (product.item.values
                                          .toList()[i]
                                          .quantity))
                                  .toStringAsFixed(3)),
                          trailing: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('X ' +
                                product.item.values
                                    .toList()[i]
                                    .quantity
                                    .toString()),
                          ),
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
