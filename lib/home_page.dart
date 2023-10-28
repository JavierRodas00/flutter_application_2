// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/pages/user/shop_page.dart';
import 'package:flutter_application_2/providers/usuario_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'components/my_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var primary_color = const Color.fromARGB(255, 238, 179, 1);

  @override
  Widget build(BuildContext context) {
    //Vista de admin
    if (context.watch<UsuarioProvider>().admin == 1) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(),
          drawer: const MyDrawer(),
          floatingActionButton: Actionbutton(),
          body: Body());
    }
    //Vista de usuario
    else {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(),
          drawer: const MyDrawer(),
          body: Body());
    }
  }

//Floating Action Button
  SpeedDial Actionbutton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.inventory),
            onTap: () {
              Navigator.pushNamed(context, '/producto');
            })
      ],
    );
  }

//Body
  Column Body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            promocionesCarrousel(),
            const Divider(),
            SizedBox(
              width: 100,
              child: categorias(),
            ),
            const Divider(),
            const ShopPage()
          ],
        ))
      ],
    );
  }

//Promociones
  CarouselSlider promocionesCarrousel() {
    final List<String> imagenes = [
      'assets/images/promo1.png',
      'assets/images/promo2.png'
    ];
    return CarouselSlider.builder(
        itemCount: imagenes.length,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              imagenes[index],
              fit: BoxFit.fill,
            ),
          );
        },
        options: CarouselOptions(
            autoPlay: true,
            height: 200,
            autoPlayInterval: const Duration(seconds: 5)));
  }

//Categorias
  SizedBox categorias() {
    final List<String> categorias = [
      "categoria 1",
      "categoria 2",
      "categoria 3",
      "categoria 4",
      "categoria 5",
      "categoria 6",
      "categoria 7",
      "categoria 8"
    ];
    return SizedBox(
      height: 75,
      width: 200,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              width: 125,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
              child: Text(
                categorias[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
