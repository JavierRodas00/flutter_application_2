// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Categoria.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:flutter_application_2/providers/producto_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/my_buttons.dart';
import '../../../components/my_textfield.dart';

class NewProducto extends StatefulWidget {
  const NewProducto({super.key});

  @override
  State<NewProducto> createState() => _NewProductoState();
}

class _NewProductoState extends State<NewProducto> {
  List<Categoria> _categorias = [];
  TextEditingController nombre_producto = TextEditingController();
  TextEditingController descripcion_producto = TextEditingController();
  TextEditingController precio_producto = TextEditingController();
  TextEditingController id_categoria = TextEditingController();
  TextEditingController imagen_producto = TextEditingController();

  String _image64 = '';
  Uint8List selectedImage = Uint8List(0);
  bool aux = false;

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

  void register() {
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
      context.read<ProductoProvider>().insert(
          context,
          nombre_producto.text,
          descripcion_producto.text,
          precio_producto.text,
          id_categoria.text,
          _image64);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      print("Llene todos los campos");
      wrongMessage();
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    FilePickerResult? result;
    _categorias = context.watch<CategoriaProvider>().categorias;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),

                    MyUploadImageButton(
                      onTap: () async {
                        result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'jpeg'],
                        );
                        if (result == null) {
                          print("No file selected");
                        } else {
                          setState(() {
                            selectedImage = result!.files[0].bytes!;
                            aux = true;
                          });

                          _image64 = base64Encode(selectedImage);
                        }
                      },
                      controller: imagen_producto,
                      imagePath: selectedImage,
                      aux: aux,
                    ),

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
                    seleccionarCategoria(context),

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

  Widget seleccionarCategoria(context) {
    //print(_categorias.first.id_categoria);
    String dropdownValue = "0";
    return Center(
      child: DropdownButton<String>(
        value: dropdownValue,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: [
          DropdownMenuItem(value: "0", child: Text("One")),
          DropdownMenuItem(value: 'Two', child: Text("Two")),
          DropdownMenuItem(value: 'Three', child: Text("Three"))
        ],
      ),
    );
  }
}
