import 'package:chess_game/src/models/square_models.dart';

import '../global/constants/constants.dart';

abstract class PieceStructure {
  SquareCoordinate get getCurrentCoordinate;
  String get getName;
  Identity get getIdentity;
  bool get getIsSelected;
  List<SquareCoordinate> get getPossibleMoves;
  String get imagePath;
  int get getWorth;
}

class Pawn extends PieceStructure {
  SquareCoordinate currentCoordinate;
  Identity identity = Identity.white;
  bool isSelected = false;
  String name = "Pawn";

  Pawn({required this.currentCoordinate});

  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate;

  @override
  List<SquareCoordinate> get getPossibleMoves {
    return [
      SquareCoordinate(
          column: currentCoordinate.column, row: currentCoordinate.row + 1),
    ];
  }

  @override
  Identity get getIdentity => identity;

  @override
  bool get getIsSelected => isSelected;

  @override
  String get getName => name;

  @override
  String get imagePath => "assets/pieces/png/white_pawn.png";

  @override
  int get getWorth => 1;
}

class Bishop extends PieceStructure {
  SquareCoordinate currentCoordinate;
  Identity identity = Identity.white;
  bool isSelected = false;
  String name = "Bishop";

  Bishop({required this.currentCoordinate});

  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate;

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    for (int i = 1; i < 8; i++) {
      moves.add(SquareCoordinate(
          column: currentCoordinate.column + i,
          row: currentCoordinate.row + i));
      moves.add(SquareCoordinate(
          column: currentCoordinate.column - i,
          row: currentCoordinate.row - i));
      moves.add(SquareCoordinate(
          column: currentCoordinate.column + i,
          row: currentCoordinate.row - i));
      moves.add(SquareCoordinate(
          column: currentCoordinate.column - i,
          row: currentCoordinate.row + i));
    }
    return moves;
  }

  @override
  Identity get getIdentity => identity;

  @override
  bool get getIsSelected => isSelected;

  @override
  String get getName => name;

  @override
  String get imagePath => "assets/pieces/png/white_bishop.png";

  @override
  int get getWorth => 3;
}
