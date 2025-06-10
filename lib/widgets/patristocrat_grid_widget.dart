import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

//change width and replace boxes with padding
class PatristocratGridWidget extends ConsumerWidget {
  final String gameId = "Patristocrat";
  const PatristocratGridWidget({super.key});

  //double check splitting rows for hiphens, long words, last char = space, etc.
  //make sure data is clean like no double spaces, use spaces after punctuation.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cells = ref.watch(gameStateProvider(gameId).select((s) => s.cells));
    var maxLength = screenW * 0.8;
    List<List<Widget>> grid = [];
    List<Widget> row = [];
    var rowSize = 0.0;
    for (int i = 0; i < cells.length; i++) {
      if (rowSize > maxLength) {
        grid.add(row);
        row = [];
        rowSize = 0.0;
      }
      row.add(CellWidget(index: i, gameId: gameId));
      row.add(SizedBox(width: padding, height: containerHeight));
      rowSize += containerWidth + padding;
    }
    grid.add(row);
    return Column(
      children: grid.map((rowWidgets) {
        return Row(children: rowWidgets);
      }).toList(),
    );
  }
}
