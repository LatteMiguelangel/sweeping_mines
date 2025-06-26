// ignore_for_file: avoid_unnecessary_containers

import 'package:buscando_minas/backend/model.dart';
import 'package:buscando_minas/backend/bloc/game_bloc.dart';
import 'package:buscando_minas/frontend/cell_view.dart' show CellView;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------> VARIABLES DE LA CLASE
    //Configuracion de Juego
    final configuration = GameConfiguration(
      width: 5,
      height: 5,
      numberOfBombs: 5,
    );
    //numero de cuadriculas a dibujar por fila
    final int numberInEachRow = 9;
    //cantidad total de cuadriculas a dibujar
    final int numberOfSquares = numberInEachRow * numberInEachRow;
    //ESQUELETO DE LA PANTALLA
    return BlocProvider(
      create: (context) => GameBloc(configuration)..add(InitializeGame()),
      child: BlocBuilder<GameBloc, GameState>(
        builder:
            (context, state) => Scaffold(
              //------------------------------------------------------> BARRA DE TITULO
              appBar: AppBar(
                title: Text("BuscandoMinasHD"),
                backgroundColor: Colors.white54,
              ),
              //------------------------------------------------------> CUERPO DE LA PANTALLA
              backgroundColor: Colors.black,
              body: Container(
                child: state is Playing ? _gameContent(context, numberInEachRow, numberOfSquares, state) : _loading(),
              ),
            ),
      ),
    );
  }



Widget _loading(){
  return Center(
    child: CircularProgressIndicator(),
  );
}



  Column _gameContent(BuildContext context, int numberInEachRow, int numberOfSquares, Playing state) {
    return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    //------------------------------------------------------> BARRA DE ESTADO
                    Row(
                      children: [
                        Text(
                          "TIME",
                          style:
                              Theme.of(context).primaryTextTheme.headlineLarge,
                        ),
                        Spacer(),
                        Text(
                          "FLAGS",
                          style:
                              Theme.of(context).primaryTextTheme.headlineLarge,
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
                        return CellView(cell: state.cells[index]);
                      },
                    ),
                  ),
                ],
              );
  }
}
