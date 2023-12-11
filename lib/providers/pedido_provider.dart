// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/model/Pedido_model.dart';
import 'package:flutter_application_2/model/Productos_model.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidoProvider with ChangeNotifier {
  List<PedidoModel> _pendientes = [];
  List<PedidoModel> _proceso = [];
  List<PedidoModel> _enviados = [];
  List<PedidoModel> _mispedidos = [];
  late PedidoModel _actual;

  String _usuario = "";
  String _direccion = "";
  String _fecha = "";
  String get fecha => _fecha;
  String get usuario => _usuario;
  String get direccion => _direccion;

  List<PedidoModel> get pendientes => _pendientes;
  List<PedidoModel> get mispedidos => _mispedidos;
  List<PedidoModel> get proceso => _proceso;
  List<PedidoModel> get enviados => _enviados;
  PedidoModel get actual => _actual;

  void start() async {
    _pendientes = [];
    _proceso = [];
    _enviados = [];

    String url =
        BDProvider().url + "detocho/api/admin/ordenes.php?action=ordenRecibida";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      double precioTotal = 0;
      var res = jsonDecode(response.body);
      List<CarritoModel> productosList = [];
      List pedidos = json.decode(response.body);
      for (Map<String, dynamic> pedido in pedidos) {
        productosList = [];
        for (Map<String, dynamic> productos in pedido["productos"]) {
          productosList.add(CarritoModel(
              ProductoModel(
                  productos["id_producto"],
                  productos["nombre_producto"],
                  productos["descripcion"],
                  productos["precio"],
                  productos["categoria"],
                  productos["imagen"],
                  productos["categoria"]),
              int.parse(productos["cantidad_producto"]),
              double.parse(productos["precio_producto"])));
        }
        //print(pedido);
        if (pedido["estado"] == "0") {
          _pendientes.add(PedidoModel(pedido["id_pedido"], pedido["id_usuario"],
              pedido["id_direccion_usuario"], pedido["estado"], productosList));
        } else if (pedido["estado"] == "1") {
          _proceso.add(PedidoModel(pedido["id_pedido"], pedido["id_usuario"],
              pedido["id_direccion_usuario"], pedido["estado"], productosList));
        } else if (pedido["estado"] == "2") {
          _enviados.add(PedidoModel(pedido["id_pedido"], pedido["id_usuario"],
              pedido["id_direccion_usuario"], pedido["estado"], productosList));
        }
      }
    }
    notifyListeners();
  }

  void start2(BuildContext context) async {
    _mispedidos = [];
    String url =
        "${BDProvider().url}detocho/api/user/ordenes.php?action=getAllOrders";
    final response = await http.post(Uri.parse(url),
        body: {"id_usuario": context.read<UsuarioProvider>().idUsuario});
    if (response.statusCode == 200) {
      try {
        List<CarritoModel> productosList = [];
        List pedidos = json.decode(response.body);
        for (Map<String, dynamic> pedido in pedidos) {
          productosList = [];
          for (Map<String, dynamic> productos in pedido["productos"]) {
            productosList.add(CarritoModel(
                ProductoModel(
                    productos["id_producto"],
                    productos["nombre_producto"],
                    productos["descripcion"],
                    productos["precio"],
                    productos["categoria"],
                    productos["imagen"],
                    productos["categoria"]),
                int.parse(productos["cantidad_producto"]),
                double.parse(productos["precio_producto"])));
          }
          //print(pedido);
          _mispedidos.add(PedidoModel(pedido["id_pedido"], pedido["id_usuario"],
              pedido["id_direccion_usuario"], pedido["estado"], productosList));
        }
      } catch (e) {}
    }
    notifyListeners();
  }

  void cambiarEstado(PedidoModel pedido) async {
    String id_pedido = pedido.id_pedido;
    String estado_nuevo = (int.parse(pedido.estado) + 1).toString();

    /* print(id_pedido);
    print(estado_nuevo); */

    String url = BDProvider().url +
        "detocho/api/admin/ordenes.php?action=modificarEstado";

    try {
      var res = await http.post(Uri.parse(url),
          body: {"id_pedido": id_pedido, "estado": estado_nuevo});
      if (res.statusCode == 200) {
        // print("Estado modificado");
        if (estado_nuevo == "1") {
          _pendientes.remove(pedido);
          pedido.estado = "1";
          _proceso.add(pedido);
        } else if (estado_nuevo == "2") {
          _proceso.remove(pedido);
          pedido.estado = "2";
          _enviados.add(pedido);
        } else {
          _enviados.remove(pedido);
        }
        notifyListeners();
      }
    } catch (e) {}
  }

  void agregar(String id_pedido, String id_usuario, String id_direccion_usuario,
      List<CarritoModel> productos) {
    PedidoModel pedido = PedidoModel(
        id_pedido, id_usuario, id_direccion_usuario, "0", productos);
    _pendientes.add(pedido);
    notifyListeners();
  }

  void setActual(PedidoModel pedido) {
    _actual = pedido;
    infoPedido(pedido.id_pedido);
    notifyListeners();
  }

  void infoPedido(String _idPedido) async {
    String url = BDProvider().url +
        "detocho/api/admin/ordenes.php?action=informacionPedido";

    try {
      var response =
          await http.post(Uri.parse(url), body: {"id_pedido": _idPedido});
      if (response.statusCode == 200) {
        // print("Estado modificado");
        var res = jsonDecode(response.body);
        _usuario = res["usuario"];
        _direccion = res["direccion"];
        _fecha = res["fecha"];
        notifyListeners();
      }
    } catch (e) {}
  }
}
