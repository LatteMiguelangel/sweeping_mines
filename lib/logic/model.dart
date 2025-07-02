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
  final int index;

  const Cell({
    required this.content,
    required this.index
  });

  @override
  List<Object?> get props => [index,content];

}

class CellClosed extends Cell{
  final bool? isFlagged;
  const CellClosed({
    required super.index,
    required super.content,
    this.isFlagged,
  });

  @override
  List<Object?> get props => super.props..add(isFlagged);
}

class CellOpened extends Cell{
  const CellOpened({
    required super.content,
    required super.index
    });
}

class GameConfiguration{
  final int width;
  final int height;
  final int numberOfBombs;
  GameConfiguration({required this.width, required this.height, required this.numberOfBombs});
}