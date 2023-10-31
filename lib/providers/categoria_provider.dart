import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Categoria.dart';
import 'package:http/http.dart' as http;

class CategoriaProvider with ChangeNotifier {
  List<Categoria> _categorias = [];
  List<Categoria> get categorias => _categorias;

  void start() async {
    _categorias = [];

    String url = "http://localhost/apiSP2/admin/ver_categoria.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var prod in res) {
        _categorias.add(
            Categoria(prod["id_categoria"], prod["descripcion_categoria"]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }
    notifyListeners();
  }
}
