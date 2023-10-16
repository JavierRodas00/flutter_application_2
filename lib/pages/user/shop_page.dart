// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../model/Productos.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

List<Producto> productos = [];

class _ShopPageState extends State<ShopPage> {
  Future<List<Producto>> _getProducto() async {
    List<Producto> aux = [];
    String url = "http://localhost/apiSP2/user/get_producto.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var prod in res) {
        //print(prod["id_producto"]);
        aux.add(Producto(
            prod["id_producto"],
            prod["nombre_producto"],
            prod["descripcion"],
            prod["precio"],
            prod["descripcion_categoria"],
            prod["imagen_producto"]));
      }
    } else {
      throw Exception("Fallo la conexion");
    }
    return aux;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: const [],
        future: _getProducto(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var productos = listProductos(snapshot.data!);
          return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    Uint8List ima = base64Decode(productos[index].imagen);
                    return Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: 125,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(171, 201, 165, 46)),
                            child: Column(
                              children: [
                                Image.memory(
                                  ima,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                                Text(productos[index].descripcion),
                                ElevatedButton(
                                    onPressed: () => (),
                                    child: Text(productos[index].precio))
                              ],
                            ),
                          ),
                        ));
                  }));
        });
    /* FutureBuilder(
              future: _getProducto(),
              builder: (context, snapshot) {

                return Container();
              },
            ) */ /* ==
            null
        ? Text("hola")
        : Text("adios") */
  }
}

List<Producto> listProductos(data) {
  for (var producto in data) {
    productos.add(producto);
  }
  return productos;
}

/* Widget mostrarProductos(context){
  FutureBuilder(
                future: _getProducto(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var productos = listProductos(snapshot.data!);
                  return ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      return Text(productos[index].id_producto);
                    },
                  );
                })
} */
