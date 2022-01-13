
import 'package:flutter/material.dart';
import 'package:product_list/presentation/screens/home_screen.dart';
import 'package:product_list/presentation/screens/product_detail_screen.dart';
import 'package:product_list/presentation/screens/splash_screen.dart';

Map<String,WidgetBuilder> routes = {
  HomeScreen.route: (_) => HomeScreen(),
  SplashScreen.route: (_) => const SplashScreen(),
  ProductDetailScreen.route: (_) => ProductDetailScreen()
};
