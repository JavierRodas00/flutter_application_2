// ignore_for_file: must_be_immutable, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:http/http.dart' as http;

class RecuperarPass extends StatelessWidget {
  TextEditingController correo_usuario = TextEditingController();
  TextEditingController telefono_usuario = TextEditingController();

  var primary_color = const Color.fromARGB(255, 238, 179, 1);
  RecuperarPass({super.key});

  Future<void> recuperar(BuildContext context) async {
    if (correo_usuario.text != "" && telefono_usuario.text != "") {
      String url =
          BDProvider().url + "detocho/api/scripts/login.php?action=recuperar";
      try {
        var res = await http.post(Uri.parse(url), body: {
          "correo_usuario": correo_usuario.text,
          "telefono_usuario": telefono_usuario.text
        });
        var response = jsonDecode(res.body);
        //print(response['new_password']);
        if (res.statusCode == 200) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Recuperar Contraseña"),
                  content: Text(
                      "Su nueva contraseña es: ${response['new_password']}"),
                );
              });
        }
      } catch (e) {
        //print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        const Text(
                          "Recuperar Contraseña",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 25),

                        // password textfield
                        _inputText(correo_usuario, "Correo", Icon(Icons.mail)),

                        const SizedBox(height: 10),

                        _inputText(
                            telefono_usuario, "Telefono", Icon(Icons.phone)),

                        const SizedBox(height: 30),

                        GestureDetector(
                          onTap: () {
                            recuperar(context);
                            //print("accion");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 221, 164, 41),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Recuperar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // sign in button

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _inputText(controller, hintText, Icon icon) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      obscureText: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          labelText: hintText,
          icon: icon),
    );
  }
}
