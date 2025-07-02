import 'package:bloc/bloc.dart';
import 'package:buscando_minas/logic/model.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

List<Cell> generateBoard(GameConfiguration config) {
  int width = config.width;
  int height = config.height;
  int total = width * height;

  List<int> bombIndexes = List.generate(total, (i) => i)..shuffle();
  bombIndexes = bombIndexes.sublist(0, config.numberOfBombs);

  List<Cell> cells = List.generate(total, (i) {
    return CellClosed(index: i, content: CellContent.zero);
  });

  for (var i in bombIndexes) {
    cells[i] = CellClosed(index: i, content: CellContent.bomb);
  }

  for (int i = 0; i < total; i++) {
    if (cells[i].content == CellContent.bomb) continue;

    int bombCount = 0;
    int x = i % width;
    int y = i ~/ width;

    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        int nx = x + dx;
        int ny = y + dy;
        if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
          int ni = ny * width + nx;
          if (cells[ni].content == CellContent.bomb) {
            bombCount++;
          }
        }
      }
    }

    cells[i] = CellClosed(
      index: i,
      content: CellContent.values[bombCount],
    );
  }

  return cells;
}

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameConfiguration configuration;

  GameBloc(this.configuration) : super(GameInitial(configuration)) {
    on<InitializeGame>((event, emit) {
      final cells = generateBoard(configuration);
      emit(
        Playing(
          configuration: configuration,
          cells: cells,
          score: 0,
        ),
      );
    });

    on<TapCell>((event, emit) {
      final state = this.state;
      if (state is! Playing) return;

      final tappedIndex = event.index;
      final cells = [...state.cells];
      final tappedCell = cells[tappedIndex];

      if (tappedCell is! CellClosed) return;

      if (tappedCell.content == CellContent.bomb) {
        cells[tappedIndex] = CellOpened(
          index: tappedIndex,
          content: tappedCell.content,
        );

        emit(
          Playing(
            configuration: state.gameConfiguration,
            cells: cells,
            score: state.score,
          ),
        );
        return;
      }

      _revealCellsRecursively(
        cells,
        tappedIndex,
        configuration.width,
        configuration.height,
      );

      int points = cells
          .where((cell) =>
              cell is CellOpened &&
              state.cells[cell.index] is CellClosed &&
              cell.content != CellContent.bomb)
          .length;

      emit(
        Playing(
          configuration: state.gameConfiguration,
          cells: cells,
          score: state.score + points,
        ),
      );
    });
  }

  void _revealCellsRecursively(
    List<Cell> cells,
    int index,
    int width,
    int height,
  ) {
    if (index < 0 || index >= cells.length) return;
    if (cells[index] is CellOpened) return;

    final current = cells[index] as CellClosed;
    if (current.content == CellContent.bomb) return;

    cells[index] = CellOpened(
      index: index,
      content: current.content,
    );

    if (current.content == CellContent.zero) {
      int x = index % width;
      int y = index ~/ width;

      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx == 0 && dy == 0) continue;
          int nx = x + dx;
          int ny = y + dy;
          if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
            int ni = ny * width + nx;
            _revealCellsRecursively(cells, ni, width, height);
          }
        }
      }
    }
  }
}