import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/keyboard_provider.dart';

class KeyboardWidget extends ConsumerWidget {
  final String gameId;
  const KeyboardWidget({super.key, required this.gameId});

  static const List<List<String>> rows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  static const double spacing = 4;
  static const double undoButtonHeight = 50;
  static const double horizontalBuffer = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressedKeys = ref.watch(
      keyboardProvider(gameId).select((s) => s.pressedKeys),
    );
    final screenWidth = MediaQuery.of(context).size.width;
    final safeWidth = screenWidth - horizontalBuffer;
    final maxKeysInRow = 10;
    final keyWidth = (safeWidth - (maxKeysInRow - 1) * spacing) / maxKeysInRow;

    Widget buildKey(String key) {
      final isPressed = pressedKeys.contains(key);
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
                ref.read(keyboardProvider(gameId).notifier).pressKey(key),
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
        color: Colors.black12,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ...rows.map(buildRow),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: undoButtonHeight,
              child: ElevatedButton.icon(
                onPressed: () =>
                    ref.read(keyboardProvider(gameId).notifier).undo(),
                icon: const Icon(Icons.undo),
                label: const Text("Undo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
