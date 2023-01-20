import 'package:chess_game/src/models/square_models.dart';

import '../global/constants/constants.dart';

abstract class PieceStructure {
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
    onCoordUpdate();
  }

  void onCoordUpdate() {}

  void updateIdentity(Identity id) {
    identity = id;
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
  bool firstMove = true;
  @override
  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;
  @override
  List<SquareCoordinate> get getPossibleMoves {
    List<SquareCoordinate> moves = [];
    if (identity == Identity.black) {
      final rowMove = SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row + 1);
      moves.add(rowMove);
      if (firstMove) {
        final secondSquare = SquareCoordinate(
            column: currentCoordinate!.column, row: currentCoordinate!.row + 2);
        moves.add(secondSquare);
      }
      return moves;
    } else {
      final rowMove = SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row - 1);
      moves.add(rowMove);
      if (firstMove) {
        final secondSquare = SquareCoordinate(
            column: currentCoordinate!.column, row: currentCoordinate!.row - 2);
        moves.add(secondSquare);
      }
      return moves;
    }
  }

  @override
  void onCoordUpdate() {
    firstMove = false;
    super.onCoordUpdate();
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

class Knight extends PieceStructure {
  Knight(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

  String name = "knight";

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 2,
        row: currentCoordinate!.row + 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 2,
        row: currentCoordinate!.row - 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row + 2));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row + 2));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 2,
        row: currentCoordinate!.row + 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 2,
        row: currentCoordinate!.row - 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row - 2));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row - 2));
    return moves;
  }

  @override
  String get getName => name;
  @override
  String get imagePath => "assets/pieces/png/${identity.name}_$name.png";
  @override
  int get getWorth => 3;
}

class Queen extends PieceStructure {
  Queen(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

  String name = "queen";

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    for (int i = 1; i < 8; i++) {
      //Bishop
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
      //Rook
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
  int get getWorth => 9;
}

class King extends PieceStructure {
  King(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

/*   bool isSelected = false;

  @override
  SquareCoordinate? get getCurrentCoordinate => ownCoordinate ?? super.getCurrentCoordinate; */

  /* @override
  void updateIdentity(Identity newIdentity) {
    ownIdentity = newIdentity;
  } */

/*   @override
  bool get getIsSelected => isSelected;

  @override
  Identity get getIdentity => ownIdentity ?? super.getIdentity; */

  @override
  List<SquareCoordinate> get getPossibleMoves {
    final List<SquareCoordinate> moves = [];
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1, row: currentCoordinate!.row));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1, row: currentCoordinate!.row));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column, row: currentCoordinate!.row + 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column, row: currentCoordinate!.row - 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row + 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row - 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row - 1));
    moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row + 1));
    return moves;
  }

  @override
  String get imagePath => "assets/pieces/png/${identity.name}_$getName.png";
  @override
  String get getName => "king";
  @override
  int get getWorth => 55;
}
