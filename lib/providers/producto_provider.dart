// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Productos_model.dart';
import 'package:http/http.dart' as http;

class ProductoProvider with ChangeNotifier {
  List<ProductoModel> _productos = [];
  List<ProductoModel> get productos => _productos;

  List<ProductoModel> _favoritos = [];
  List<ProductoModel> get favoritos => _favoritos;

  void start() async {
    _productos = [];

    String url = "http://localhost/apiSP2/user/productos/get_producto.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var prod in res) {
        _productos.add(ProductoModel(
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

  /* void start2() async {
    _favoritos = [];
    String url =
        "http://localhost/apiSP2/user/productos/get_producto_favoritos.php";
    final response1 =
        await http.post(Uri.parse(url), body: {'id_usuario': '2'});

    if (response1.statusCode == 200) {
      var res = jsonDecode(response1.body);
      for (var prod in res) {
        _favoritos.add(ProductoModel(
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
  } */

  void insert(nombreProducto, descripcionProducto, precioProducto, idCategoria,
      categoria, image64) async {
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
        _productos.add(ProductoModel(
            response["id"].toString(),
            nombreProducto,
            descripcionProducto,
            precioProducto,
            categoria,
            image64,
            idCategoria));
        //print("Producto ${response["id"].toString()} registrado");
      } else {
        //print("ERROR: nuevo producto");
      }
    } catch (e) {
      //print(e);
    }
    notifyListeners();
  }

  void modificar(idProducto, nombreProducto, descripcionProducto,
      precioProducto, idCategoria, image64) async {
    String url = "http://localhost/apiSP2/admin/productos/update_producto.php";
    try {
      var res = await http.post(Uri.parse(url), body: {
        "id_producto": idProducto,
        "nombre_producto": nombreProducto,
        "descripcion": descripcionProducto,
        "precio": precioProducto,
        "imagen_producto": image64,
        "id_categoria": idCategoria
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        //agregar que pasa cuando se modifica
        /* _productos.add(Producto(
            response["id"].toString(),
            nombreProducto,
            descripcionProducto,
            precioProducto,
            idCategoria,
            image64,
            idCategoria));
        print("Producto ${response["id"].toString()} registrado"); */
      } else {
        //print("ERROR: nuevo producto");
      }
    } catch (e) {
      //print(e);
    }
    notifyListeners();
  }

  void eliminar(String idProducto) async {
    for (ProductoModel p in _productos) {
      if (p.id_producto == idProducto) {
        _productos.remove(p);

        String url =
            "http://localhost/apiSP2/admin/productos/eliminar_producto.php";
        try {
          final response = await http.post(Uri.parse(url), body: {
            "id_producto": idProducto,
          });
          if (response.statusCode == 200) {
            print("Producto: $idProducto eliminado");
          } else {
            throw Exception("Fallo la conexion");
          }
          notifyListeners();
        } catch (e) {}
      }
    }
  }

  void agregarFavorito() {}
}
