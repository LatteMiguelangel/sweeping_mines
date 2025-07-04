import 'package:equatable/equatable.dart';

enum CellContent { zero, one, two, three, four, five, six, seven, eight, bomb }

abstract class Cell extends Equatable {
  final CellContent content;
  final int index;

  const Cell({
    required this.index,
    required this.content,
  });

  @override
  List<Object?> get props => [index, content];
}

extension CellExtension on Cell {
  bool get hasBomb =>
      this is CellClosed && (this as CellClosed).content == CellContent.bomb;
}

class CellClosed extends Cell {
  final bool flagged;

  const CellClosed({
    required super.index,
    required super.content,
    this.flagged = false,
  });

  CellClosed copyWith({CellContent? content, bool? flagged}) {
    return CellClosed(
      index: index,
      content: content ?? this.content,
      flagged: flagged ?? this.flagged,
    );
  }

  @override
  List<Object?> get props => super.props..add(flagged);
}

class CellOpened extends Cell {
  const CellOpened({
    required super.index,
    required super.content,
  });
}

class GameConfiguration {
  final int width;
  final int height;
  final int numberOfBombs;

  const GameConfiguration({
    required this.width,
    required this.height,
    required this.numberOfBombs,
  });
}
