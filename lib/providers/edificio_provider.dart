import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Edificio_model.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:http/http.dart' as http;

class EdificioProvider with ChangeNotifier {
  List<EdificioModel> _edificios = [];
  List<EdificioModel> get edificios => _edificios;

  void start() async {
    _edificios = [];

    String url = BDProvider().url + "detocho/api/admin/ver_edificio.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var edi in res) {
        _edificios.add(EdificioModel(
            edi["id_edificio"],
            edi["nombre_edificio"],
            edi["avenida_edificio"],
            edi["calle_edificio"],
            edi["numero_edificio"],
            edi["zona"]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }
    notifyListeners();
  }
}
