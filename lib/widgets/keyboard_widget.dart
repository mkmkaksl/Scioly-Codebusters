import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class KeyboardWidget extends ConsumerWidget {
  final String gameId;
  final Language language;
  const KeyboardWidget({
    super.key,
    required this.gameId,
    required this.language,
  });

  static List<List<String>> rows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (language == Language.spanish && rows[2].length == 7) {
      rows[2].insert(6, 'Ñ');
    }
    final pressedKeys = ref.watch(
      keyboardProvider(gameId).select((s) => s.pressedKeys),
    );

    Widget buildKey(String key) {
      final isPressed = pressedKeys.containsKey(key);
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: spacing / 2,
          vertical: spacing / 2,
        ),
        child: SizedBox(
          width: keyWidth,
          height: double.infinity,
          child: ElevatedButton(
            onPressed: () =>
                ref.read(keyboardProvider(gameId).notifier).pressKey(key, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPressed ? Colors.grey : null,
              padding: EdgeInsets.zero,
            ),
            child: Text(key, style: const TextStyle(fontSize: 18)),
          ),
        ),
      );
    }

    Widget buildRow(List<String> keys) => Expanded(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: keys.map(buildKey).toList(),
        ),
      ),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Container(
        color: const Color.fromARGB(255, 200, 200, 200),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ...rows.map(buildRow),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: undoButtonHeight,
                    child: ElevatedButton(
                      onPressed: () => ref
                          .read(gameProvider(gameId).notifier)
                          .incrementCell(-1),
                      child: const Text("<"),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: undoButtonHeight,
                    child: ElevatedButton(
                      onPressed: () => ref
                          .read(keyboardProvider(gameId).notifier)
                          .resetPuzzle(),
                      child: Text("Reset"),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: undoButtonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () => ref
                          .read(keyboardProvider(gameId).notifier)
                          .pressKey("", true),
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete"),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: undoButtonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          ref.read(keyboardProvider(gameId).notifier).undo(),
                      icon: const Icon(Icons.undo),
                      label: const Text("Undo"),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: undoButtonHeight,
                    child: ElevatedButton(
                      onPressed: () => ref
                          .read(gameProvider(gameId).notifier)
                          .incrementCell(1),
                      child: const Text(">"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
