import 'package:buscando_minas/logic/bloc/game_bloc.dart';
import 'package:buscando_minas/logic/model.dart';
import 'package:buscando_minas/views/cell_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final configuration = GameConfiguration(width: 8, height: 8, numberOfBombs: 8);
    return BlocProvider(
      create: (context) => GameBloc(configuration)..add(InitializeGame()),
      child: BlocBuilder<GameBloc, GameState>(
  builder: (context, state) {
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
          child: state is Playing ? _gameContent(context, state) : _loading(),
        ),
      );
  },
),
    );
  }


  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _gameContent(BuildContext context, Playing state) {
    return Column(
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
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: state.gameConfiguration!.width),
                itemCount: state.cells.length,
                itemBuilder: (context, index) {
                  return CellView(cell: state.cells[index]);
                }
            )
          ],
        );
  }
}