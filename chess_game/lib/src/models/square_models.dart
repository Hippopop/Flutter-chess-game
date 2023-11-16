import 'package:chess_game/src/global/constants/constants.dart';
import 'package:equatable/equatable.dart';

const List<String> charecters = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
];

class SquareCoordinate {
  final int column;
  final int row;

  SquareCoordinate({required this.column, required this.row});
  factory SquareCoordinate.fromPosition({required SquarePosition position}) {
    return SquareCoordinate(
      row: position.row,
      column: charecters.indexOf(position.column),
    );
  }

  SquarePosition getPostion() => SquarePosition.fromCoordinate(this);

  Identity getIdentityByCoord() =>
      (column + row).isOdd ? Identity.black : Identity.white;

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
      row: 8 - (coordinate.row),
      column: charecters[coordinate.column],
    );
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

class Square extends Equatable {
  SquareCoordinate _squareCoordinate;
SquareState _squareState = SquareState.none;

  Square._(this._squareCoordinate);

  factory Square.fromWidget({required int row, required int column}) {
    return Square._(SquareCoordinate(column: column, row: row));
  }

  SquareState get getCurrentState => _squareState;

  Identity get identity => _squareCoordinate.getIdentityByCoord();

  SquareCoordinate get getCoord => _squareCoordinate;

  int boxNumber() =>
      _squareCoordinate.column +
      _squareCoordinate.row +
      (_squareCoordinate.row * 7) +
      1;

  setState(SquareState state) {
    _squareState = state;
  }

  @override
  List<Object?> get props => [
        _squareCoordinate,
        _squareState,
      ];
}
