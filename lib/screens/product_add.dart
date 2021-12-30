import 'package:flutter/material.dart';
import 'package:flutter_application_5/data/dbHelper.dart';
import 'package:flutter_application_5/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key key}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();

  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Name"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Description"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Unit Price "),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return ElevatedButton(
        onPressed: () {
          addProduct();
        },
        child: Text("Add"));
  }

  void addProduct() async {
    var result = await dbHelper.insert(Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, true);
  }
}
