import 'package:flutter/material.dart';
import 'package:flutter_application_5/data/dbHelper.dart';
import 'package:flutter_application_5/models/product.dart';
import 'package:flutter_application_5/screens/product_add.dart';
import 'package:flutter_application_5/screens/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;
  bool pageLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: pageLoading
          ? Center(child: CircularProgressIndicator())
          : buildListViewProducts(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        tooltip: "Yeni ürün ekle.",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView buildListViewProducts() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.amber,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.products[index].name),
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
            subtitle: Text(this.products[index].description),
            onTap: () {
              goToDetail(this.products[index]);
            },
          ),
        );
      },
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  Future getProducts() async {
    print("basladi");

    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
        pageLoading = false;
      });
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductDetails()));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
