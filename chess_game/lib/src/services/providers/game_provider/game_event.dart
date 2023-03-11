part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class InitializeBaseFenEvent extends GameEvent {
  const InitializeBaseFenEvent({
    required this.fenString,
    this.xAxis = 8,
    this.yAxis = 8,
  });
  final String fenString;
  final int xAxis;
  final int yAxis;
}

class PieceHoverOnSquare extends GameEvent {
  const PieceHoverOnSquare({
    required this.onSquare,
    required this.triggredPiece,
  });
  final Square onSquare;
  final PieceStructure triggredPiece;
}

class Move extends GameEvent {
  const Move({required this.piece, required this.targettedSquare});
  final PieceStructure piece;
  final Square targettedSquare;
}

class SelectPiece extends GameEvent {
  const SelectPiece({
    required this.selectedPiece,
  });
  final PieceStructure selectedPiece;
}
