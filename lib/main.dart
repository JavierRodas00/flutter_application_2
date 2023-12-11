// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/admin/pedidos/detalle_pedido.dart';
import 'package:flutter_application_2/pages/new_pass_page.dart';
import 'package:flutter_application_2/pages/recovery_page.dart';
import 'package:flutter_application_2/pages/user/home_page.dart';
import 'package:flutter_application_2/pages/about_page.dart';
import 'package:flutter_application_2/pages/admin/categorias/categoriasIndex.dart';
import 'package:flutter_application_2/pages/admin/categorias/new_categoria.dart';
import 'package:flutter_application_2/pages/admin/home_page_admin.dart';
import 'package:flutter_application_2/pages/admin/productos/new_producto.dart';
import 'package:flutter_application_2/pages/admin/productos/productosIndex.dart';
import 'package:flutter_application_2/pages/login_page.dart';
import 'package:flutter_application_2/pages/new_user_page.dart';
import 'package:flutter_application_2/pages/user/cart_page.dart';
import 'package:flutter_application_2/pages/user/intro_screen.dart';
import 'package:flutter_application_2/providers/carrito_provider.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:flutter_application_2/providers/edificio_provider.dart';
import 'package:flutter_application_2/providers/pedido_provider.dart';
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
      ChangeNotifierProvider(create: (_) => EdificioProvider()),
      ChangeNotifierProvider(create: (_) => PedidoProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoriaProvider>().start();
    context.read<EdificioProvider>().start();
    //context.read<PedidoProvider>().start();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        // ********** TODOS **********
        '/login': (context) => MyApp(),
        '/register': (context) => NewUser(),
        '/recovery': (context) => RecuperarPass(),
        '/newPass': (context) => CambiarPass(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/carrito': (context) => CartPage(),

        // ********** USER **********
        '/introScreen': (context) => IntroScreen(),

        // ********** ADMIN **********
        // Productos
        '/ahome': (context) => AdminHomePage(),
        '/producto': (context) => ProductosPageAdmin(),
        '/agregar_producto': (context) => NewProducto(),
        '/detalle_pedido': (context) => DetallePedido(),

        // ********** REPARTIDOR **********

        // Categoria
        '/categoria': (context) => CategoriasPageAdmin(),
        '/agregar_categoria': (context) => NewCategoria()
      },
    );
  }
}
