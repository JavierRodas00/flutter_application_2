// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/components/my_buttons.dart';
import 'package:flutter_application_2/components/my_nav_bar.dart';
import 'package:flutter_application_2/model/Productos_model.dart';
import 'package:flutter_application_2/providers/producto_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductosPageAdmin extends StatelessWidget {
  ProductosPageAdmin({super.key});

  List<ProductoModel> _productos = [];
  @override
  Widget build(BuildContext context) {
    _productos = context.watch<ProductoProvider>().productos;
    return Scaffold(
      appBar: appBar(context),
      drawer: const MyDrawer(),
      body: body(context),
    );
  }

  Widget body(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: MyButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/agregar_producto');
                  },
                  title: "Agregar",
                ),
              ),
            ))
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemCount: _productos.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List ima = base64Decode(_productos[index].imagen);
            return Container(
                width: 100,
                height: 250,
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
                    child: Row(
                      children: [
                        Image.memory(
                          ima,
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  _productos[index].nombre_produto,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _productos[index].descripcion,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _productos[index].precio,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _productos[index].categoria,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      modificar(_productos[index].id_producto);
                                    },
                                    child: const Icon(Icons.edit)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      delete(context,
                                          _productos[index].id_producto);
                                    },
                                    child: const Icon(Icons.delete)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
          },
        )),
      ],
    );
  }

  delete(BuildContext context, String id) {
    // print("Eliminar producto id: $id");
    context.read<ProductoProvider>().eliminar(id);
  }

  modificar(id) {
    print("Modificar producto id: $id");
  }
}
