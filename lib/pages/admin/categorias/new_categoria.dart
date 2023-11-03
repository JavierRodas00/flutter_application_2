// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/my_buttons.dart';
import '../../../components/my_textfield.dart';

class NewCategoria extends StatefulWidget {
  const NewCategoria({super.key});

  @override
  State<NewCategoria> createState() => _NewCategoriaState();
}

class _NewCategoriaState extends State<NewCategoria> {
  TextEditingController descripcion = TextEditingController();

  void wrongMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error al insertar categoria.'),
          );
        });
  }

  void successfulAdd() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Categoria Insertada correctamente.'),
          );
        });
  }

  register() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (descripcion.text != "") {
      context.read<CategoriaProvider>().insert(context, descripcion.text);

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
                    const SizedBox(height: 50),

                    // logo
                    Icon(
                      Icons.inventory_2,
                      size: 100,
                      color: Colors.grey[900],
                    ),

                    const SizedBox(height: 25),

                    // password textfield
                    MyTextArea(
                      controller: descripcion,
                      hintText: 'Descripcion',
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
