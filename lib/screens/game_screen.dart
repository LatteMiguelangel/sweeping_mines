import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BuscandoMinasHD"),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.topCenter,
            colors:[
              Color.fromARGB(255, 81, 81, 81),
              Color.fromARGB(108, 3, 3, 3),
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
                      "TIME",
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                    ),
                    Spacer(),
                    Text(
                      "FLAGS",
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                    )
                  ],
                ),
            ),
            Expanded(
              //padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(3.0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
                itemCount: 64,
                // retornamos una celda de color negro para que se dibuje la cuadricula
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: Colors.black,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}