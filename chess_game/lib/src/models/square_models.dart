import 'package:chess_game/src/global/constants/constants.dart';
import 'package:chess_game/src/models/piece_models.dart';

class SquareCoordinate {
  final int column;
  final int row;

  SquareCoordinate({required this.column, required this.row});
  factory SquareCoordinate.fromPosition(String x, int y) {
    return SquareCoordinate(
      row: y,
      column: charToNum[x] ?? -1,
    );
  }

  SquarePosition getPostion() => SquarePosition.fromCoordinate(this);

  Identity getIdentity() =>
      (column + row).isOdd ? Identity.white : Identity.black;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SquareCoordinate &&
        other.column == column &&
        other.row == row;
  }

  @override
  int get hashCode => column.hashCode ^ row.hashCode;

  @override
  String toString() => '(column: $column/ row: $row)';
}

class SquarePosition {
  int row;
  String column;
  SquarePosition({required this.row, required this.column});

  factory SquarePosition.fromCoordinate(SquareCoordinate coordinate) {
    return SquarePosition(
        row: (coordinate.row + 1),
        column: numToChar[coordinate.column] ?? "error");
  }

  @override
  String toString() => '$column$row';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SquarePosition &&
        other.row == row &&
        other.column == column;
  }

  @override
  int get hashCode => row.hashCode ^ column.hashCode;
}

class Square {
  SquareCoordinate _squareCoordinate;
  PieceStructure? _piece;
  SquareState _squareState = SquareState.none;

  Square._(this._squareCoordinate,  this._piece);

  factory Square.fromWidget(
      {required int row, required int column, PieceStructure? piece}) {
    return Square._(SquareCoordinate(column: column, row: row),
        /* (piece == null) ? SquareState.empty : SquareState.regular, */ piece);
  }

  SquareState get getCurrentState => _squareState;

  Identity getIdentity() => _squareCoordinate.getIdentity();

  PieceStructure? get piece => _piece;

  SquareCoordinate get getCoord => _squareCoordinate;

  int boxNumber() =>
      _squareCoordinate.column +
      _squareCoordinate.row +
      (_squareCoordinate.row * 7);

  setState(SquareState state) {
    _squareState = state;
  }

  setPiece(PieceStructure? piece) {
    _piece = piece;
  }

  bool containsPiece() => _piece != null;
}
