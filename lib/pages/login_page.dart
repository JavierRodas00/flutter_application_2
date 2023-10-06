// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/new_user_page.dart';
import 'package:http/http.dart' as http;

import '../components/my_login_button.dart';
import '../components/my_square_tile.dart';
import '../components/my_text_button.dart';
import '../components/my_textfield.dart';
import '../main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController correo_usuario = TextEditingController();
  TextEditingController password_usuario = TextEditingController();

  Future<void> navegar_new_user() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewUser(),
      ),
    );
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (correo_usuario.text != "" && password_usuario.text != "") {
      String url = "http://localhost/apiSP2/user/login.php";
      try {
        var res = await http.post(Uri.parse(url), body: {
          "correo_usuario": correo_usuario.text,
          "password_usuario": password_usuario.text
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Login correctamente");
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        } else {
          Navigator.pop(context);
          print("Error Login");
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
                    Icons.lock,
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
                    controller: password_usuario,
                    hintText: 'Contraseña',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Olvidó su contraseña?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyLoginButton(
                    onTap: signUserIn,
                  ),

                  const SizedBox(height: 50),

                  MyNewUserButton(
                    onTap: navegar_new_user,
                  ),

                  /* // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'O continúa con',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google + apple sign in buttons
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(imagePath: 'lib/images/google.png'),

                      SizedBox(width: 25),

                      // apple button
                      SquareTile(imagePath: 'lib/images/apple.png')
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
