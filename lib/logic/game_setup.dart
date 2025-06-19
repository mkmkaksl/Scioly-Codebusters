import 'package:projects/library.dart';

class GameSetup {
  static Game buildCryptogram(
    GameMode gameMode,
    Language language,
    String gameId,
  ) {
    List<Cell> newCells = [];
    Quote quote = QuoteLibrary.getNewQuote(language);
    //add cells
    for (String i in quote.plainText.split('')) {
      if (QuoteLibrary.isException(i, language) && gameId != "Patristocrat") {
        newCells.add(Cell(text: i, cipher: i, plainText: i, isException: true));
      } else if (gameId != "Patristocrat" ||
          !QuoteLibrary.isException(i, language)) {
        newCells.add(
          Cell(
            text: "",
            cipher: quote.key[i]!,
            plainText: i,
            isException: false,
            count: quote.frequencies[i]!,
          ),
        );
      }
    }
    return Game(
      quote: quote,
      cells: newCells.calculateRows(gameId),
      gameMode: gameMode,
    );
  }
}
