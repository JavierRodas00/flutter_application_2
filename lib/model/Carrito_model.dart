// ignore_for_file: file_names

import 'package:flutter_application_2/model/Productos_model.dart';

class CarritoModel {
  ProductoModel producto;
  int cantidad;
  double precio;

  CarritoModel(this.producto, this.cantidad, this.precio);
}
