import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uidesign03/model/cart_model.dart';
import 'package:uidesign03/page/splash_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
