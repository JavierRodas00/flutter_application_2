// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/scrollBehavior.dart';
import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/model/Pedido_model.dart';
import 'package:flutter_application_2/providers/pedido_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PedidoProvider>().start2(context);
  }

  @override
  Widget build(BuildContext context) {
    List<PedidoModel> _pedidos = context.watch<PedidoProvider>().mispedidos;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: Body(context, _pedidos),
      ),
    );
  }

  Widget Body(BuildContext context, List<PedidoModel> _pedidos) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //Bienvenido $nombre
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Expanded(
                    child: Text(
                  "Hola ${context.watch<UsuarioProvider>().nombre}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )),
                /* const Icon(Icons.menu) */
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.menu),
                )
              ]),
            ),

            const SizedBox(
              height: 250,
            ),

            // Boton de "pedir ahora"
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(250, 221, 164, 41)),
                  child: const Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Pedir ahora",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                      Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 250,
            ),

            // Lista de pedidos actuales
            listaPedidos(context, _pedidos)
          ],
        ),
      ),
    );
  }

  Widget listaPedidos(BuildContext context, List<PedidoModel> lista) {
    return ListView.builder(
      itemCount: lista.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int cantidadProductos = 0;
        String estado = "";
        double precioTotal = 0;
        for (CarritoModel producto in lista[index].productos) {
          cantidadProductos = cantidadProductos + producto.cantidad;
          precioTotal = precioTotal + producto.precio;
        }
        if (lista[index].estado == "0") {
          estado = "Pendiente";
        } else if (lista[index].estado == "1") {
          estado = "En Proceso";
        } else if (lista[index].estado == "2") {
          estado = "Enviado";
        }
        return GestureDetector(
          onTap: () {
            context.read<PedidoProvider>().setActual(lista[index]);
            Navigator.pushNamed(context, '/detalle_pedido');
          },
          child: Container(
            width: 100,
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
                  child: Column(
                    children: [
                      Text(
                        "Pedido No. ${lista[index].id_pedido}",
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Text(
                        "Cantidad de productos: $cantidadProductos",
                      ),
                      Text(
                        "Total a pagar: $precioTotal",
                      ),
                      Text(
                        "Estado: $estado",
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
