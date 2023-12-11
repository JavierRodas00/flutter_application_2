import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

//AppBar
AppBar appBar(BuildContext context) {
  const primaryColor = Color.fromARGB(255, 238, 179, 1);
  int admin = context.watch<UsuarioProvider>().admin;
  if (admin == 1) {
    return AppBar(
      elevation: 1,
      backgroundColor: primaryColor,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'deTocho',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  } else {
    return AppBar(
      elevation: 1,
      backgroundColor: primaryColor,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'deTocho',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Colors.white, // Icono de la carreta
          onPressed: () {
            Navigator.pushNamed(context, '/carrito');
          },
        )
      ],
    );
  }
}
