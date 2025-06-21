import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BuscandoMinasHD"),
        titleSpacing: 10.0,
        titleTextStyle: TextStyle(
          color: Colors.redAccent,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Container(

      ),
    );
  }
}