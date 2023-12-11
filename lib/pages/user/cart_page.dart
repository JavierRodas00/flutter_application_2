// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/components/my_buttons.dart';
import 'package:flutter_application_2/components/my_nav_bar.dart';
import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/providers/carrito_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CarritoModel> _carrito = [];

  @override
  Widget build(BuildContext context) {
    _carrito = context.watch<CarritoProvider>().carrito;
    return Scaffold(
      appBar: appBar(context),
      drawer: const MyDrawer(),
      body: body(context),
    );
  }

  Widget body(context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: _carrito.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List ima = base64Decode(_carrito[index].producto.imagen);
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
                                  _carrito[index].producto.nombre_produto,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _carrito[index].cantidad.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _carrito[index].precio.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  add(context, _carrito[index]);
                                },
                                icon: const Icon(Icons.add)),
                            IconButton(
                                onPressed: () {
                                  delete(context, _carrito[index]);
                                },
                                icon: const Icon(Icons.remove)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          },
        )),
        Row(
          children: [
            Expanded(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                child: MyButton(
                  onTap: () {
                    checkOut(context);
                  },
                  title: "Pedir.",
                ),
              ),
            ))
          ],
        ),
      ],
    );
  }

  delete(BuildContext context, CarritoModel c) {
    context.read<CarritoProvider>().eliminar(c);
  }

  add(BuildContext context, CarritoModel c) {
    context.read<CarritoProvider>().add(c);
  }

  void checkOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext buildcontext) {
          return AlertDialog(
            title: const Text("Confirmar Pedido"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    context.read<CarritoProvider>().checkout(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Si")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
            ],
          );
        });
  }
}
