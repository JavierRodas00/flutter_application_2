import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/pages/admin/productos/new_producto.dart';
import 'package:flutter_application_2/pages/admin/update_producto.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import '../pages/about_page.dart';

//Nav Bar

//Side Bar

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
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          // Drawer header
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.person,
                size: 64,
              ),
            ),
          ),
          Text(
              "${context.watch<UsuarioProvider>().nombre} ${context.watch<UsuarioProvider>().apellido}"),

          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
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

          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewProducto(),
                  ),
                );
              },
              child: ListTile(
                leading: const Icon(Icons.inventory_2),
                title: Text(
                  "Agregar Producto",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ),
          //Update producto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProducto(),
                  ),
                );
              },
              child: ListTile(
                leading: const Icon(Icons.inventory_2),
                title: Text(
                  "Actualizar Producto",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ),
          // ABOUT PAGE
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

          // LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              onTap: () => logUserOut(context),
              title: Text(
                "L O G O U T",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
