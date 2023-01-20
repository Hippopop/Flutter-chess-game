part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState({List<Square>? custom})
      : squares = custom ?? const <Square>[];
  final List<Square> squares;
  @override
  List<Object> get props => [squares];
}

class GameInitial extends GameState {
  GameInitial({int? x, int? y, String? fen}) : initialSquares = [] {
    List.generate(
      x ?? 8,
      (column) => List.generate(
        y ?? 8,
        (row) {
          Square create = Square.fromWidget(column: column, row: row);
          initialSquares.add(create);
        },
      ),
    );
    if (fen != null) {
      fenConverter(fen);
    }
  }

  final List<Square> initialSquares;

  @override
  List<Square> get squares => initialSquares;

  fenConverter(String fen) {
    final List<String> fenChars = fen.replaceAll("/", "").split("");
    int index = 1;
    for (var char in fenChars) {
      if (int.tryParse(char) != null) {
        index += int.parse(char);
      } else {
        Square neededSquare =
            initialSquares.where((item) => item.boxNumber() == index).first;

        PieceStructure correspondingPiece =
            fenStructure(char, neededSquare.getCoord);
        neededSquare.setPiece(correspondingPiece);

        index++;
      }
    }
  }

  PieceStructure fenStructure(String char, SquareCoordinate coordinate) {
    assert(
      char.length == 1 || char.isNotEmpty,
      "⚠️ Invalid #fen code! ($char)",
    );

    switch (char) {
      case "P":
        return Pawn(coordinate, Identity.white);
      case "p":
        return Pawn(coordinate, Identity.black);
      case "R":
        return Rook(coordinate, Identity.white);
      case "r":
        return Rook(coordinate, Identity.black);
      case "N":
        return Knight(coordinate, Identity.white);
      case "n":
        return Knight(coordinate, Identity.black);
      case "B":
        return Bishop(coordinate, Identity.white);
      case "b":
        return Bishop(coordinate, Identity.black);
      case "Q":
        return Queen(coordinate, Identity.white);
      case "q":
        return Queen(coordinate, Identity.black);
      case "K":
        return King(coordinate, Identity.white);
      case "k":
        return King(coordinate, Identity.black);
      default:
        throw "⚠️ Invalid #fen code! ($char)";
    }
  }
}
