// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'dart:typed_data';
import 'dart:io' show File, Platform;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/Categoria_model.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:flutter_application_2/providers/producto_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../components/my_buttons.dart';
import '../../../components/my_textfield.dart';

class NewProducto extends StatefulWidget {
  const NewProducto({super.key});

  @override
  State<NewProducto> createState() => _NewProductoState();
}

class _NewProductoState extends State<NewProducto> {
  TextEditingController nombre_producto = TextEditingController();
  TextEditingController descripcion_producto = TextEditingController();
  TextEditingController precio_producto = TextEditingController();
  TextEditingController imagen_producto = TextEditingController();
  TextEditingController categoria_producto = TextEditingController();

  String _image64 = '';
  Uint8List selectedImage = Uint8List(0);
  bool aux = false;

  List<CategoriaModel> categorias = [];
  late CategoriaModel dropdownValue;

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

  register() {
    //print(aux1.descripcion_categoria);
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
        double.parse(precio_producto.text) > 0 &&
        categoria_producto.text != "") {
      //print(aux1.id_categoria);
      int idcat = 0;
      String descat = "";
      for (var i in categorias) {
        if (i.descripcion_categoria == categoria_producto.text) {
          idcat = int.parse(i.id_categoria);
          descat = i.descripcion_categoria;
        }
      }
      //print(_image64);
      context.read<ProductoProvider>().insert(
          nombre_producto.text,
          descripcion_producto.text,
          precio_producto.text,
          idcat.toString(),
          descat,
          _image64,
          context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      //print("Llene todos los campos");
      wrongMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    FilePickerResult? result;
    categorias = context.watch<CategoriaProvider>().categorias;
    dropdownValue = categorias.first;
    try {
      if (Platform.isAndroid) {
        return android(context, result);
      } else
        return windows(context, result);
    } catch (e) {
      return windows(context, result);
    }
  }

  MaterialApp android(BuildContext context, FilePickerResult? result) {
    File? imagen_upload;
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

                    /* MyUploadImageButton(
                      onTap: () async {
                        result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'jpeg'],
                        );
                        if (result == null) {
                          //print("No file selected");
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
                    ), */

                    MyUploadImageButton(
                      onTap: () async {
                        ImagePicker _picker = ImagePicker();
                        final XFile? photo =
                            await _picker.pickImage(source: ImageSource.camera);
                        if (photo == null) {
                          //print("No file selected");
                        } else if (photo != null) {
                          setState(() {
                            imagen_upload = File(photo!.path);
                            selectedImage = imagen_upload!.readAsBytesSync();
                            aux = true;
                          });
                        }

                        _image64 = base64Encode(selectedImage);
                      },
                      controller: imagen_producto,
                      imagePath: selectedImage,
                      aux: aux,
                    ),

                    const SizedBox(height: 25),
                    // Nombre producto
                    MyTextField(
                      controller: nombre_producto,
                      hintText: 'Producto',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // Descripcion producto
                    MyTextArea(
                      controller: descripcion_producto,
                      hintText: 'Descripcion',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // Precio producto
                    MyTextField(
                      controller: precio_producto,
                      hintText: 'Precio',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // Seleccion de categoria
                    Center(
                      child: DropdownMenu<CategoriaModel>(
                        controller: categoria_producto,
                        initialSelection: categorias.first,
                        onSelected: (value) {
                          //print(aux1.descripcion_categoria);
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: categorias
                            .map<DropdownMenuEntry<CategoriaModel>>(
                                (CategoriaModel value) {
                          return DropdownMenuEntry<CategoriaModel>(
                              value: value, label: value.descripcion_categoria);
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Boton de registrar
                    MyRegisterButton(onTap: register),

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

  MaterialApp windows(BuildContext context, FilePickerResult? result) {
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
                          //print("No file selected");
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
                    // Nombre producto
                    MyTextField(
                      controller: nombre_producto,
                      hintText: 'Producto',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // Descripcion producto
                    MyTextArea(
                      controller: descripcion_producto,
                      hintText: 'Descripcion',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // Precio producto
                    MyTextField(
                      controller: precio_producto,
                      hintText: 'Precio',
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    // Seleccion de categoria
                    Center(
                      child: DropdownMenu<CategoriaModel>(
                        controller: categoria_producto,
                        initialSelection: categorias.first,
                        onSelected: (value) {
                          //print(aux1.descripcion_categoria);
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: categorias
                            .map<DropdownMenuEntry<CategoriaModel>>(
                                (CategoriaModel value) {
                          return DropdownMenuEntry<CategoriaModel>(
                              value: value, label: value.descripcion_categoria);
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Boton de registrar
                    MyRegisterButton(onTap: register),

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
