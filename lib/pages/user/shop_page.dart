// ignore_for_file: avoid_print, unnecessary_null_comparison, prefer_final_fields

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/carrito_provider.dart';
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
    _productos = context.watch<ProductoProvider>().productos;
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: _productos.length,
        itemBuilder: (context, index) {
          if (_selectedCategoria == 0) {
            return allProductos(index);
          } else {
            return showProductos(index);
          }
        });
  }

  Container allProductos(int index) {
    Uint8List ima = base64Decode(_productos[index].imagen);
    return Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(5),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(15),
            width: 125,
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
                  fit: BoxFit.fill,
                )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _productos[index].descripcion,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      agregar(context, _productos[index]);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(200, 245, 209, 92)),
                    child: Text(
                      "Q${_productos[index].precio}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ));
  }

  Container showProductos(int index) {
    if (_productos[index].id_categoria == _selectedCategoria.toString()) {
      Uint8List ima = base64Decode(_productos[index].imagen);
      return Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(5),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 125,
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
                    fit: BoxFit.fill,
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _productos[index].descripcion,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        agregar(context, _productos[index]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(200, 245, 209, 92)),
                      child: Text(
                        "Q${_productos[index].precio}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ));
    } else {
      return Container();
    }
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
