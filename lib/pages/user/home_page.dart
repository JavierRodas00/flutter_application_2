// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/appbar.dart';
import 'package:flutter_application_2/components/scrollBehavior.dart';
import 'package:flutter_application_2/model/Categoria_model.dart';
import 'package:flutter_application_2/pages/user/shop_page.dart';
import 'package:flutter_application_2/providers/categoria_provider.dart';
import 'package:provider/provider.dart';
import '../../components/my_nav_bar.dart';
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context),
        drawer: const MyDrawer(),
        body: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(), child: Body()));
  }

//Floating Action Button

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
              child: categorias(context),
            ),
            const Divider(),
            const ShopPage(),
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
  SizedBox categorias(BuildContext context) {
    int _selected = context.watch<CategoriaProvider>().selectedCategoria;
    List<CategoriaModel> _categorias =
        context.watch<CategoriaProvider>().categorias;
    return SizedBox(
      height: 75,
      width: 200,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<CategoriaProvider>().seleccionar(index + 1);
            },
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 125,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: _selected.toString() == _categorias[index].id_categoria
                      ? Colors.grey
                      : Colors.red,
                ),
                child: Text(
                  _categorias[index].descripcion_categoria,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
