import 'package:chess_game/src/global/constants/constants.dart';
import 'package:chess_game/src/models/models.dart';
import 'package:chess_game/src/models/piece_models.dart';

const Map<String, int> charToNum = {
  "a": 0,
  "b": 1,
  "c": 2,
  "d": 3,
  "e": 4,
  "f": 5,
  "g": 6,
  "h": 7,
};

const Map<int, String> numToChar = {
  0: "a",
  1: "b",
  2: "c",
  3: "d",
  4: "e",
  5: "f",
  6: "g",
  7: "h",
};

typedef NewPiece = PieceStructure Function({required SquareCoordinate coord});

PieceStructure fenStructure(String char, SquareCoordinate coordinate) {
  assert(char.length == 1 || char.isNotEmpty, "⚠️ Invalid #fen code! ($char)");

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
/* 
Map<String, NewPiece> fenMap = {
  "r": ({required SquareCoordinate coord, required Identity identity}) =>
      Rook(coord, identity),
  "p": ({required SquareCoordinate coord, required Identity identity}) =>
      Pawn(coord, identity),
  "b": ({required SquareCoordinate coord, required Identity identity}) =>
      Bishop(coord, identity),
  "k": ({required SquareCoordinate coord, required Identity identity}) =>
      King(coord, identity),
  "q": ({required SquareCoordinate coord, required Identity identity}) =>
      Queen(coord, identity),
  "n": ({required SquareCoordinate coord, required Identity identity}) =>
      Knight(coord, identity),
};
 */