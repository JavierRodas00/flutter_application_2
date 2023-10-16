// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/user/shop_page.dart';
import 'components/my_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var primary_color = const Color.fromARGB(255, 238, 179, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: primary_color,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text(
            'deTocho',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Colors.white, // Icono de la carreta
              onPressed: () {},
            )
          ],
        ),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primary_color,
          child: const Icon(Icons.add),
        ),
        body: Column(
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
        ));
  }
}

Widget promocionesCarrousel() {
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
          autoPlayInterval: const Duration(seconds: 3)));
}

Widget categorias() {
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
