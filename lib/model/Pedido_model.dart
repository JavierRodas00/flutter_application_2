// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application_2/model/Carrito_model.dart';

class PedidoModel {
  String id_pedido;
  String usuario;
  String direccion_usuario;
  String estado;
  List<CarritoModel> productos;
  //String precio;

  PedidoModel(this.id_pedido, this.usuario, this.direccion_usuario, this.estado,
      this.productos);
}
