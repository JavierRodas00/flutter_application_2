// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/login_page.dart';
import 'package:http/http.dart' as http;
import '../../components/my_buttons.dart';
import '../components/my_textfield.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController correo_usuario = TextEditingController();
  TextEditingController nombre_usuario = TextEditingController();
  TextEditingController apellido_usuario = TextEditingController();
  TextEditingController telefono_usuario = TextEditingController();
  TextEditingController password_usuario = TextEditingController();

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

  Future<void> register() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (correo_usuario.text != "" &&
        password_usuario.text != "" &&
        nombre_usuario.text != "" &&
        apellido_usuario.text != "" &&
        telefono_usuario.text != "") {
      String url = "http://localhost/apiSP2/user/new_user.php";
      try {
        var res = await http.post(Uri.parse(url), body: {
          "correo_usuario": correo_usuario.text,
          "nombre_usuario": nombre_usuario.text,
          "apellido_usuario": apellido_usuario.text,
          "telefono_usuario": telefono_usuario.text,
          "password_usuario": password_usuario.text
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Usuario registrado correctamente");
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else {
          Navigator.pop(context);
          print("Error registrar usuario");
          wrongLoginMessage();
        }
      } catch (e) {
        print(e);
        Navigator.pop(context);
        wrongLoginMessage();
      }
    } else {
      Navigator.pop(context);
      print("Llene todos los campos");
      errorMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  Icon(
                    Icons.person_add,
                    size: 100,
                    color: Colors.grey[900],
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: correo_usuario,
                    hintText: 'Correo',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: nombre_usuario,
                    hintText: 'Nombre',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: apellido_usuario,
                    hintText: 'Apellido',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: telefono_usuario,
                    hintText: 'Telefono',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: password_usuario,
                    hintText: 'Contraseña',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  MyRegisterButton(onTap: register),
                  // sign in button

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
