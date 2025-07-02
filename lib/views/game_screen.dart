import 'package:buscando_minas/logic/bloc/game_bloc.dart';
import 'package:buscando_minas/logic/model.dart';
import 'package:buscando_minas/views/cell_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configuration = GameConfiguration(
      width: 8,
      height: 8,
      numberOfBombs: 8,
    );

    return BlocProvider(
      create: (context) => GameBloc(configuration)..add(InitializeGame()),
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black54,
              title: const Center(child: Text('MINESWEEPER')),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.black],
                ),
              ),
              child: state is Playing ? _gameContent(state) : _loading(),
            ),
          );
        },
      ),
    );
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _gameContent(Playing state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Puntaje: ${state.score}',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final gridSize =
                  constraints.maxWidth; // Limita a ancho de la pantalla
              final cellSize = (gridSize - 8 * 4) / 8; // Considera los espacios
              return Center(
                child: SizedBox(
                  width: gridSize,
                  height: gridSize,
                  child: GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                    padding: const EdgeInsets.all(2),
                    itemCount: state.cells.length,
                    itemBuilder: (context, index) {
                      return CellView(cell: state.cells[index]);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
