import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_rev/product.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile({super.key, required this.product, required this.deleteItem});

  Product product;
  Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(product.description ?? ''),
      trailing: IconButton(
        onPressed: () => deleteItem(product.id), 
        icon: const Icon(Icons.delete),
      ),
    );
  }
}