import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BuscandoMinasHD"),
        backgroundColor: Color.fromARGB(255, 52, 223, 0),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.topCenter,
            colors:[
              Color.fromARGB(255, 156, 155, 155),
              Color.fromARGB(225, 3, 3, 3),
            ]
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: 
                Row(
                  children: [
                    Text(
                      "TIMER",
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                    ),
                    Spacer(flex: 1),
                    Text(
                      "MINES",
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}