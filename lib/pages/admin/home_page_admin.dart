// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/components/my_nav_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  var primary_color = const Color.fromARGB(255, 238, 179, 1);
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      pendientes(context),
      const Text(
        "En Proceso",
        style: optionStyle,
      ),
      const Text(
        "Enviados",
        style: optionStyle,
      )
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      drawer: const MyDrawer(),
      floatingActionButton: actionButton(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Container bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.redAccent,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          tabs: const [
            GButton(
              icon: Icons.call_received,
              text: "PENDIENTES",
            ),
            GButton(
              icon: Icons.sync,
              text: "EN PROCESO",
            ),
            GButton(
              icon: Icons.local_shipping,
              text: "ENVIADOS",
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  SpeedDial actionButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.inventory),
            label: "Productos",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/producto');
            }),
        SpeedDialChild(
            child: const Icon(Icons.category),
            label: "Categoria",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/categoria');
            }),
      ],
    );
  }

  Column body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  "PEDIDOS",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: 500,
              width: 200,
              child: Container(
                decoration: const BoxDecoration(color: Colors.red),
              ),
            )
          ],
        ))
      ],
    );
  }

  Column pendientes(BuildContext context) {
    return const Column(
      children: [Text("PRUEBA")],
    );
  }
}
