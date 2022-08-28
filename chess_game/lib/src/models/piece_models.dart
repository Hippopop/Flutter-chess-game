import 'package:chess_game/src/models/square_models.dart';

import '../global/constants/constants.dart';

class PieceStructure {
  PieceStructure._(this.currentCoordinate, this.identity);

  SquareCoordinate? currentCoordinate;
  bool isSelected = false;
  Identity identity;

  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;
  Identity get getIdentity => identity;
  bool get getIsSelected => isSelected;
  bool get status => currentCoordinate != null;

  void kill() {
    currentCoordinate = null;
  }

  void updateCoord(SquareCoordinate coordinate) {
    currentCoordinate = coordinate;
  }

  List<SquareCoordinate> get getPossibleMoves {
    throw UnimplementedError();
  }

  String get getName => throw UnimplementedError();

  String get imagePath => throw UnimplementedError();

  int get getWorth => throw UnimplementedError();
}

class Pawn extends PieceStructure {
  Pawn(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

  String name = "pawn";

  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;
  @override
  List<SquareCoordinate> get getPossibleMoves {
    final rowMove = SquareCoordinate(
        column: currentCoordinate!.column, row: currentCoordinate!.row + 1);
    return [rowMove];
  }

  @override
  String get getName => name;
  @override
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";
  @override
  int get getWorth => 1;
}

class Bishop extends PieceStructure {
  Bishop(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

  String name = "bishop";

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
  String get getName => name;
  @override
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";
  @override
  int get getWorth => 3;

  @override
  void kill() {
    currentCoordinate = null;
  }
}

class Rook extends PieceStructure {
  Rook(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

  String name = "rook";

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    for (int i = 1; i < 8; i++) {
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i, row: currentCoordinate!.row));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i, row: currentCoordinate!.row));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row - i));
      moves.add(SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row + i));
    }
    return moves;
  }

  @override
  String get getName => name;
  @override
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";
  @override
  int get getWorth => 3;
}
