// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/components/my_buttons.dart';
import 'package:flutter_application_2/components/my_nav_bar.dart';
import 'package:flutter_application_2/model/Categoria_model.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:provider/provider.dart';

class CategoriasPageAdmin extends StatelessWidget {
  CategoriasPageAdmin({super.key});

  List<CategoriaModel> _categorias = [];
  @override
  Widget build(BuildContext context) {
    _categorias = context.watch<CategoriaProvider>().categorias;
    //print(_categorias.length);
    return Scaffold(
      appBar: appBar(context),
      drawer: const MyDrawer(),
      body: body(context),
    );
  }

  Column body(BuildContext context) {
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
                    Navigator.pushNamed(context, '/agregar_categoria');
                  },
                  title: "Agregar",
                ),
              ),
            )),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _categorias.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(5),
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 125,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(171, 255, 250, 195)),
                    child: Row(
                      children: [
                        Text(
                          _categorias[index].id_categoria,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          _categorias[index].descripcion_categoria,
                          style: const TextStyle(fontSize: 18),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            0, 233, 154, 36)),
                                    onPressed: () {
                                      eliminar(context,
                                          _categorias[index].id_categoria);
                                    },
                                    child: const Icon(Icons.delete)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  eliminar(BuildContext context, String id) {
    _showAlertDialog(context, id);
  }

  void _showAlertDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (BuildContext buildcontext) {
          return AlertDialog(
            title: const Text("Alerta"),
            content: const Text("Seguro que quiere eliminar esta categoria?"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    context.read<CategoriaProvider>().eliminar(id);
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
