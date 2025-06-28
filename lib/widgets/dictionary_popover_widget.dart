import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class DictionaryPopoverWidget extends ConsumerWidget {
  final String gameId;
  final GameMode gameMode;
  const DictionaryPopoverWidget({
    super.key,
    required this.gameId,
    required this.gameMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameKey = "$gameId|${gameMode.name}";
    final keyboard = ref.read(keyboardProvider(gameKey).notifier);
    final provider = ref.read(gameProvider(gameKey).notifier);
    final scrollController = ref.watch(scrollProvider(gameKey));
    final selectedIdx = ref.watch(
      gameProvider(gameKey).select((s) => s.selectedIdx),
    );
    final cells = ref.watch(gameProvider(gameKey).select((s) => s.cells));
    final cell = cells[selectedIdx];
    final cellHeight = containerHeight + 3 * padding + 2 * decorationHeight;
    final yPosition =
        (cell.row + 1) * cellHeight +
        panelHeight -
        (2 * padding) +
        insetPadding -
        decorationHeight;
    int i = selectedIdx;
    while (i > 0 && cells[i].row == cell.row) {
      i--;
    }

    i = selectedIdx;
    while (!cells[i].isException && i >= 0) {
      i--;
    }
    int wordStart = i + 1;
    String word = "";
    String typed = "";
    for (int j = wordStart; !cells[j].isException; j++) {
      word += cells[j].plainText;
      typed += cells[j].text == "" ? "*" : cells[j].text;
    }
    final words = dictionary.map[getPatternKey(word)] ?? [];
    final newWords = [...words];
    for (String w in words) {
      for (int j = 0; j < typed.length; j++) {
        if (typed[j] != "*" && w[j].toUpperCase() != typed[j]) {
          newWords.remove(w);
        }
      }
    }
    int numExceptions = 0;
    i = selectedIdx;
    while (i >= 0 && cells[i].row == cell.row) {
      if (cells[i].isException) {
        numExceptions++;
      }
      i--;
    }
    final xPosition =
        (wordStart - (i == 0 ? i : i + 1) - numExceptions) *
            (containerWidth + padding) +
        (numExceptions) * (containerWidth) +
        insetPadding;

    return Positioned(
      top: yPosition - scrollController.offset,
      left: xPosition,
      child: Container(
        width: (containerWidth + padding) * word.length - padding,
        height: containerHeight * 1.25,
        color: Colors.blueAccent,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: newWords.map((word) {
                return SizedBox(
                  height: containerHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      provider.saveHistory();
                      var curWord = word.toUpperCase().split("");
                      if (gameMode == GameMode.assisted) {
                        curWord = curWord.toSet().toList();
                        debugPrint("hi");
                      }
                      provider.selectCell(wordStart);
                      for (int j = 0; j < word.length; j++) {
                        keyboard.pressKey("", false);
                        provider.incrementCell(1);
                      }
                      provider.selectCell(wordStart);
                      for (String letter in curWord) {
                        keyboard.pressKey(letter, false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        word,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
