part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  List<Square> get squares;
  List<PieceStructure> get pieces;
  List<Player> get players;

  Player get turn;
  GameState copyWith({
    Player? currentTurn,
    List<Square>? squares,
    List<Player>? playersList,
  }) {
    return this;
  }

  @override
  List<Object> get props => [squares];
}

@immutable
class GameLoadState extends GameState {
  @override
  List<Square> get squares => [];

  @override
  Player get turn => throw UnimplementedError();

  @override
  List<Player> get players => [];

  @override
  List<PieceStructure> get pieces => [];
}

@immutable
class BaseGameState extends GameState {
  final Player currentTurn;
  final List<Square> _squares;
  final List<Player> _players;
  BaseGameState({
    required this.currentTurn,
    required List<Square> squares,
    required List<Player> players,
  })  : _squares = squares,
        _players = players;

  @override
  List<Square> get squares => _squares;

  @override
  Player get turn => currentTurn;

  @override
  List<Player> get players => _players;

  @override
  BaseGameState copyWith({
    Player? currentTurn,
    List<Square>? squares,
    List<Player>? playersList,
  }) {
    return BaseGameState(
      currentTurn: currentTurn ?? this.currentTurn,
      squares: squares ?? this.squares,
      players: playersList ?? players,
    );
  }

  @override
  List<PieceStructure> get pieces => [for (Player x in players) ...x.pieces];

  @override
  List<Object> get props => [currentTurn, squares];

  @override
  String toString() =>
      'BaseGameState(currentTurn: $currentTurn, Players : $players)';
}
