import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  int _admin = 1;
  String _nombre = "";
  String _apellido = "";

  int get admin => _admin;
  String get nombre => _nombre;
  String get apellido => _apellido;

  void set(int n, String nombre, String apellido) {
    _admin = n;
    _nombre = nombre;
    _apellido = apellido;
    notifyListeners();
  }
}
