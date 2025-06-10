import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

//change width and replace boxes with padding
class AristocratGridWidget extends ConsumerWidget {
  final String gameId = "Aristocrat";
  const AristocratGridWidget({super.key});

  //double check splitting rows for hiphens, long words, last char = space, etc.
  //make sure data is clean like no double spaces, use spaces after punctuation.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cells = ref.watch(gameStateProvider(gameId).select((s) => s.cells));
    var maxLength = screenW * 0.9;
    List<List<Widget>> grid = [];
    List<Widget> row = [];
    List<Widget> word = [];
    var rowSize = 0.0;
    var wordSize = 0.0;
    void updateRow() {
      if (rowSize + wordSize > maxLength) {
        grid.add(row);
        grid.add([SizedBox(width: maxLength, height: padding)]);
        row = [...word];
        rowSize = wordSize;
      } else {
        row = [...row, ...word];
        rowSize += wordSize;
      }
    }

    for (int i = 0; i < cells.length; i++) {
      word.add(CellWidget(index: i, gameId: gameId));
      wordSize += containerWidth;
      if (!cells[i].isException) {
        word.add(SizedBox(width: padding, height: containerHeight));
        wordSize += padding;
      } else if (cells[i].text == " " || cells[i].text == "-") {
        updateRow();
        word = [];
        wordSize = 0.0;
      }
    }
    updateRow();
    grid.add(row);
    return Column(
      children: grid.map((rowWidgets) {
        return Row(children: rowWidgets);
      }).toList(),
    );
  }
}
