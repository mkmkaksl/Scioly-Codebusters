import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class Patristocrat extends ConsumerWidget {
  final String gameId = "Patristocrat";
  const Patristocrat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gameStateProvider(gameId).notifier);
    final GameMode gameMode = ref.watch(
      gameStateProvider(gameId).select((s) => s.gameMode),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Patristocrat")),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PatristocratGridWidget(),
                    ElevatedButton(
                      onPressed: () => provider.buildPatristocrat(gameMode),
                      child: Text("New Quote"),
                    ),
                    ElevatedButton(
                      onPressed: () => provider.markCorrect(),
                      child: Text("Show correct"),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          provider.buildPatristocrat(GameMode.manual),
                      child: Text("Switch to Scioly mode"),
                    ),
                  ],
                ),
              ),
            ),
            KeyboardWidget(gameId: gameId),
          ],
        ),
      ),
    );
  }
}
