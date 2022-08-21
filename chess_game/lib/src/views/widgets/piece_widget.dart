import 'package:chess_game/src/models/models.dart';
import 'package:flutter/material.dart';

class PieceWidget extends StatelessWidget {
  const PieceWidget({
    Key? key,
    required this.piece,
    required this.height,
    required this.width,
  }) : super(key: key);
  final PieceStructure piece;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Draggable<PieceStructure>(
            data: piece,
            childWhenDragging: Container(),
            feedback: Image.asset(
              piece.imagePath,
              height: height + 10,
              width: width + 10,
            ),
            child: Image.asset(
              piece.imagePath,
              height: height,
              width: width,
            ),
            onDragStarted: () => print(piece.getCurrentCoordinate.getPostion()),
          )
       ;
  }
}