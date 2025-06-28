import 'package:equatable/equatable.dart';

enum CellContent {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  bomb,
}

abstract class Cell extends Equatable {
  final CellContent content;

  const Cell({
    required this.content,
  });

  @override
  List<Object?> get props => [content];

}

class CellClosed extends Cell{
  final bool? isFlagged;
  const CellClosed({
    required super.content,
    this.isFlagged,
  });

  @override
  List<Object?> get props => super.props..add(isFlagged);
}

class CellOpened extends Cell{
  const CellOpened({required super.content});
}

class GameConfiguration{
  final int width;
  final int height;
  final int numberOfBombs;
  GameConfiguration({required this.width, required this.height, required this.numberOfBombs});

  //Funcion recursiva para generar la configuración del juego
  //gameDifficult(){}
}
