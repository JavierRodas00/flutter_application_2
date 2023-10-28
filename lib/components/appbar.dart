import 'package:flutter/material.dart';

//AppBar
AppBar appBar() {
  const primaryColor = Color.fromARGB(255, 238, 179, 1);
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
        onPressed: () {},
      )
    ],
  );
}
