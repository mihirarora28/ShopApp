import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
class EditMyForms extends StatefulWidget {
  const EditMyForms({Key? key}) : super(key: key);

  @override
  _EditMyFormsState createState() => _EditMyFormsState();
}

class _EditMyFormsState extends State<EditMyForms> {

  final _priceFocusNode = FocusNode();
  final _DescriptionFocusNode = FocusNode();
  final _myControllerforImage = TextEditingController();
  final _myControllerTitle = TextEditingController();
  final _myControllerPrice = TextEditingController();
  final _myControllerDescription = TextEditingController();

  void _SaveForm(){
    var title = _myControllerTitle.text;
    var price = double.parse(_myControllerPrice.text);
    var ImageUrl = _myControllerforImage.text;
    var description = _myControllerDescription.text;
    final pproducts = Provider.of<Products>(context,listen: false);

    var newProduct = Product(
      title: title,
      price: price,
      imageUrl: ImageUrl,
      id: 'p' + pproducts.items.length.toString()

    );
    pproducts.addItem(newProduct);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _DescriptionFocusNode.dispose();
    _myControllerforImage.dispose();
    _myControllerTitle.dispose();
    _myControllerPrice.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        backgroundColor: Colors.yellow[800],
        actions: [
          IconButton(icon: Icon(Icons.save),onPressed: (){
_SaveForm();
          },)
        ],
      ),
      body:Form(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            TextFormField(
              onFieldSubmitted: (data){
                FocusScope.of(context).requestFocus(_priceFocusNode);
               },
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              controller: _myControllerTitle,
            ),
            TextFormField(
              controller: _myControllerPrice,
              onFieldSubmitted: (data){
                FocusScope.of(context).requestFocus(_DescriptionFocusNode);
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              decoration: InputDecoration(labelText: 'Price',

              ),
            ),
            TextFormField(
            controller:_myControllerDescription,
             maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              focusNode: _DescriptionFocusNode,
              decoration: InputDecoration(labelText: 'Description',

              ),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: _myControllerforImage.text.isEmpty?Center(child: Text('No Image')):Image.network(
                      _myControllerforImage.text
                  ),
                  decoration: BoxDecoration
                    border: Border.all(width: 1, color: Colors.grey)
                  ),
                  margin: EdgeInsets.only(top: 10.0, right: 8.0),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _myControllerforImage,
                    onChanged: (data){

                      setState(() {
                        print(data.toString());
                      });
                    },
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(

                      labelText: 'Enter the URL'
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
