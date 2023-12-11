import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_buttons.dart';
import 'package:flutter_application_2/model/Carrito_model.dart';
import 'package:flutter_application_2/model/Pedido_model.dart';
import 'package:flutter_application_2/providers/pedido_provider.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class DetallePedido extends StatelessWidget {
  DetallePedido({super.key});
  var primary_color = const Color.fromARGB(255, 238, 179, 1);

  @override
  Widget build(BuildContext context) {
    PedidoModel pedido = context.watch<PedidoProvider>().actual;
    String usuario = context.watch<PedidoProvider>().usuario;
    String direccion = context.watch<PedidoProvider>().direccion;
    String fecha = context.watch<PedidoProvider>().fecha;
    int admin = context.read<UsuarioProvider>().admin;
    if (admin == 1) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primary_color,
          elevation: 0,
          title: const Text(
            'Detalle Pedido',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body(pedido, context, usuario, direccion, fecha),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primary_color,
          elevation: 0,
          title: const Text(
            'Detalle Pedido',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: body1(pedido, context, usuario, direccion, fecha),
      );
    }
  }

  Widget body(PedidoModel pedido, BuildContext context, String usuario,
      String direccion, String fecha) {
    String estado = pedido.estado;
    String textoBoton = "";
    if (estado == "0") {
      textoBoton = "Cambiar a 'En Proceso'";
    } else if (estado == "1") {
      textoBoton = "Cambiar a 'Enviado'";
    }
    if (estado == "2") {
      textoBoton = "Cambiar a 'Finalizado'";
    }
    double precioTotal = 0;
    for (var i in pedido.productos) {
      precioTotal = precioTotal + i.precio;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  const Text("ID_PEDIDO: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(pedido.id_pedido)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("FECHA: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fecha)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("CLIENTE: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(usuario)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("DIRECCION: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(direccion)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              tabla(pedido),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [const Text("Total: "), Text(precioTotal.toString())],
              )
            ],
          )),
          Row(
            children: [
              Expanded(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                  child: MyButton(
                    onTap: () {
                      context.read<PedidoProvider>().cambiarEstado(pedido);
                      Navigator.pop(context);
                    },
                    title: textoBoton,
                  ),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget body1(PedidoModel pedido, BuildContext context, String usuario,
      String direccion, String fecha) {
    String estado = pedido.estado;
    double precioTotal = 0;
    for (var i in pedido.productos) {
      precioTotal = precioTotal + i.precio;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  const Text("ID_PEDIDO: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(pedido.id_pedido)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("FECHA: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(fecha)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("CLIENTE: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(usuario)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("DIRECCION: "),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(direccion)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              tabla(pedido),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [const Text("Total: "), Text(precioTotal.toString())],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget tabla(PedidoModel pedido) {
    return DataTable(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        dataRowColor: MaterialStateProperty.all(Colors.white),
        dividerThickness: 1,
        columns: const [
          DataColumn(label: Text("Cant.")),
          DataColumn(label: Text("Producto")),
          DataColumn(label: Text("Precio"))
        ],
        rows: List.generate(pedido.productos.length,
            (index) => _generateDataRow(pedido.productos[index])));
  }

  DataRow _generateDataRow(CarritoModel productos) {
    return DataRow(cells: <DataCell>[
      DataCell(Text(productos.cantidad.toString())),
      DataCell(Text(productos.producto.nombre_produto)),
      DataCell(Text(productos.precio.toString()))
    ]);
  }
}
