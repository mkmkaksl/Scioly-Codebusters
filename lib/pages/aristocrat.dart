import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class Aristocrat extends ConsumerWidget {
  final String gameId = "Aristocrat";

  const Aristocrat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gameStateProvider(gameId).notifier);
    final GameMode gameMode = ref.watch(
      gameStateProvider(gameId).select((s) => s.gameMode),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Aristocrat")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AristocratGridWidget(),
                  ElevatedButton(
                    onPressed: () {
                      provider.buildAristocrat(gameMode);
                    },
                    child: Text("New Quote"),
                  ),
                  ElevatedButton(
                    onPressed: () => provider.markCorrect(),
                    child: Text("Show correct"),
                  ),
                  ElevatedButton(
                    onPressed: () => provider.buildAristocrat(GameMode.manual),
                    child: Text("Switch to Scioly mode"),
                  ),
                ],
              ),
            ),
          ),
          KeyboardWidget(gameId: gameId),
        ],
      ),
    );
  }
}
