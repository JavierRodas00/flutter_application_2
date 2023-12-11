// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/components/my_nav_bar.dart';
import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/model/Pedido_model.dart';
import 'package:flutter_application_2/providers/pedido_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  var primary_color = const Color.fromARGB(255, 238, 179, 1);
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 20);

  @override
  void initState() {
    super.initState();
    context.read<PedidoProvider>().start();
  }

  @override
  Widget build(BuildContext context) {
    List<PedidoModel> _pedido = context.watch<PedidoProvider>().pendientes;
    List<PedidoModel> _proceso = context.watch<PedidoProvider>().proceso;
    List<PedidoModel> _enviado = context.watch<PedidoProvider>().enviados;
    List<Widget> _widgetOptions = <Widget>[
      crearLista(_pedido),
      crearLista(_proceso),
      crearLista(_enviado),
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
              Navigator.pushNamed(context, '/producto');
            }),
        /* SpeedDialChild(
            child: const Icon(Icons.category),
            label: "Categoria",
            onTap: () {
              Navigator.pushNamed(context, '/categoria');
            }), */
      ],
    );
  }

  Widget crearLista(List<PedidoModel> lista) {
    return ListView.builder(
      itemCount: lista.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _mostrarDetalle(lista[index]);
          },
          child: Container(
            width: 100,
            height: 175,
            padding: const EdgeInsets.all(5),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 125,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(171, 255, 250, 195)),
                  child: Row(
                    children: [
                      Text(
                        lista[index].id_pedido,
                        style: optionStyle,
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Expanded(
                          child: crearListaProductos(lista[index].productos)),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Widget crearListaProductos(List<CarritoModel> lista) {
    double precioTotal = 0;

    for (var i in lista) {
      precioTotal = precioTotal + i.precio;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          Text(
                            lista[index].cantidad.toString(),
                            style: optionStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            lista[index].producto.nombre_produto,
                            style: optionStyle,
                          )),
                          Text(lista[index].precio.toString())
                        ],
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              const Expanded(child: Text("Total")),
              Text(
                precioTotal.toString(),
                style: optionStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _mostrarDetalle(PedidoModel pedido) {
    context.read<PedidoProvider>().setActual(pedido);
    Navigator.pushNamed(context, '/detalle_pedido');
    /* showDialog(
        context: context,
        builder: (BuildContext buildcontext) {
          return AlertDialog(
            title: const Text("Alerta"),
            content: const Text("Seguro que quiere terminar este proceso?"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    context.read<PedidoProvider>().cambiarEstado(pedido);
                    Navigator.pop(context);
                  },
                  child: const Text("Si")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
            ],
          );
        }); */
  }
}
