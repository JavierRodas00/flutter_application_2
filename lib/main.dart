// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/pages/about_page.dart';
import 'package:flutter_application_2/pages/admin/productos/new_producto.dart';
import 'package:flutter_application_2/pages/admin/productos/productosIndex.dart';
import 'package:flutter_application_2/pages/login_page.dart';
import 'package:flutter_application_2/pages/new_user_page.dart';
import 'package:flutter_application_2/pages/user/cart_page.dart';
import 'package:flutter_application_2/pages/user/intro_screen.dart';
import 'package:flutter_application_2/providers/carrito_provider.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:flutter_application_2/providers/producto_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ChangeNotifierProvider(create: (_) => CarritoProvider()),
      ChangeNotifierProvider(create: (_) => ProductoProvider()),
      ChangeNotifierProvider(create: (_) => CategoriaProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductoProvider>().start();
    context.read<CategoriaProvider>().start();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/login': (context) => MyApp(),
        '/register': (context) => NewUser(),
        '/home': (context) => HomePage(),
        '/introScreen': (context) => IntroScreen(),
        '/about': (context) => AboutPage(),
        '/producto': (context) => ProductosPageAdmin(),
        '/carrito': (context) => CartPage(),
        '/agregar_producto': (context) => NewProducto(),
      },
    );
  }
}
