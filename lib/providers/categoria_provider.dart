import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Categoria_model.dart';
import 'package:http/http.dart' as http;

class CategoriaProvider with ChangeNotifier {
  List<CategoriaModel> _categorias = [];
  List<CategoriaModel> get categorias => _categorias;
  int _selectedCategoria = 0;
  int get selectedCategoria => _selectedCategoria;

  void start() async {
    //CategoriaModel("0", "Todo")
    _categorias = [];

    String url = "http://localhost/apiSP2/admin/ver_categoria.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var prod in res) {
        _categorias.add(CategoriaModel(
            prod["id_categoria"], prod["descripcion_categoria"]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }
    notifyListeners();
  }

  void insert(BuildContext context, descripcionCategoria) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    String url = "http://localhost/apiSP2/admin/agregar_categoria.php";
    try {
      var res = await http.post(Uri.parse(url), body: {
        "descripcion_categoria": descripcionCategoria,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        _categorias.add(
            CategoriaModel(response["id"].toString(), descripcionCategoria));
        //print("Categoria ${response["id"].toString()} registrada");
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        //print("ERROR: nueva categoria");
      }
    } catch (e) {
      //print(e);
    }
    notifyListeners();
  }

  void seleccionar(int n) {
    if (_selectedCategoria == n) {
      //print("Actual $_selectedCategoria cambio a $n");
      _selectedCategoria = 0;
    } else {
      _selectedCategoria = n;
    }
    notifyListeners();
  }

  void eliminar(String id) async {
    for (CategoriaModel i in _categorias) {
      if (i.id_categoria == id) {
        _categorias.remove(i);

        String url = "http://localhost/apiSP2/admin/eliminar_categoria.php";
        try {
          final response = await http.post(Uri.parse(url), body: {
            "id_categoria": id,
          });
          if (response.statusCode == 200) {
            print("Categoria: $id eliminada");
          } else {
            throw Exception("Fallo la conexion");
          }
          notifyListeners();
        } catch (e) {}
      }
    }
  }
}
