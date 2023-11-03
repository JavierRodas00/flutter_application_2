// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../components/my_buttons.dart';
import 'package:email_validator/email_validator.dart';

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
  TextEditingController password_usuario1 = TextEditingController();
  TextEditingController password_usuario2 = TextEditingController();
  TextEditingController genero_usuario = TextEditingController();
  TextEditingController fecha_nac_usuario = TextEditingController();

//Alerta
  void alertMessage(String mensaje) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(mensaje),
          );
        });
  }

//Funcion de registro
  Future<void> register() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (Validate(correo_usuario.text) &&
        password_usuario1.text != "" &&
        password_usuario2.text != "" &&
        nombre_usuario.text != "" &&
        apellido_usuario.text != "" &&
        telefono_usuario.text != "" &&
        genero_usuario.text != "") {
      if (password_usuario1.text == password_usuario2.text) {
        int genero;
        if (genero_usuario.text == "Hombre") {
          genero = 0;
        } else {
          genero = 1;
        }
        String url = "http://localhost/apiSP2/user/new_user.php";
        try {
          var res = await http.post(Uri.parse(url), body: {
            "correo_usuario": correo_usuario.text,
            "nombre_usuario": nombre_usuario.text,
            "apellido_usuario": apellido_usuario.text,
            "telefono_usuario": telefono_usuario.text,
            "id_genero": genero.toString(),
            "fecha_nac": fecha_nac_usuario.text,
            "password_usuario": password_usuario1.text
          });

          var response = jsonDecode(res.body);
          if (res.statusCode == 200) {
            //print("Usuario registrado correctamente");
            Navigator.pop(context);
            Navigator.pop(context);
            alertMessage("Usuario registrado.");
          } else {
            Navigator.pop(context);
            //print("Error registrar usuario");
            alertMessage("EROR: No se pudo registrar el usuario.");
          }
        } catch (e) {
          //print(e);
          Navigator.pop(context);
          alertMessage("ERROR de conexion.");
        }
      } else {
        Navigator.pop(context);
        //print("Llene todos los campos");
        alertMessage("ERROR: Las contraseñas no coinciden.");
      }
    } else {
      Navigator.pop(context);
      alertMessage("ERROR: Llene todos los campos");
    }
  }

//Main
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: body(context),
      ),
    );
  }

//Body
  Widget body(BuildContext context) {
    String dropDownValue = " ";
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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
                  const SizedBox(height: 20),

                  // logo
                  Icon(
                    Icons.person_add,
                    size: 80,
                    color: Colors.grey[900],
                  ),

                  const SizedBox(height: 25),

                  _inputText(correo_usuario, "Correo", const Icon(Icons.mail)),

                  const SizedBox(height: 10),

                  _inputText(
                      nombre_usuario, "Nombre", const Icon(Icons.person)),

                  const SizedBox(height: 10),

                  _inputText(
                      apellido_usuario, "Apellido", const Icon(Icons.person)),

                  const SizedBox(height: 10),

                  _inputNumber(
                      telefono_usuario, "Telefono", const Icon(Icons.phone)),

                  const SizedBox(height: 10),

                  _inputGender(genero_usuario, dropDownValue),

                  const SizedBox(height: 10),

                  _inputDate(fecha_nac_usuario, "Fecha de nacimiento",
                      const Icon(Icons.calendar_today)),

                  const SizedBox(height: 10),

                  _inputPassword(password_usuario1, "Ingrese su contraseña"),

                  const SizedBox(height: 10),

                  _inputPassword(
                      password_usuario2, "Ingrese nuevamente su contraseña"),

                  const SizedBox(height: 10),

                  MyRegisterButton(onTap: register),
                  // sign in button

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//Funcion para validar correo
  bool Validate(String email) {
    bool isvalid = EmailValidator.validate(email);
    return isvalid;
  }

//Input Password
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

//Input Text
  Widget _inputText(controller, hintText, Icon icon) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      obscureText: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          labelText: hintText,
          icon: icon
          //suffixIcon: const Icon(Icons.lock_open),
          //helperText: mensaje,
          ),
    );
  }

//Input Number
  Widget _inputNumber(controller, hintText, Icon icon) {
    return TextField(
      enableInteractiveSelection: false,
      obscureText: false,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          labelText: hintText,
          icon: icon
          //suffixIcon: const Icon(Icons.lock_open),
          //helperText: mensaje,
          ),
    );
  }

//Input Gender
  Widget _inputGender(controller, dropDownValue) {
    return DropdownMenu<int>(
      controller: controller,
      label: const Text("Genero"),
      width: 350,
      onSelected: (value) {
        setState(() {
          dropDownValue = value;
        });
      },
      dropdownMenuEntries: const [
        DropdownMenuEntry(value: 0, label: "Hombre"),
        DropdownMenuEntry(value: 1, label: "Mujer")
      ],
    );
  }

//Input date
  Widget _inputDate(controller, hintText, Icon icon) {
    return TextField(
      enableInteractiveSelection: false,
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          labelText: hintText,
          icon: icon
          //suffixIcon: const Icon(Icons.lock_open),
          //helperText: mensaje,
          ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectedDate(context);
      },
    );
  }

//Seleccionar fecha
  _selectedDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        fecha_nac_usuario.text =
            "${picked.year.toString()}-${picked.month.toString()}-${picked.day.toString()}";
      });
    }
  }
}
