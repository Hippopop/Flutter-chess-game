import 'package:chess_game/src/models/square_models.dart';
import 'package:equatable/equatable.dart';

import '../global/constants/constants.dart';

abstract class PieceStructure extends Equatable {
  PieceStructure._(this.currentCoordinate, this.identity);

  SquareCoordinate? currentCoordinate;
  bool isSelected = false;
  Identity identity;

  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;
  Identity get getIdentity => identity;
  bool get getIsSelected => isSelected;
  bool get status => currentCoordinate != null;

  void die() {
    currentCoordinate = null;
  }

  int? boxNumber() {
    if (currentCoordinate == null) return null;
    return currentCoordinate!.column +
        currentCoordinate!.row +
        (currentCoordinate!.row * 7) +
        1;
  }

  bool canKill(PieceStructure? acquiredPiece) {
    if (acquiredPiece == null) return false;
    bool hasMove = getPossibleMoves.contains(acquiredPiece.currentCoordinate) ||
        getName == "pawn";
    bool differentColor = identity != acquiredPiece.getIdentity;
    bool notKing = acquiredPiece.getName != "king";
    return differentColor && notKing && hasMove;
  }

  void updateCoord(SquareCoordinate coordinate) {
    currentCoordinate = coordinate;
    onCoordUpdate();
  }

  void updateIdentity(Identity id) {
    identity = id;
  }

  void onCoordUpdate() {}

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
  bool canKill(PieceStructure? acquiredPiece) {
    if (acquiredPiece == null) return false;
    if (identity == Identity.white) {
      List<SquareCoordinate> possibleKillCoord = [
        SquareCoordinate(
            column: currentCoordinate!.column - 1,
            row: currentCoordinate!.row - 1),
        SquareCoordinate(
            column: currentCoordinate!.column + 1,
            row: currentCoordinate!.row - 1),
      ];
      return (possibleKillCoord.contains(acquiredPiece.currentCoordinate) &&
          super.canKill(acquiredPiece));
    } else {
      List<SquareCoordinate> possibleKillCoord = [
        SquareCoordinate(
            column: currentCoordinate!.column - 1,
            row: currentCoordinate!.row + 1),
        SquareCoordinate(
            column: currentCoordinate!.column + 1,
            row: currentCoordinate!.row + 1),
      ];
      return (possibleKillCoord.contains(acquiredPiece.currentCoordinate) &&
          super.canKill(acquiredPiece));
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

  @override
  List<Object?> get props => [currentCoordinate, getPossibleMoves];
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
  List<Object?> get props => [currentCoordinate, getPossibleMoves];
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
  @override
  List<Object?> get props => [currentCoordinate, getPossibleMoves];
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
  @override
  List<Object?> get props => [currentCoordinate, getPossibleMoves];
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
  @override
  List<Object?> get props => [currentCoordinate, getPossibleMoves];
}

class King extends PieceStructure {
  King(SquareCoordinate currentCoordinate, Identity identity)
      : super._(currentCoordinate, identity);

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
  @override
  List<Object?> get props => [currentCoordinate, getPossibleMoves];
}
