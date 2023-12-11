// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_final_fields

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/carrito_provider.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:flutter_application_2/providers/producto_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../model/Productos_model.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<ProductoModel> _productos = [];
  int _selectedCategoria = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedCategoria = context.watch<CategoriaProvider>().selectedCategoria;
    if (_selectedCategoria == 0) {
      _productos = context.watch<ProductoProvider>().productos;
    } else {
      _productos = context.watch<ProductoProvider>().productos;
      List<ProductoModel> _aux = [];
      for (ProductoModel p in _productos) {
        if (p.id_categoria == _selectedCategoria.toString()) {
          _aux.add(p);
        }
        _productos = _aux;
      }
    }
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: _productos.length >= 20 ? 20 : _productos.length,
        //=>5?5:features.length
        itemBuilder: (context, index) {
          return mostrarProductos(index, _productos);
        });
  }

  Widget mostrarProductos(int index, List<ProductoModel> p) {
    Uint8List ima = base64Decode(p[index].imagen);
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(15),
        width: 125,
        height: 500,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(171, 255, 250, 195)),
        child: Column(
          children: [
            Expanded(
                child: Image.memory(
              ima,
              width: 100,
              height: 100,
              fit: BoxFit.fitHeight,
            )),
            const SizedBox(
              height: 20,
            ),
            Text(
              p[index].nombre_produto,
              style: const TextStyle(fontSize: 18),
            ),
            /* 
            const SizedBox(
              height: 20,
            ), */
            ElevatedButton(
                onPressed: () {
                  agregar(context, p[index]);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(200, 245, 209, 92)),
                child: Text(
                  "Q${p[index].precio}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  List<ProductoModel> listProductos(data) {
    for (var producto in data) {
      _productos.add(producto);
    }
    return _productos;
  }

  agregar(BuildContext context, producto) {
    context.read<CarritoProvider>().agregar(producto);
  }
}
