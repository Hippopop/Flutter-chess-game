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
  @override
  State<SquareWidget> createState() => _SquareWidgetState();
}

class _SquareWidgetState extends State<SquareWidget> {
  _getColor() {
    switch (widget.myState.getCurrentState) {
      case SquareState.activity:
        return Colors.green;
      case SquareState.kill:
        return Colors.red;
      default:
        return widget.myState.getIdentity() == Identity.black
            ? Colors.black
            : Colors.white;
    }
  }

/*   Widget? _getWidget() {
    switch (widget.myState.getCurrentState) {
      case SquareState.empty:
        return Container();
      default:
        return LayoutBuilder(builder: (context, constraints) {
          return PieceWidget(
              piece: widget.myState.piece!,
              height: constraints.maxHeight,
              width: constraints.maxWidth);
        });
    }
  } */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.myState.getCoord.getPostion().toString());
        print("Box = ${widget.myState.boxNumber()}");

/*         String x = "abxysiwjf";
        final a = x.characters;
        print(a);
        a.forEach((element) {
          print("$element\n");
        }); */
      },
      child: DragTarget<PieceStructure>(
        onAccept: (data) => print("accepted!"),
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
        builder: (context, candidateData, rejectedData) => Card(
          color: _getColor(),
          margin: EdgeInsets.zero,
          elevation: 0,
          child: widget.myState.containsPiece()?
              LayoutBuilder(builder: (context, constraints) {
                  return PieceWidget(
                      piece: widget.myState.piece!,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth);
                }) : Container(),
        ),
      ),
    );
  }
}
