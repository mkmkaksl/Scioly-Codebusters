import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GamePage extends ConsumerWidget {
  final String gameId;
  final GameMode gameMode;
  final Language language;

  const GamePage({
    super.key,
    required this.gameId,
    required this.gameMode,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = "$gameId|${gameMode.name}";
    final provider = ref.read(gameProvider(key).notifier);
    final scrollController = ref.watch(scrollProvider(key));
    final quote = ref.watch(gameProvider(key).select((s) => s.quote.ogQuote));
    final bool isCorrect = ref.watch(
      gameProvider(key).select((s) => s.isCorrect),
    );
    final bool showCorrect = ref.watch(
      gameProvider(key).select((s) => s.showCorrect),
    );
    final showComplete = ref.watch(
      gameProvider(key).select((s) => s.showComplete),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(gameId),
        actions: [
          if (isCorrect && !showComplete)
            ElevatedButton(
              onPressed: () => provider.setPopup(true),
              child: Text("Continue"),
            ),
        ],
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.fromLTRB(
                  insetPadding,
                  insetPadding + panelHeight,
                  insetPadding,
                  insetPadding + keyboardH, // Add enough bottom padding
                ),
                child: Column(
                  children: [
                    CryptogramGridWidget(gameKey: key),
                    if (isCorrect)
                      Column(
                        children: [
                          SizedBox(height: padding),
                          SizedBox(
                            width: maxLength,
                            child: Text(
                              quote,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: scrollController,
                builder: (context, child) {
                  return DictionaryPopoverWidget(
                    gameId: gameId,
                    gameMode: gameMode,
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: screenW,
                    height: panelHeight + padding,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TimerWidget(timerId: key),
                        SizedBox(
                          width: buttonWidth,
                          height: panelHeight,
                          child: CheckboxListTile(
                            title: const Text('Show Correct'),
                            value: showCorrect,
                            onChanged: (bool? value) {
                              if (showCorrect) {
                                provider.markIncorrect();
                              } else {
                                provider.markCorrect();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: panelHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              provider.hint();
                            },
                            child: Text("Hint"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: KeyboardWidget(gameId: key, language: language),
              ),
            ],
          ),
          if (showComplete)
            Container(
              color: Colors.black.withAlpha(128),
              child: Center(
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Congratulations!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: padding),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          provider.destroy();
                        },
                        child: Text("Play Again"),
                      ),
                      const SizedBox(height: padding),
                      ElevatedButton(
                        onPressed: () {
                          provider.setPopup(false);
                        },
                        child: const Text('View Quote'),
                      ),
                      const SizedBox(height: padding),
                      ElevatedButton(
                        onPressed: () {
                          Null;
                        },
                        child: const Text('Save Quote'),
                      ),
                      const SizedBox(height: padding),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                          provider.destroy();
                        },
                        child: Text("Home"),
                      ),
                      const SizedBox(height: padding),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      backgroundColor: isCorrect ? Colors.greenAccent : Colors.white,
    );
  }
}
