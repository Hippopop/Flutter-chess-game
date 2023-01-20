import 'package:bloc/bloc.dart';
import 'package:chess_game/src/models/piece_models.dart';
import 'package:equatable/equatable.dart';

import 'package:chess_game/src/global/constants/constants.dart';
import 'package:chess_game/src/models/models.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameEvent>((event, emit) {});
  }

  GameBloc.operate({int x = 8, int y = 8, String? fen})
      : super(GameInitial(x: x, y: y, fen: fen)) {
    on<GameEvent>((event, emit) => null);
  }
}
