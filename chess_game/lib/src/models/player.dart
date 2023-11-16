import 'package:chess_game/src/global/constants/constants.dart';
import 'package:chess_game/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Player extends Equatable {
  Player({
    String? id,
    this.onCheck = false,
    this.selectedPiece,
    required this.playerIdentity,
    required List<PieceStructure> pieces,
  })  : _pieces = pieces,
        _id = id ?? const Uuid().v4();

  final String _id;
  final bool onCheck;
  final Identity playerIdentity;
  final PieceStructure? selectedPiece;
  final List<PieceStructure> _pieces;
  List<PieceStructure> get activePieces =>
      _pieces.where((element) => element.currentCoordinate != null).toList();
  List<PieceStructure> get deadPieces =>
      _pieces.where((element) => element.currentCoordinate == null).toList();

  SquareCoordinate get kingCoord => _pieces
      .where(
        (element) => element.getName == 'king',
      )
      .first
      .getCurrentCoordinate;

  Player copyWith(
          {PieceStructure? selected,
          List<PieceStructure>? pieces,
          bool? check}) =>
      Player(
        id: _id,
        onCheck: check ?? onCheck,
        pieces: pieces ?? _pieces,
        playerIdentity: playerIdentity,
        selectedPiece: selected ?? selectedPiece,
      );

  @override
  String toString() =>
      "Player: $_id {identity : ${playerIdentity.name}, selectedPiece: ${selectedPiece ?? "none"}}";

  @override
  List<Object?> get props => [_id, playerIdentity];
}

extension RotatePlayerTurn on List<Player> {
  Player rotate(Player currentPlayer) {
    assert(contains(currentPlayer), "#OUTSIDER ERROR");
    if (currentPlayer == last) return first;
    int index = indexOf(currentPlayer);
    final nextPlayer = this[index + 1];
    return nextPlayer;
  }
}
