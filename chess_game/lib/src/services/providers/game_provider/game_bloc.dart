import 'dart:developer';

import 'package:chess_game/src/global/constants/constants.dart';
import 'package:chess_game/src/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameLoadState()) {
    on<Move>(_move);
    on<SelectPiece>(_selectPiece);
    on<InitializeBaseFenEvent>(_initializeBaseFen);
    on<PieceHoverOnSquare>(_hoverOnSquare);
  }

  _selectPiece(SelectPiece event, Emitter<GameState> emit) {
    log(state.players.toString());
    int index = state.players.indexOf(state.players
        .where(
            (element) => element.playerIdentity == event.selectedPiece.identity)
        .first);
    if (state.players[index].selectedPiece == event.selectedPiece) {
      state.players[index] = state.players[index].copyWith(
        selected: null,
      );
    } else {
      state.players[index] = state.players[index].copyWith(
        selected: event.selectedPiece,
      );
    }
  }

  _hoverOnSquare(PieceHoverOnSquare event, Emitter<GameState> emit) {
    if (event.triggredPiece.getPossibleMoves
            .contains(event.onSquare.getCoord) ||
        event.triggredPiece.canKill(event.onSquare.piece)) {
      if (event.onSquare.piece == null) {
        event.onSquare.setState(SquareState.activity);
      } else if (event.triggredPiece.canKill(event.onSquare.piece)) {
        event.onSquare.setState(SquareState.kill);
      }
    }
    emit(state);
  }

  _move(Move event, Emitter<GameState> emit) {
    if (event.targettedSquare.piece != null &&
        event.targettedSquare.piece!.identity.name !=
            event.piece.identity.name) {
      event.targettedSquare.setState(SquareState.kill);
    } else {
      event.targettedSquare.setState(SquareState.none);
    }
    event.targettedSquare
        .setPiece(event.piece..updateCoord(event.targettedSquare.getCoord));

    emit(state.copyWith(
      currentTurn: state.players.rotate(state.turn),
    ));
  }

  _initializeBaseFen(InitializeBaseFenEvent event, Emitter<GameState> emit) {
    List<Square> initialSquares = [];
    List<PieceStructure> blackPieces = [];
    List<PieceStructure> whitePieces = [];
    SquareCoordinate whiteKingLocation;
    SquareCoordinate blackKingLocation;
    final List<String> fenChars = event.fenString.replaceAll("/", "").split("");
    int index = 1;

    List.generate(
      event.xAxis,
      (column) => List.generate(
        event.yAxis,
        (row) {
          Square create = Square.fromWidget(column: column, row: row);
          initialSquares.add(create);
        },
      ),
    );

    for (var char in fenChars) {
      if (int.tryParse(char) != null) {
        index += int.parse(char);
      } else {
        Square neededSquare =
            initialSquares.where((item) => item.boxNumber() == index).first;

        PieceStructure correspondingPiece =
            _fenStructure(char, neededSquare.getCoord);

        if (correspondingPiece.identity == Identity.white) {
          if (correspondingPiece.getName == 'king') {
            whiteKingLocation = neededSquare.getCoord;
            print(whiteKingLocation);
          }
          whitePieces.add(correspondingPiece);
          neededSquare.setPiece(whitePieces.last);
        } else {
          if (correspondingPiece.getName == 'king') {
            blackKingLocation = neededSquare.getCoord;
            print(blackKingLocation);
          }
          blackPieces.add(correspondingPiece);
          neededSquare.setPiece(blackPieces.last);
        }

        index++;
      }
    }
    final players = [
      Player(playerIdentity: Identity.white, pieces: whitePieces),
      Player(playerIdentity: Identity.black, pieces: blackPieces),
    ];
    emit(BaseGameState(
        currentTurn: players.first, squares: initialSquares, players: players));
  }
}

PieceStructure _fenStructure(String char, SquareCoordinate coordinate) {
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
      throw "⚠️ Unknown #fen code! ($char)";
  }
}
