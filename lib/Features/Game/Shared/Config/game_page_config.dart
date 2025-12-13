import 'package:scioly_codebusters/library.dart';

class GamePageConfig {
  final String gameId;
  final GameMode gameMode;
  final Language language;

  const GamePageConfig({
    required this.gameId,
    required this.gameMode,
    required this.language,
  });
}
