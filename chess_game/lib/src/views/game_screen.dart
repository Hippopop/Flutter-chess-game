import 'package:chess_game/src/services/providers/game_provider/game_bloc.dart';
import 'package:chess_game/src/views/widgets/board_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    const fenString = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR";
    return Scaffold(
      body: BlocProvider(
        create: (context) => GameBloc()
          ..add(
            const InitializeBaseFenEvent(
              fenString: fenString,
            ),
          ),
        child: const Center(
          child: BoardFrame(),
        ),
      ),
    );
  }
}
