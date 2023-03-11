import 'package:chess_game/src/services/providers/game_provider/game_bloc.dart';
import 'package:chess_game/src/views/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/constants/constants.dart';
import '../../models/models.dart';

class SquareWidget extends StatefulWidget {
  const SquareWidget({
    Key? key,
    required this.myState,
  }) : super(key: key);

  final Square myState;
  updateOnkill() {
    myState.removePiece();
  }

  @override
  State<SquareWidget> createState() => SquareWidgetState();
}

class SquareWidgetState extends State<SquareWidget> {
  late GameBloc gameBloc;
  @override
  void initState() {
    super.initState();
    gameBloc = BlocProvider.of<GameBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print(widget.myState.boxNumber());
        }
      },
      child: DragTarget<PieceStructure>(
        onAccept: (data) => gameBloc.add(Move(
          piece: data,
          targettedSquare: widget.myState,
        )),
        onMove: (details) => gameBloc.add(PieceHoverOnSquare(
          onSquare: widget.myState,
          triggredPiece: details.data,
        )),
        onLeave: (data) {
          setState(() {
            setState(() {
              widget.myState.setState(SquareState.none);
            });
          });
        },
        onWillAccept: (data) {
          if (widget.myState.piece == null) {
            return data!.getPossibleMoves.contains(widget.myState.getCoord);
          } else {
            return (data!.getName == "pawn")
                ? data.canKill(widget.myState.piece)
                : data.getPossibleMoves.contains(widget.myState.getCoord) &&
                    data.canKill(widget.myState.piece);
          }
        },
        builder: (context, candidateData, rejectedData) => Card(
          color: widget.myState.identity == Identity.black
              ? const Color.fromARGB(255, 190, 140, 87)
              : const Color.fromARGB(216, 255, 255, 255),
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Stack(
            children: [
              SquareStateWidget(state: widget.myState.getCurrentState),
              if (widget.myState.containsPiece())
                LayoutBuilder(builder: (context, constraints) {
                  return PieceWidget(
                    piece: widget.myState.piece!,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }


}

class SquareStateWidget extends StatelessWidget {
  const SquareStateWidget({super.key, required this.state});
final SquareState state;
  @override
  Widget build(BuildContext context) {
    return Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getColor(),
                  ),
                );
  }

    _getColor() {
    switch (state) {
      case SquareState.activity:
        return Colors.green.withOpacity(0.3);
      case SquareState.kill:
        return Colors.red.withOpacity(0.5);
      default:
        return Colors.transparent;
    }
  }
}