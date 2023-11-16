import 'package:chess_game/src/models/square_models.dart';
import 'package:equatable/equatable.dart';

import '../global/constants/constants.dart';

typedef ValidityCallback = PieceStructure Function(SquareCoordinate targetSquare);

abstract class PieceStructure extends Equatable {
  PieceStructure._(this.currentCoordinate, this.identity);

  SquareCoordinate? currentCoordinate;
  bool isSelected = false;
  Identity identity;

  SquareCoordinate get getCurrentCoordinate => currentCoordinate!;
  Identity get getIdentity => identity;
  bool get getIsSelected => isSelected;
  bool get status => currentCoordinate != null;

  calculateMoves(ValidityCallback? validate) {}

  void die() {
    currentCoordinate = null;
  }

  bool identityMatch(PieceStructure other) {
    return identity == other.identity;
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

  List<SquareCoordinate> _moves = [];

  @override
  List<SquareCoordinate> get getPossibleMoves => _moves;

  @override
  calculateMoves(ValidityCallback? validate) {
    _moves.clear();
    // List<SquareCoordinate> moves = [];
    if (identity == Identity.black) {
      final rowMove = SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row + 1);
      _moves.add(rowMove);
      if (firstMove) {
        final secondSquare = SquareCoordinate(
            column: currentCoordinate!.column, row: currentCoordinate!.row + 2);
        _moves.add(secondSquare);
      }
      // return _moves;
    } else {
      final rowMove = SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row - 1);
      _moves.add(rowMove);
      if (firstMove) {
        final secondSquare = SquareCoordinate(
            column: currentCoordinate!.column, row: currentCoordinate!.row - 2);
        _moves.add(secondSquare);
      }
      // return moves;
    }

    return super.calculateMoves(validate);
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

  final List<SquareCoordinate> _moves = [];

  @override
  List<SquareCoordinate> get getPossibleMoves => _moves;

  @override
  calculateMoves(ValidityCallback? validate) {
    _moves.clear();
    // final List<SquareCoordinate> _moves = [];
    for (int i = 1; i < 8; i++) {
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row + i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row - i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row - i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row + i));
    }
    // return moves;
    return super.calculateMoves(validate);
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

  final List<SquareCoordinate> _moves = [];

  @override
  List<SquareCoordinate> get getPossibleMoves => _moves;

  @override
  calculateMoves(ValidityCallback? validate) {
    _moves.clear();
    // final List<SquareCoordinate> _moves = [];
    for (int i = 1; i < 8; i++) {
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i, row: currentCoordinate!.row));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i, row: currentCoordinate!.row));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row - i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row + i));
    }
    // return moves;
    return super.calculateMoves(validate);
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

  final List<SquareCoordinate> _moves = [];

  @override
  List<SquareCoordinate> get getPossibleMoves => _moves;

  @override
  calculateMoves(ValidityCallback? validate) {
    _moves.clear();
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 2,
        row: currentCoordinate!.row + 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 2,
        row: currentCoordinate!.row - 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row + 2));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row + 2));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 2,
        row: currentCoordinate!.row + 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 2,
        row: currentCoordinate!.row - 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row - 2));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row - 2));
    return super.calculateMoves(validate);
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

  final List<SquareCoordinate> _moves = [];

  @override
  List<SquareCoordinate> get getPossibleMoves => _moves;

  @override
  calculateMoves(ValidityCallback? validate) {
    _moves.clear();
    for (int i = 1; i < 8; i++) {
      //Bishop
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row + i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row - i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i,
          row: currentCoordinate!.row - i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i,
          row: currentCoordinate!.row + i));
      //Rook
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column + i, row: currentCoordinate!.row));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column - i, row: currentCoordinate!.row));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row - i));
      _moves.add(SquareCoordinate(
          column: currentCoordinate!.column, row: currentCoordinate!.row + i));
    }
    return super.calculateMoves(validate);
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

  final List<SquareCoordinate> _moves = [];

  @override
  List<SquareCoordinate> get getPossibleMoves => _moves;

  @override
  calculateMoves(ValidityCallback? validate) {
    _moves.clear();
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1, row: currentCoordinate!.row));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1, row: currentCoordinate!.row));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column, row: currentCoordinate!.row + 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column, row: currentCoordinate!.row - 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row + 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row - 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column + 1,
        row: currentCoordinate!.row - 1));
    _moves.add(SquareCoordinate(
        column: currentCoordinate!.column - 1,
        row: currentCoordinate!.row + 1));
    return super.calculateMoves(validate);
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
