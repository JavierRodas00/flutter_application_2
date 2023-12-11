// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/model/Productos_model.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:flutter_application_2/providers/pedido_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CarritoProvider with ChangeNotifier {
  List<CarritoModel> _carrito = [];

  List<CarritoModel> get carrito => _carrito;

  void agregar(ProductoModel p) {
    var aux = 0;
    for (var c in _carrito) {
      if (c.producto == p) {
        c.precio = (c.precio / c.cantidad) * (c.cantidad + 1);
        c.cantidad = c.cantidad + 1;
        aux = 1;
        notifyListeners();
      }
    }
    if (aux == 0) {
      CarritoModel c = CarritoModel(p, 1, double.parse(p.precio));
      _carrito.add(c);
      notifyListeners();
    }
  }

  void eliminar(CarritoModel c) {
    for (CarritoModel a in _carrito) {
      if (a == c) {
        a.precio = (a.precio / a.cantidad) * (a.cantidad - 1);
        a.cantidad = a.cantidad - 1;
        if (a.cantidad == 0) {
          _carrito.remove(a);
        }
        notifyListeners();
      }
    }
  }

  void add(CarritoModel c) {
    for (CarritoModel a in _carrito) {
      a.precio = (a.precio / a.cantidad) * (a.cantidad + 1);
      a.cantidad = a.cantidad + 1;

      notifyListeners();
    }
  }

  void limpiar() {
    _carrito.clear();
    notifyListeners();
  }

  void checkout(BuildContext context) async {
    // Crear estructura json para enviar pedido
    var _cart = _carrito;
    List listaProductos = [];
    for (var i in _carrito) {
      Map<String, dynamic> producto = {
        "id_producto": i.producto.id_producto,
        "precio": i.producto.precio,
        "cantidad": i.cantidad
      };
      listaProductos.add(producto);
    }
    Map<String, dynamic> respuesta = {
      "id_usuario": context.read<UsuarioProvider>().idUsuario.toString(),
      "lista_productos": listaProductos
    };
    String jsonString = jsonEncode(respuesta);
    //Fin json

    String url = BDProvider().url + "detocho/api/user/carrito.php?action=pedir";

    try {
      var res = await http.post(Uri.parse(url), body: jsonString);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        String id = response["id"].toString();
        String user = response["id_usuario"].toString();
        String dir = response["id_direccion"].toString();
        context.read<PedidoProvider>().agregar(id, user, dir, _cart);
        limpiar();
      }
    } catch (e) {
      print("error");
    }
  }
}
