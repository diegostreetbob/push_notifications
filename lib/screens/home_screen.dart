////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
class HomeScreen extends StatelessWidget {
  //Atributos
  static const String route = "HomeScreen";//Ruta de esta pantalla
  //Constructor
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: const Text("HomeScreen")),
      body: const Center(child: Text("HomeScreen")),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

  






