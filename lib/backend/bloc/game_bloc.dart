import 'package:bloc/bloc.dart';
import 'package:buscando_minas/backend/model.dart';
import 'package:equatable/equatable.dart';
part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameConfiguration configuration;
  GameBloc(this.configuration) : super(GameInitial(configuration));
  Stream<GameState> mapEventToState(GameEvent event) async*{
    // ignore: unused_local_variable
    final currentState = state;

    if (event is InitializeGame){
      yield* _mapInitializeGame();
    }
  }

  Stream<GameState> _mapInitializeGame() async*{
    final numberOfCells = configuration.width * configuration.height;
    final allCellIndexes = List.generate(numberOfCells, (index) => index)..shuffle();
    final bombIndexes = allCellIndexes.sublist(0, configuration.numberOfBombs);

    final emptyCellWithBomb = List.generate(numberOfCells,(index){
      if(bombIndexes.contains(index)){
        return CellClosed(content: CellContent.bomb);
      }
      return CellClosed(content: CellContent.zero);
    });

    yield Playing(
      configuration: configuration,
      cells: emptyCellWithBomb,
      );
  }
}
