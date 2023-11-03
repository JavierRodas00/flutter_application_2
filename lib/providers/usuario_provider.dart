import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  int _admin = 1;
  String _nombre = "";
  String _apellido = "";
  String _idUsuario = "";

  int get admin => _admin;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get idUsuario => _idUsuario;

  void set(int n, String nombre, String apellido, String id) {
    _admin = n;
    _nombre = nombre;
    _apellido = apellido;
    _idUsuario = id;
    notifyListeners();
  }
}
