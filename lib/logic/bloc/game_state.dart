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
  final int score;

  const Playing({
    GameConfiguration? configuration,
    required this.cells,
    required this.score,
  }) : super(configuration);

  @override
  List<Object?> get props => super.props..addAll([cells, score]);
}

class GameOver extends GameState {
  final List<Cell> cells;
  final bool won;

  const GameOver({
    GameConfiguration? configuration,
    required this.cells,
    required this.won,
  }) : super(configuration);

  @override
  List<Object?> get props => super.props..addAll([cells, won]);
}

class Victory extends GameState {
  final int score;
  const Victory(super.gameConfiguration, {required this.score});
  @override
  List<Object?> get props => super.props..addAll([score]);
}
