// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/loading.dart';
import 'package:flutter_application_2/providers/bd_provider.dart';
import 'package:flutter_application_2/providers/producto_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController correo_usuario = TextEditingController();
  TextEditingController password_usuario = TextEditingController();

  navegar_new_user() {
    Navigator.pushNamed(context, '/register');
  }

  void wrongLoginMessage() {
    password_usuario.clear();
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Correo y/o contraseña incorrecta.'),
          );
        });
  }

  void errorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Ingrese correo y contraseña validos.'),
          );
        });
  }

  Future<void> signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: loading(),
        );
      },
    );
    context.read<ProductoProvider>().start(context);
    //Verificar que los campos correo y password esten lleno
    if (correo_usuario.text.isNotEmpty && password_usuario.text.isNotEmpty) {
      String url =
          BDProvider().url + "detocho/api/scripts/login.php?action=login";
      //Mandar a llamar a API
      try {
        var res = await http.post(Uri.parse(url), body: {
          "correo_usuario": correo_usuario.text,
          "password_usuario": password_usuario.text
        });
        if (res.statusCode == 200) {
          var response = jsonDecode(res.body);
          for (var aux in response) {
            //print("Login usuario: ${aux["id_usuario"]}");
            correo_usuario.clear();
            password_usuario.clear();
            // pop loading
            Navigator.pop(context);
            if (aux["admin_usuario"] == "1") {
              //context.read<PedidoProvider>().start();
              context.read<UsuarioProvider>().set(1, aux["nombre_usuario"],
                  aux["apellido_usuario"], aux["id_usuario"]);
              Navigator.pushNamed(context, '/ahome');
            } else {
              if (aux["cambio_pass"] == "1") {
                context.read<UsuarioProvider>().set(0, aux["nombre_usuario"],
                    aux["apellido_usuario"], aux["id_usuario"]);
                Navigator.pushNamed(context, '/newPass');
              } else {
                context.read<UsuarioProvider>().set(0, aux["nombre_usuario"],
                    aux["apellido_usuario"], aux["id_usuario"]);
                Navigator.pushNamed(context, '/introScreen');
              }
            }
          }
        } else {
          // pop loading
          Navigator.pop(context);
          print("Error Login");
          wrongLoginMessage();
        }
      } catch (e) {
        print(e);
        // pop loading
        Navigator.pop(context);
        wrongLoginMessage();
      }
    }
    //Si los campos correo y password no estan llenos mostrar mensaje de error
    else {
      // pop loading
      Navigator.pop(context);
      errorMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Body(),
      ),
    );
  }

//body
  SafeArea Body() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              Image.asset(
                "assets/images/logo.png",
                width: 200,
                height: 200,
              ),

              Container(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  Expanded(
                      child: Column(
                    children: [
                      // CORREO
                      MyTextField(
                        controller: correo_usuario,
                        hintText: 'Correo',
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),

                      // PASSWORD
                      MyTextField(
                        controller: password_usuario,
                        hintText: 'Contraseña',
                        obscureText: true,
                      ),
                    ],
                  )),
                  const SizedBox(width: 10),
                  // LOGIN BUTTON
                  GestureDetector(
                    onTap: () {
                      signUserIn();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 164, 41),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ),

              // forgot password?
              GestureDetector(
                onTap: () {
                  olvidoPass();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Olvidó su contraseña?',
                        style:
                            TextStyle(fontSize: 12.5, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),

              GestureDetector(
                  onTap: () {
                    navegar_new_user();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Registrate",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  olvidoPass() {
    Navigator.pushNamed(context, '/recovery');
  }
}
