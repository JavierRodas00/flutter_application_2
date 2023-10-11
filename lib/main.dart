// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/main_page.dart';
import 'package:flutter_application_2/pages/about_page.dart';
import 'package:flutter_application_2/pages/admin/new_producto.dart';
import 'package:flutter_application_2/pages/login_page.dart';
import 'package:flutter_application_2/pages/prueba.dart';
import 'package:flutter_application_2/pages/user/intro_screen.dart';

/*

S T A R T

This is the starting point for all apps. 
Everything starts at the main function

*/
void main() async {
  // lets run our app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // this is bringing us to the LoginPage first
      home: LoginPage(),
      routes: {
        '/home': (context) => MainPage(),
        '/introScreen': (context) => IntroScreen(),
        '/about': (context) => AboutPage(),
        '/prueba': (context) => Prueba(),
        '/agregar_producto': (context) => NewProducto(),
      },
    );
  }
}