import 'package:buscando_minas/assets.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Center(
            child: Text("MINESWEEPER"),
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
            ]
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text("00"),
                  Spacer(),
                  Text("10")
                ],
              ),
            ),
            //Hacemos un gridview muy chulo para el buscaminas
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8),
                itemCount: 64,
              itemBuilder: (context, index) {
                return Image.asset(Assets.cellClosed);
              }
            )
          ],
        ),
      ),
    );
  }
}