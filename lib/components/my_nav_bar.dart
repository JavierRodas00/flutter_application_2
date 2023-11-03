import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import '../pages/about_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // method to log user out
  void logUserOut(BuildContext context) {
    // pop drawer
    Navigator.pop(context);
    // pop app
    Navigator.pop(context);
    // go back to login page
  }

  @override
  Widget build(BuildContext context) {
    int admin = context.watch<UsuarioProvider>().admin;
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          // Drawer header
          DrawerHeader(
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),
                ),

                //Nombre Apellido usuario actual
                Center(
                  child: Text(
                      "${context.watch<UsuarioProvider>().nombre} ${context.watch<UsuarioProvider>().apellido}"),
                )
              ],
            ),
          ),

          const SizedBox(height: 25),
          //Inicio button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                // pop screen
                Navigator.pop(context);
                // push new screen
                if (admin == 1) {
                  Navigator.pushNamed(context, '/ahome');
                } else {
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: ListTile(
                leading: const Icon(Icons.home),
                title: Text(
                  "Inicio",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ),

          // ABOUT PAGE button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  "A B O U T",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ),

          logoutButton(context),
        ],
      ),
    );
  }

  //Logout button
  Padding logoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
        leading: const Icon(Icons.logout),
        onTap: () => logUserOut(context),
        title: Text(
          "L O G O U T",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
