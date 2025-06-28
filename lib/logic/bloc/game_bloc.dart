import 'package:bloc/bloc.dart';
import 'package:buscando_minas/logic/model.dart';
import 'package:equatable/equatable.dart';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameConfiguration configuration;
  GameBloc(this.configuration) : super(GameInitial(configuration)){
    on<InitializeGame>((event, emit) {
      final numberOfCells = configuration.width * configuration.height;
      final allCellIndexes = List.generate(numberOfCells, (index) => index)..shuffle();
      final bombIndexes = allCellIndexes.sublist(0, configuration.numberOfBombs);

      final closedCellWithBomb = List.generate(numberOfCells, (index) {
        if (bombIndexes.contains(index)) {
          return CellOpened(content: CellContent.bomb);
        }
        return CellOpened(content: CellContent.zero);
      });

      // Emitimos el nuevo estado directamente
      emit(Playing(
        configuration: configuration,
        cells: closedCellWithBomb,
      ));
    });
  }
}



// Si tienes más eventos, los registras de la misma manera:
// on<AnotherGameEvent>((event, emit) async {
//   // Lógica para AnotherGameEvent
//   emit(AnotherState());
// })