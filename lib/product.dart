import 'package:flutter/material.dart';
import 'package:sqflite_rev/db_helper.dart';

class Product {
  late int id;
  late String title;
  String? description;
  late double price;

  Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
  });

  Product.empty() {
    id = 0;
    title = '';
    description = '';
    price = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.colId : id,
      DbHelper.colTitle: title,
      DbHelper.colDescription: description,
      DbHelper.colPrice: price,
    };
  }
  Map<String, dynamic> toMapWithoudId() {
    return {
      // DbHelper.colId : id,
      DbHelper.colTitle: title,
      DbHelper.colDescription: description,
      DbHelper.colPrice: price,
    };
  }
}