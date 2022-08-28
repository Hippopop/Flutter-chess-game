import 'package:chess_game/src/models/square_models.dart';

import '../global/constants/constants.dart';

abstract class PieceStructure {
  PieceStructure(SquareCoordinate coordinate, Identity identity);
  SquareCoordinate get getCurrentCoordinate;
  String get getName;
  Identity get getIdentity;
  bool get getIsSelected;
  List<SquareCoordinate> get getPossibleMoves;
  String get imagePath;
  int get getWorth;
  bool get status;
  void kill();
  void updateCoord(SquareCoordinate coordinate);
}

class Pawn extends PieceStructure {
  SquareCoordinate? currentCoordinate;
  Identity identity;
  bool isSelected = false;
  String name = "pawn";

  Pawn({required this.currentCoordinate, required this.identity}) : super(currentCoordinate!, identity);

  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final rowMove =  SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row + 1);
    return [
     rowMove
    ];
  }

  @override
  Identity get getIdentity => identity;

  @override
  bool get getIsSelected => isSelected;

  @override
  String get getName => name;

  @override
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";

  @override
  int get getWorth => 1;

  @override
  void kill() {
    currentCoordinate = null;
  }

  @override
  bool get status => currentCoordinate != null;

  @override
  void updateCoord(SquareCoordinate coordinate) {
    currentCoordinate = coordinate;
  }
}

class Bishop extends PieceStructure {
  SquareCoordinate? currentCoordinate;
  Identity identity;
  bool isSelected = false;
  String name = "bishop";

  Bishop({required this.currentCoordinate, required this.identity}) : super(currentCoordinate!, identity);

  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    for (int i = 1; i < 8; i++) {
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row + i));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row - i));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row - i));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row + i));
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
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";

  @override
  int get getWorth => 3;

  @override
  void kill() {
    currentCoordinate = null;
  }

  @override
  bool get status => currentCoordinate != null;

  @override
  void updateCoord(SquareCoordinate coordinate) {
    currentCoordinate = coordinate;
  }
}
class Rook extends PieceStructure {
  SquareCoordinate? currentCoordinate;
  Identity identity;
  bool isSelected = false;
  String name = "rook";

  Rook({required this.currentCoordinate, required this.identity}) : super(currentCoordinate!, identity);

  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    for (int i = 1; i < 8; i++) {
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column,
          row: currentCoordinate!.row - i));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column,
          row: currentCoordinate!.row + i));
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
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";

  @override
  int get getWorth => 3;

  @override
  void kill() {
    currentCoordinate = null;
  }

  @override
  bool get status => currentCoordinate != null;

  @override
  void updateCoord(SquareCoordinate coordinate) {
    currentCoordinate = coordinate;
  }
}



