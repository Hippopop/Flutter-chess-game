import 'dart:math' as math;

import 'package:chess_game/src/global/constants/constants.dart';
import 'package:chess_game/src/models/piece_models.dart';
import 'package:flutter/material.dart';

import '../../models/square_models.dart';
import 'square_widget.dart';

class BoardFrame extends StatefulWidget {
  const BoardFrame({Key? key, this.xCount = 8, this.yCount = 8})
      : super(key: key);
  final int xCount;
  final int yCount;

  @override
  State<BoardFrame> createState() => _BoardFrameState();
}

class _BoardFrameState extends State<BoardFrame> {
  List<Square> x = [];

  createGrid() {
    List.generate(
      widget.yCount,
      (column) => List.generate(
        widget.xCount,
        (row) {
          Square create = Square.fromWidget(column: column, row: row);
          if (create.boxNumber() == 31 || create.boxNumber() == 32) {
            create.setPiece(Pawn(
                 SquareCoordinate(column: column, row: row), Identity.black));
            x.add(create);
          } else if (create.boxNumber() == 33 || create.boxNumber() == 35) {
            create.setPiece(Bishop(
                SquareCoordinate(column: column, row: row), Identity.white));
            x.add(create);
          } else if (create.boxNumber() > 30 && create.boxNumber() < 52) {
            x.add(create);
          } else if (create.boxNumber() > 15 && create.boxNumber() < 48) {
            create.setPiece(Queen(SquareCoordinate(column: column, row: row), Identity.white));
            x.add(create);
          } else {
            create.setPiece(
              Rook(
               SquareCoordinate(column: column, row: row),
               Identity.black,
              ),
            );
            x.add(create);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: SafeArea(
      child: LayoutBuilder(builder: (context, outerConstrains) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: _getBoardSize(
                outerConstrains.maxHeight, outerConstrains.maxWidth),
            maxWidth: _getBoardSize(
                outerConstrains.maxHeight, outerConstrains.maxWidth),
          ),
          child: Transform.rotate(
            angle: -math.pi / 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 5,
                ),
              ),
              child: LayoutBuilder(builder: (context, constrains) {
                return SizedBox.square(
                  dimension:
                      _getBoardSize(constrains.maxHeight, constrains.maxWidth),
                  child: GridView.builder(
                    itemCount: x.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.xCount),
                    itemBuilder: (context, index) => Transform.rotate(
                      angle: math.pi / 2,
                      child: SquareWidget(
                        myState: x[index],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
    ));
  }

  double _getBoardSize(double height, double width) =>
      height < width ? height : width;
}
