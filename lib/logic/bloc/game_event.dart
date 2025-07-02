part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
  @override
  List<Object> get props => [];
}

class InitializeGame extends GameEvent {
  const InitializeGame();
}

class TapCell extends GameEvent {
  final int index;
  const TapCell(this.index);

  @override
  List<Object> get props => [index];
}
class ToggleFlag extends GameEvent {
  final int index;
  const ToggleFlag(this.index);
}