import 'package:flutter/material.dart';

//Login Button
class MyLoginButton extends StatelessWidget {
  final Function()? onTap;

  const MyLoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 221, 164, 41),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Ingresar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

//Register Button
class MyRegisterButton extends StatelessWidget {
  final Function()? onTap;

  const MyRegisterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 221, 164, 41),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Registrar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

//Back Button
class MyBackButton extends StatelessWidget {
  final Function()? onTap;

  const MyBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Icon(
          Icons.inventory_2,
          size: 100,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}

//New User Button
class MyNewUserButton extends StatelessWidget {
  final Function()? onTap;

  const MyNewUserButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        "Usuario Nuevo",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

/*class MyUploadImageButton extends StatelessWidget {
  final Function()? onTap;
  final controller;
  final imagePath;
  Uint8List selectedImageInBytes = Uint8List(0);

  MyUploadImageButton(
      {super.key,
      required this.onTap,
      required this.controller,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: (imagePath == null)
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 50,
                      )
                    : Image.memory(
                        selectedImageInBytes), /*Image.file(
                          File(imagePath),
                          fit: BoxFit.fill,
                        ))*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
