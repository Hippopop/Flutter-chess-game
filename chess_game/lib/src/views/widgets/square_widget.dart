import 'package:chess_game/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
  _getColor() {
    switch (widget.myState.getCurrentState) {
      case SquareState.activity:
        return Colors.green;
      case SquareState.kill:
        return Colors.red;
      default:
        return widget.myState.getIdentity() == Identity.black
            ? const Color.fromARGB(255, 190, 140, 87)
            : const Color.fromARGB(216, 255, 255, 255);
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        print(widget.myState.boxNumber());
      },
      child: DragTarget<PieceStructure>(
        onAccept: (data) {
          if (widget.myState.piece != null &&
              widget.myState.piece!.identity.name != data.identity.name) {
            widget.myState.setState(SquareState.kill);
          } else {
            widget.myState.setState(SquareState.none);
          }
          widget.myState.setPiece(data..updateCoord(widget.myState.getCoord));
          setState(() {});
        },
        onMove: (details) {
          if (details.data.getPossibleMoves.contains(widget.myState.getCoord)) {
            if (widget.myState.piece != null &&
                widget.myState.piece!.identity != details.data.identity) {
              setState(() {
                widget.myState.setState(SquareState.kill);
              });
            } else {
              setState(() {
                widget.myState.setState(SquareState.activity);
              });
            }
          }
        },
        onLeave: (data) {
          setState(() {
            setState(() {
              widget.myState.setState(SquareState.none);
            });
          });
        },
        onWillAccept: (data) {
          return data!.getPossibleMoves.contains(widget.myState.getCoord);
        },
        builder: (context, candidateData, rejectedData) => Card(
          color: _getColor(),
          margin: EdgeInsets.zero,
          elevation: 0,
          child: widget.myState.containsPiece()
              ? LayoutBuilder(builder: (context, constraints) {
                  return PieceWidget(
                      piece: widget.myState.piece!,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth);
                })
              : Container(),
        ),
      ),
    );
  }
}
