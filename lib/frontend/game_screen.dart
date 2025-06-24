import 'package:buscando_minas/backend/model.dart';
import 'package:buscando_minas/frontend/cell_view.dart' show CellView;
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------> VARIABLES DE LA CLASE
    //numero de cuadriculas a dibujar por fila
    final int numberInEachRow = 9;
    //cantidad total de cuadriculas a dibujar
    final int numberOfSquares = numberInEachRow * numberInEachRow;
    //Configuracion del Juego
    final config = GameConfiguration(width: 9, height: 9, numberOfBombs: 5);
    int i = 0;
    //ESQUELETO DE LA PANTALLA
    return Scaffold(
      //------------------------------------------------------> BARRA DE TITULO
      appBar: AppBar(
        title: Text("BuscandoMinasHD"),
        backgroundColor: Colors.white54,
      ),
      //------------------------------------------------------> CUERPO DE LA PANTALLA
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            //------------------------------------------------------> BARRA DE ESTADO
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
                ),
              ],
            ),
          ),
          //------------------------------------------------------> TABLERO DE JUEGO
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(1.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberInEachRow,
              ),
              itemCount: numberOfSquares,
              itemBuilder: (context, index) {
                return CellView(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
