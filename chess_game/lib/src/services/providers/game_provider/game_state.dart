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

        PieceStructure correspondingPiece = fenStructure(char, neededSquare.getCoord);
        neededSquare.setPiece(correspondingPiece);
        // print(char);
/*         if (char == char.toUpperCase()) {
          print("#");
          PieceStructure? whitePiece = fenMap[char.toLowerCase()]!(
              coord: neededSquare.getCoord, identity: Identity.white);
          neededSquare.setPiece(whitePiece);
        } else {
          // print("*");

          PieceStructure? blackPiece = fenMap[char]!(
              coord: neededSquare.getCoord, identity: Identity.black);
          neededSquare.setPiece(blackPiece);
        } */
        index++;
      }
    }
  }
}
