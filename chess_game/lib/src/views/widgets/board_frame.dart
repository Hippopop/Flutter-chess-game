import 'package:chess_game/src/services/providers/game_provider/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'square_widget.dart';

class BoardFrame extends StatelessWidget {
  const BoardFrame({Key? key, this.xCount = 8, this.yCount = 8})
      : super(key: key);
  final int xCount;
  final int yCount;

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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                color: Colors.grey.shade700,
                width: 5,
              ),
            ),
            child: BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return LayoutBuilder(builder: (context, constrains) {
                        print(state.squares[0].boxNumber());
                        print(state.squares[0].piece?.identity);

                  return SizedBox.square(
                    dimension: _getBoardSize(
                        constrains.maxHeight, constrains.maxWidth),
                    child: GridView.builder(
                      itemCount: state.squares.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: xCount),
                      itemBuilder: (context, index) {
                        // print(state.squares[index].boxNumber());
                        // print(state.squares[index].piece?.getIdentity);
                         return SquareWidget(
                        myState: state.squares[index],
                      );}
                    ),
                  );
                });
              },
            ),
          ),
        );
      }),
    ));
  }

  double _getBoardSize(double height, double width) =>
      height < width ? height : width;
}
