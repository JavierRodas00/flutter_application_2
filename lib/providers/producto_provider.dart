// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Productos_model.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductoProvider with ChangeNotifier {
  List<ProductoModel> _productos = [];
  List<ProductoModel> get productos => _productos;

  List<ProductoModel> _favoritos = [];
  List<ProductoModel> get favoritos => _favoritos;

  void start(BuildContext context) async {
    _productos = [];

    String url =
        BDProvider().url + "detocho/api/user/producto.php?action=getAll";
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

  void insert(nombreProducto, descripcionProducto, precioProducto, idCategoria,
      categoria, image64, BuildContext context) async {
    String url = BDProvider().url + "detocho/api/admin/agregar_producto.php";
    try {
      var res = await http.post(Uri.parse(url), body: {
        "nombre_producto": nombreProducto,
        "descripcion": descripcionProducto,
        "precio": precioProducto,
        "id_categoria": idCategoria,
        "imagen_producto": image64
      });
      var response = jsonDecode(res.body);
      print(response);
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
      print(e);
    }
    notifyListeners();
  }

  void eliminar(String idProducto) async {
    for (ProductoModel p in _productos) {
      if (p.id_producto == idProducto) {
        _productos.remove(p);

        String url = BDProvider().url +
            "detocho/api/admin/productos/eliminar_producto.php";
        try {
          final response = await http.post(Uri.parse(url), body: {
            "id_producto": idProducto,
          });
          if (response.statusCode == 200) {
            print("Producto: $idProducto desactivado");
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
