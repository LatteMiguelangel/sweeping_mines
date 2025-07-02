part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  final GameConfiguration? gameConfiguration;
  const GameState(this.gameConfiguration);

  @override
  List<Object?> get props => [gameConfiguration];
}

class GameInitial extends GameState {
  const GameInitial(super.gameConfiguration);
}

class Playing extends GameState {
  final List<Cell> cells;
  final int currentPlayer;
  final List<int> scores;

  const Playing({
    GameConfiguration? configuration,
    required this.cells,
    required this.currentPlayer,
    required this.scores,
  }) : super(configuration);

  @override
  List<Object?> get props => super.props..addAll([cells, currentPlayer, scores]);
}
