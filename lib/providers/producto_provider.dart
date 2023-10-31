// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Productos_model.dart';
import 'package:http/http.dart' as http;

class ProductoProvider with ChangeNotifier {
  List<Producto> _productos = [];

  List<Producto> get productos => _productos;

  void start() async {
    String url = "http://localhost/apiSP2/user/get_producto.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var prod in res) {
        _productos.add(Producto(
            prod["id_producto"],
            prod["nombre_producto"],
            prod["descripcion"],
            prod["precio"],
            prod["descripcion_categoria"],
            prod["imagen_producto"],
            prod["id_categoria"]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }
    notifyListeners();
  }

  void insert(context, nombreProducto, descripcionProducto, precioProducto,
      idCategoria, image64) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    String url = "http://localhost/apiSP2/admin/agregar_producto.php";
    try {
      var res = await http.post(Uri.parse(url), body: {
        "nombre_producto": nombreProducto,
        "descripcion": descripcionProducto,
        "precio": precioProducto,
        "id_categoria": idCategoria,
        "imagen_producto": image64
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        _productos.add(Producto(
            response["id"].toString(),
            nombreProducto,
            descripcionProducto,
            precioProducto,
            idCategoria,
            image64,
            idCategoria));
        print("Producto ${response["id"].toString()} registrado");
        Navigator.pop(context);
      } else {
        print("ERROR: nuevo producto");
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
