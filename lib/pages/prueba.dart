import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const Prueba());

class Prueba extends StatefulWidget {
  const Prueba({super.key});

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  late Future<List<Categoria>> categorias;

  Future<List<Categoria>> _getCategoria() async {
    List<Categoria> aux = [];
    String url = "http://localhost/apiSP2/admin/ver_categoria.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var cat in res) {
        //print(cat["id_categoria"]);
        //print(cat["descripcion_categoria"]);
        aux.add(Categoria(cat["id_categoria"], cat["descripcion_categoria"]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }
    return aux;
  }

  @override
  void initState() {
    super.initState();
    categorias = _getCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: FutureBuilder(
          future: categorias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _listCategorias(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> _listCategorias(data) {
  List<Widget> categorias = [];

  for (var categoria in data) {
    categorias.add(Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(categoria.descripcion),
        ),
      ],
    )));
  }

  return categorias;
}

class Categoria {
  String id;
  String descripcion;

  Categoria(this.id, this.descripcion);
}
