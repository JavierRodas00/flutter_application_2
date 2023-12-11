// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CambiarPass extends StatelessWidget {
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();

  var primary_color = const Color.fromARGB(255, 238, 179, 1);
  CambiarPass({super.key});

  Future<void> recuperar(BuildContext context) async {
    if (pass1.text != "" && pass2.text != "" && pass1.text == pass2.text) {
      String url =
          BDProvider().url + "detocho/api/scripts/login.php?action=cambiar";
      try {
        var res = await http.post(Uri.parse(url), body: {
          "password_usuario": pass1.text,
          "id_usuario": context.read<UsuarioProvider>().idUsuario
        });
        var response = jsonDecode(res.body);
        //print(response['new_password']);
        if (res.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/introScreen');
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Cambiar Contraseña"),
                  content: Text("Contraseña actualizada"),
                );
              });
        }
      } catch (e) {
        print(e);
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
                          "Cambiar Contraseña",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 25),

                        // password textfield
                        _inputPassword(pass1, "Ingrese su contraseña"),

                        const SizedBox(height: 10),

                        _inputPassword(
                            pass2, "Ingrese nuevamente su contraseña"),

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
                                "Cambiar Contraseña",
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

  Widget _inputPassword(controller, mensaje) {
    return TextField(
      enableInteractiveSelection: false,
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: "Contraseña",
          labelText: "Contraseña",
          //suffixIcon: const Icon(Icons.lock_open),
          helperText: mensaje,
          icon: const Icon(Icons.lock)),
    );
  }
}
