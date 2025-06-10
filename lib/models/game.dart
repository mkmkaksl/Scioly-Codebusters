import 'package:projects/library.dart';

enum GameMode { assisted, manual }

class Game {
  final int selectedIdx;
  final Quote quote;
  final bool isCorrect;
  final List<Game> history; //stores previous states, not itself
  final List<Cell> cells;
  final GameMode gameMode;

  Game({
    required this.quote,
    this.selectedIdx = 0,
    this.isCorrect = false,
    this.history = const [],
    this.cells = const [],
    this.gameMode = GameMode.assisted,
  });

  Game copyWith({
    int? selectedIdx,
    Quote? quote,
    bool? isCorrect,
    List<Game>? history,
    List<Cell>? cells,
    GameMode? gameMode,
  }) {
    return Game(
      quote: quote ?? this.quote,
      selectedIdx: selectedIdx ?? this.selectedIdx,
      isCorrect: isCorrect ?? this.isCorrect,
      history: history ?? this.history,
      cells: cells ?? this.cells,
      gameMode: gameMode ?? this.gameMode,
    );
  }
}
