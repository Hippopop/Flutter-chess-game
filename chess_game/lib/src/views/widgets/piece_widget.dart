import 'package:chess_game/src/models/models.dart';
import 'package:chess_game/src/models/piece_models.dart';
import 'package:chess_game/src/views/widgets/square_widget.dart';
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
    return GestureDetector(
      onTap: () {
        print(piece.identity.name);
        print(piece.currentCoordinate);
        print(piece.imagePath);
        
      },
      child: Draggable<PieceStructure>(
        data: piece,
        childWhenDragging: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.lightBlueAccent.withOpacity(0.3),
          ),
        ),
        feedback: Image.asset(
          piece.imagePath,
          height: height + 10,
          width: width + 10,
        ),
        onDragCompleted: () {
          context.findAncestorWidgetOfExactType<SquareWidget>()?.updateOnkill(); // TODO: Ship this method to the State management section.
          context.findAncestorStateOfType<SquareWidgetState>()?.setState(() {}); // TODO: Ship this method to the State management section.
        },
        child: Image.asset(
          piece.imagePath,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

