import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/drawer.dart';
class ProductDetailsUserChange extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productsofScreen = Provider.of<Products>(context, listen: true);
    final myList = productsofScreen.items;
    return Scaffold(
      drawer: appDrawer(),
      appBar: AppBar(
        title: Text('Shop App'),
        backgroundColor: Colors.yellow[800],
        actions: [
         IconButton(onPressed: (){
           Navigator.of(context).pushNamed('/editMyProducts');
         }, icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(left: 5.0, top: 20.0),
        itemCount: myList.length,
          itemBuilder: (ctx,index){
        return Column(
          children:[ Container(
            width: MediaQuery.of(context).size.width,
            child: ListTile(

              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                    minRadius: 20.0,
                    maxRadius: 30.0,
                    child: Image.network(myList[index].imageUrl , fit: BoxFit.cover,)),

              ),
              title: Text(myList[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: Container(
                width: 100,
                child: Row(
                      children: [
                        IconButton(onPressed: (){
                          productsofScreen.deleteAnItem(myList[index].id);
                        }, icon: Icon(Icons.delete,color: Theme.of(context).errorColor,)),
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.edit),),
                      ],
                ),
              ),
            ),
          ),
            Divider()
            ]
        );
      })
    );
  }
}
