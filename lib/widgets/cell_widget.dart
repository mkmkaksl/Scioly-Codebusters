import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class CellWidget extends ConsumerWidget {
  final int index;
  final String gameId;

  const CellWidget({super.key, required this.index, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cells = ref.watch(gameProvider(gameId).select((s) => s.cells));
    //calculate colors
    var cellColor = Colors.white;
    if (cells[index].isSelected) {
      cellColor = Colors.orange;
    } else if (cells[index].isLit) {
      cellColor = Colors.yellow;
    }
    var textColor = Colors.black87;
    if (cells[index].isCorrect) {
      textColor = Colors.green;
    } else if (cells[index].isDuplicate) {
      textColor = Colors.red;
    }

    if (!cells[index].isException) {
      return Column(
        children: [
          SizedBox(
            width: containerWidth,
            height: decorationHeight,
            child: Center(
              child: Text(
                cells[index].cipher,
                style: AppTheme.decorationTextStyle,
              ),
            ),
          ),
          SizedBox(width: containerWidth, height: padding),
          GestureDetector(
            onTap: () =>
                ref.read(gameProvider(gameId).notifier).selectCell(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: cellColor,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  cells[index].text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: containerWidth, height: padding),
          SizedBox(
            width: containerWidth,
            height: decorationHeight,
            child: Center(
              child: Text(
                "${cells[index].count}",
                style: AppTheme.decorationTextStyle,
              ),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: Center(
          child: Text(cells[index].text, style: AppTheme.keyboardKeyTextStyle),
        ),
      );
    }
  }
}
