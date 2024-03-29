import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_rev/db_helper.dart';
import 'package:sqflite_rev/product.dart';
import 'package:sqflite_rev/product_addedit.dart';
import 'package:sqflite_rev/product_list_tile.dart';

class ProductManageScreen extends StatefulWidget {
  const ProductManageScreen({super.key});

  @override
  State<ProductManageScreen> createState() => _ProductManageScreenState();
}

class _ProductManageScreenState extends State<ProductManageScreen> {
  
  void deleteItem(int id) {
    DbHelper.deleteRaw(id);
    setState(() {});
  }

  void insertItem(Product P) {
    DbHelper.insertProduct(P);
    setState(() {
      
    });
  }

  void updateItem(Product p) {
    DbHelper.updateProduct(p);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => ProductAddEditScreen(operation: insertItem,),
                ),
              );
            }, 
            icon: Icon(Icons.add),
          ),
        ],
      ),
      // drawer: AppDrawer(),
      body: FutureBuilder(
        future: DbHelper.fetchQuery(), 
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('loading data');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print('loaded data');
          var products = snapshot.data;
          print(products);
          if (products == null) {
            return const Center(
              child: Text('No Product Entries'),
            );
          }
          return ListView.builder(
            itemBuilder: (_, index) {
              Product product = Product(
                id: products[index][DbHelper.colId],
                title: products[index][DbHelper.colTitle], 
                price: double.parse(products[index][DbHelper.colPrice].toString()),
                description: products[index][DbHelper.colDescription],
              );
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => ProductAddEditScreen(operation: updateItem, passedProduct: product,),
                    ),
                  );
                },
                child: ProductListTile(
                  product: product,
                  deleteItem: deleteItem,
                ),
              );
            },
            itemCount: products.length,
          );
        },
      ),
    );
  }
}