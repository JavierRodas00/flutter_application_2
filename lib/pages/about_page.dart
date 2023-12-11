import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  var primary_color = const Color.fromARGB(255, 238, 179, 1);

  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        elevation: 0,
        title: Text(
          'A B O U T',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(child: Text('this app was designed for..')),
    );
  }
}
