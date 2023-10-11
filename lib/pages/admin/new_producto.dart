// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../components/my_buttons.dart';
import '../../components/my_textfield.dart';

class NewProducto extends StatefulWidget {
  const NewProducto({super.key});

  @override
  State<NewProducto> createState() => _NewProductoState();
}

class _NewProductoState extends State<NewProducto> {
  TextEditingController nombre_producto = TextEditingController();
  TextEditingController descripcion_producto = TextEditingController();
  TextEditingController precio_producto = TextEditingController();
  TextEditingController id_categoria = TextEditingController();
  TextEditingController imagen_producto = TextEditingController();

  //String _ruta = '';
  //String _image64 = '';

  void wrongMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error al insertar producto.'),
          );
        });
  }

  void successfulAdd() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Producto Insertado correctamente.'),
          );
        });
  }

  Future<void> register() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (nombre_producto.text != "" &&
        descripcion_producto.text != "" &&
        precio_producto.text != "" &&
        id_categoria.text != "") {
      String url = "http://localhost/apiSP2/admin/agregar_producto.php";
      try {
        var res = await http.post(Uri.parse(url), body: {
          "nombre_producto": nombre_producto.text,
          "descripcion": descripcion_producto.text,
          "precio": precio_producto.text,
          "id_categoria": id_categoria.text,
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Usuario registrado correctamente");
          Navigator.pop(context);
          Navigator.pop(context);
          successfulAdd();
        } else {
          Navigator.pop(context);
          print("Error registrar usuario");
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
                    //const SizedBox(height: 50),

                    // logo
                    /*Icon(
                      Icons.inventory_2,
                      size: 100,
                      color: Colors.grey[900],
                    ),*/

                    const SizedBox(height: 25),

                    /*MyUploadImageButton(
                      imagePath: _ruta,
                      controller: imagen_producto,
                      onTap: () {
                        print('hola');
                      },
                    ),*/

                    const SizedBox(height: 25),
                    // email textfield
                    MyTextField(
                      controller: nombre_producto,
                      hintText: 'Producto',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextArea(
                      controller: descripcion_producto,
                      hintText: 'Descripcion',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller: precio_producto,
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

                    MyRegisterButton(onTap: register),
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
