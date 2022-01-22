import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
class EditMyForms extends StatefulWidget {
  final editedId;
EditMyForms(this.editedId);
  @override
  _EditMyFormsState createState() => _EditMyFormsState();
}

class _EditMyFormsState extends State<EditMyForms> {
  var _screenOpening = false;

  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _DescriptionFocusNode = FocusNode();
  final _myControllerforImage = TextEditingController();
  final _myControllerTitle = TextEditingController();
  final _myControllerPrice = TextEditingController();
  final _myControllerDescription = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if(widget.editedId == null){

    }
    else{
     final items =  Provider.of<Products>(context,listen: false).getById(widget.editedId);
        _screenOpening = true;
       _myControllerDescription.text = items.description;
       _myControllerforImage.text = items.imageUrl;
       _myControllerPrice.text = items.price.toString();
       _myControllerTitle.text = items.title;
    }
    super.initState();
  }
  void _SaveForm(){
    final isValid  = _formKey.currentState?.validate();
    if(isValid == false){
      return;
    }
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
    if(_screenOpening == true){
      pproducts.updateAnItem(widget.editedId, title, description,ImageUrl, price);
      // pproducts.addItem(newProduct);
      Navigator.of(context).pop();
      return;
    }
    pproducts.addItem(newProduct);
    Navigator.of(context).pop();
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
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            TextFormField(
              validator: (value){
                if(value?.length == 0){
                  return 'Please Provide A Title';
                }
                else{
                  return null ;
                }
              },
              onFieldSubmitted: (data){
                FocusScope.of(context).requestFocus(_priceFocusNode);
               },
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              controller: _myControllerTitle,
            ),
            TextFormField(
              validator: (value){
                if(value == null ){
                  return 'Please Enter a Price';
                }
                if(value.length == 0){
                  return 'Please Enter a Price';
                }
                if(double.tryParse(value) == null ){
                  return 'Please Enter a Valid Number';
                }
                return null;
              },
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
              validator: (value) {
                if (value == null) {
                  return 'Please Enter the description';
                }
                if (value.length == 0) {
                  return 'Please Enter the description';
                }
                if (value.length < 10) {
                  return 'Please Enter a description greater than 10 letters';
                }
                return null;
              },
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
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)
                  ),
                  margin: EdgeInsets.only(top: 10.0, right: 8.0),
                ),
                Expanded(
                  child: TextFormField(
                    validator: (value){
                      if (value == null) {
                        return 'Please Enter the URL';
                      }
                      if (value.length == 0) {
                        return 'Please Enter the URL';
                      }
                      if(!value.startsWith('http') && !value.startsWith('https') && !value.endsWith('jpg') && !value.endsWith('png')){
                        return 'Please Enter a Valid Image';
                      }
                      return null;
                        },
                    controller: _myControllerforImage,
                    onChanged: (data){

                      setState(() {
                        print(data.toString());
                      });
                    },
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(

                      labelText: 'Enter the Image URL'
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
