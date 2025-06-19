import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GamePageSetup extends ConsumerWidget {
  final Language language;
  final String gameId;
  const GamePageSetup({
    super.key,
    required this.gameId,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GameMode gameMode = ref.watch(gameModeProvider(gameId));
    String key = "$gameId|${gameMode.name}";
    final gmProvider = ref.read(gameModeProvider(gameId).notifier);
    final gProvider = ref.read(gameProvider(key).notifier);
    var cellCount = ref.watch(gameProvider(key).select((s) => s.cells.length));
    final stats = ref.watch(gameModeStatsProvider(key));

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              gameId,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(insetPadding),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: padding),
                  Text(
                    "Select a game mode",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        gmProvider.setGameMode(GameMode.assisted);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gameMode == GameMode.assisted
                            ? Colors.grey
                            : null,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        "Assisted",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        gmProvider.setGameMode(GameMode.manual);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gameMode == GameMode.manual
                            ? Colors.grey
                            : null,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        "Manual",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: undoButtonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StatsGrid(
                                    widgetKey: key,
                                    fastestAllTime: stats.fastestSolve,
                                    averageAllTime: stats.averageSolve,
                                    fastestLast10: stats.fastestInLast(10),
                                    averageLast10: stats.averageInLast(10),
                                    fastestPrevious10: stats.fastestInLast(
                                      20,
                                      skip: 10,
                                    ),
                                    averagePrevious10: stats.averageInLast(
                                      20,
                                      skip: 10,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Stats"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: undoButtonHeight,
                          child: ElevatedButton(
                            onPressed: () => Null,
                            child: const Text("How to Play"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: padding),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: undoButtonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GamePage(
                                    gameId: gameId,
                                    gameMode: gameMode,
                                    language: language,
                                  ),
                                ),
                              );
                              gProvider.buildCryptogram(
                                gameMode,
                                language,
                                gameId,
                              );
                            },
                            child: const Text("New Puzzle"),
                          ),
                        ),
                      ),
                      if (cellCount > 0)
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: undoButtonHeight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GamePage(
                                      gameId: gameId,
                                      gameMode: gameMode,
                                      language: language,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Continue"),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
