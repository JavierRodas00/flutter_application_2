import 'package:flutter/material.dart';

class NewDirection extends StatefulWidget {
  const NewDirection(String idusuario, {super.key});

  @override
  State<NewDirection> createState() => _NewDirectionState();
}

class _NewDirectionState extends State<NewDirection> {
  TextEditingController id_edificio = TextEditingController();
  TextEditingController numero_apto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Icon(
                  Icons.location_on,
                  size: 80,
                  color: Colors.grey[900],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _inputGender(controller, label, dropDownValue) {
    return DropdownMenu<int>(
      controller: controller,
      label: label,
      width: 350,
      onSelected: (value) {
        setState(() {
          dropDownValue = value;
        });
      },
      dropdownMenuEntries: const [
        DropdownMenuEntry(value: 0, label: "Hombre"),
        DropdownMenuEntry(value: 1, label: "Mujer")
      ],
    );
  }
}
