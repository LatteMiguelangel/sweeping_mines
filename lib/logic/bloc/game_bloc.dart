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

    cells[i] = CellClosed(index: i, content: CellContent.values[bombCount]);
  }

  return cells;
}

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameConfiguration configuration;
  int flagsPlaced = 0;

  GameBloc(this.configuration) : super(GameInitial(configuration)) {
    on<InitializeGame>((event, emit) {
      final cells = generateBoard(configuration);
      flagsPlaced = 0;
      emit(Playing(configuration: configuration, cells: cells, score: 0));
    });

    on<TapCell>(_onTapCell);
    on<ToggleFlag>(_onToggleFlag);
  }

  void _onTapCell(TapCell event, Emitter<GameState> emit) {
    final state = this.state;
    if (state is! Playing) return;

    final tappedIndex = event.index;
    final cells = [...state.cells];
    final tappedCell = cells[tappedIndex];

    if (tappedCell is! CellClosed || tappedCell.flagged) return;

    if (tappedCell.content == CellContent.bomb) {
      // Revelar todas las bombas
      for (int i = 0; i < cells.length; i++) {
        if (cells[i] is CellClosed &&
            (cells[i] as CellClosed).content == CellContent.bomb) {
          cells[i] = CellOpened(index: i, content: CellContent.bomb);
        }
      }

      emit(GameOver(configuration: configuration, cells: cells, won: false));
      return;
    }

    _revealCellsRecursively(
      cells,
      tappedIndex,
      configuration.width,
      configuration.height,
    );

    int revealedCount =
        cells
            .where((c) => c is CellOpened && state.cells[c.index] is CellClosed)
            .length;

    emit(
      Playing(
        configuration: configuration,
        cells: cells,
        score: state.score + revealedCount,
      ),
    );
  }

  void _onToggleFlag(ToggleFlag event, Emitter<GameState> emit) {
    final state = this.state;
    if (state is! Playing) return;

    final index = event.index;
    final cell = state.cells[index];

    if (cell is! CellClosed) return;

    if (!cell.flagged && flagsPlaced >= configuration.numberOfBombs) {
      return; // Límite de banderas alcanzado
    }

    final updatedCell = cell.copyWith(flagged: !cell.flagged);
    final updatedCells = [...state.cells];
    updatedCells[index] = updatedCell;

    flagsPlaced += updatedCell.flagged ? 1 : -1;
    if (_checkWinCondition(updatedCells)) {
      emit(Victory(state.gameConfiguration, score: state.score));
    } else {
      emit(
        Playing(
          configuration: configuration,
          cells: updatedCells,
          score: state.score,
        ),
      );
    }
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
    if (current.flagged || current.content == CellContent.bomb) return;

    cells[index] = CellOpened(index: index, content: current.content);

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

  bool _checkWinCondition(List<Cell> cells) {
    // Obtiene solo las celdas con banderas
    final flagged = cells
    .where((cell) => cell is CellClosed && cell.flagged)
    .toList();
    // Si el número de banderas no coincide con el número de bombas, no puede ganar
    if (flagged.length != configuration.numberOfBombs) return false;
    // Verifica que todas las celdas con bandera sean bombas
    for (var cell in flagged) {
      if (!cell.hasBomb) return false;
    }
    return true;
  }
}
