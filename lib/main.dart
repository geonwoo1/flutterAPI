import 'package:flutter/material.dart';
import 'package:food/view/mypage.dart';
import 'package:food/view/product.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:MyPage(),
    );
  }
}
