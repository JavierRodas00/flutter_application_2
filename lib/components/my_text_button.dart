import 'package:flutter/material.dart';

/*

B U T T O N

This is a custom built sign in button!

*/

class MyNewUserButton extends StatelessWidget {
  final Function()? onTap;

  const MyNewUserButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
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
