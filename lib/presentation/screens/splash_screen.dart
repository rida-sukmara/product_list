import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_list/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash-screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome Sir"),
      ),
    );
  }
}
