import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/model/Productos_model.dart';

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
}
