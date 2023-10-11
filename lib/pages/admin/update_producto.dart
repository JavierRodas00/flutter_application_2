// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../components/my_buttons.dart';
import '../../components/my_textfield.dart';

class UpdateProducto extends StatefulWidget {
  const UpdateProducto({super.key});

  @override
  State<UpdateProducto> createState() => _UpdateProductoState();
}

class _UpdateProductoState extends State<UpdateProducto> {
  TextEditingController nombre_producto = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController id_categoria = TextEditingController();
  TextEditingController id_producto = TextEditingController();

  void wrongMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error al actualizar producto.'),
          );
        });
  }

  void successfulAdd() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Producto actualizado correctamente.'),
          );
        });
  }

  Future<void> update() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (nombre_producto.text != "" &&
        descripcion.text != "" &&
        precio.text != "" &&
        id_categoria.text != "") {
      String url = "http://localhost/apiSP2/admin/update_producto.php";
      try {
        var res = await http.post(Uri.parse(url), body: {
          "id_producto": id_producto.text,
          "nombre_producto": nombre_producto.text,
          "descripcion": descripcion.text,
          "precio": precio.text,
          "id_categoria": id_categoria.text,
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Producto actualizado correctamente");
          Navigator.pop(context);
          Navigator.pop(context);
          successfulAdd();
        } else {
          Navigator.pop(context);
          print("Error al actualizar producto");
          wrongMessage();
        }
      } catch (e) {
        print(e);
        Navigator.pop(context);
        wrongMessage();
      }
    } else {
      Navigator.pop(context);
      print("Llene todos los campos");
      wrongMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    // logo
                    Icon(
                      Icons.inventory_2,
                      size: 100,
                      color: Colors.grey[900],
                    ),

                    const SizedBox(height: 25),

                    MyTextField(
                      controller: id_producto,
                      hintText: 'Id Producto',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // email textfield
                    MyTextField(
                      controller: nombre_producto,
                      hintText: 'Producto',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextArea(
                      controller: descripcion,
                      hintText: 'Descripcion',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller: precio,
                      hintText: 'Precio',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller: id_categoria,
                      hintText: 'Categoria',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    MyRegisterButton(onTap: update),
                    // sign in button

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
