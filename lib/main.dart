import 'package:flutter/material.dart';
import 'package:sqflite_rev/product_manage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductManageScreen(),
    );
  }
}