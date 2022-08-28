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
    myState.setPiece(null);
  }

  @override
  State<SquareWidget> createState() => SquareWidgetState();

  // const Theme()of(context);
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
            : const Color.fromARGB(255, 200, 200, 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);
    return GestureDetector(
      onTap: () {},
      child: DragTarget<PieceStructure>(
        onAccept: (data) {
          setState(() {
            widget.myState.setPiece(data..updateCoord(widget.myState.getCoord));
            if (widget.myState.piece != null &&
                widget.myState.piece!.getIdentity != data.getIdentity) {
              widget.myState.setState(SquareState.kill);
            } else {
              widget.myState.setState(SquareState.none);
            }
          });
        },
        onMove: (details) {
          if (details.data.getPossibleMoves.contains(widget.myState.getCoord)) {
            setState(() {
              widget.myState.setState(SquareState.activity);
            });
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
