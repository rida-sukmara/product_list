import 'package:flutter/material.dart';
import 'package:product_list/core/router.dart';
import 'package:product_list/presentation/screens/home_screen.dart';
import 'package:product_list/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      routes: routes,
      home: HomeScreen(),
    );
  }
}
