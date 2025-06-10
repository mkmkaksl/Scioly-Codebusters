//import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

class GameProvider extends FamilyNotifier<Game, String> {
  @override
  Game build(String arg) {
    return Game(quote: Quote.getNewQuote());
  }

  String setLetter(String letter) {
    String currLetter = state.cells[state.selectedIdx].text;
    var newCells = [...state.cells];
    var newHistory = [...state.history, state.copyWith()];
    if (state.gameMode == GameMode.assisted) {
      for (int i = 0; i < newCells.length; i++) {
        if (newCells[i].isLit) newCells[i] = newCells[i].copyWith(text: letter);
      }
    } else {
      newCells[state.selectedIdx] = newCells[state.selectedIdx].copyWith(
        text: letter,
      );
    }
    state = state.copyWith(cells: newCells, history: newHistory);
    if (state.gameMode == GameMode.assisted) markDuplicate();
    markIncorrect();
    nextCell();
    return currLetter;
  }

  void markDuplicate() {
    // Step 1: Map each text to the set of unique ciphers associated with it
    var cells = [...state.cells];
    final Map<String, Set<String>> textToCiphers = {};

    for (final cell in cells) {
      textToCiphers.putIfAbsent(cell.text, () => <String>{}).add(cell.cipher);
    }

    // Step 2: Identify which texts map to multiple ciphers
    final Set<String> incorrectTexts = textToCiphers.entries
        .where((entry) => entry.value.length > 1)
        .map((entry) => entry.key)
        .toSet();

    // Step 3: Mark cells as incorrect if their text is in the incorrectTexts set
    var newCells = cells.map((cell) {
      if (incorrectTexts.contains(cell.text)) {
        return cell.copyWith(isDuplicate: true);
      } else {
        return cell.copyWith(isDuplicate: false);
      }
    }).toList();
    state = state.copyWith(cells: newCells);
  }

  void nextCell() {
    int curIdx = state.selectedIdx;
    while (curIdx < state.cells.length - 1) {
      curIdx++;
      if (state.cells[curIdx].text == "") {
        selectCell(curIdx);
        break;
      }
    }
  }

  void markCorrect() {
    var newCells = [...state.cells];
    for (int i = 0; i < newCells.length; i++) {
      if (newCells[i].cipher == state.quote.key[newCells[i].text]) {
        newCells[i] = newCells[i].copyWith(isCorrect: true);
      }
    }
    state = state.copyWith(cells: newCells);
    markIncorrect();
  }

  //make sure cells previously marked correct are marked incorrect when changed
  void markIncorrect() {
    var newCells = [...state.cells];
    for (int i = 0; i < newCells.length; i++) {
      if (newCells[i].cipher != state.quote.key[newCells[i].text]) {
        newCells[i] = newCells[i].copyWith(isCorrect: false);
      }
    }
    state = state.copyWith(cells: newCells);
  }

  void selectCell(int index) {
    deselectCells();
    if (state.gameMode == GameMode.assisted) {
      highlightCells(index);
    }
    var newCells = [...state.cells];
    newCells[index] = newCells[index].copyWith(isSelected: true);
    state = state.copyWith(cells: newCells, selectedIdx: index);
  }

  void deselectCells() {
    var newCells = [...state.cells];
    for (int i = 0; i < newCells.length; i++) {
      newCells[i] = newCells[i].copyWith(isSelected: false, isLit: false);
    }
    state = state.copyWith(cells: newCells);
  }

  //highlights all similar cells, including selected
  void highlightCells(int index) {
    var newCells = [...state.cells];
    for (int i = 0; i < newCells.length; i++) {
      if (newCells[i].cipher == newCells[index].cipher) {
        newCells[i] = newCells[i].copyWith(isLit: true);
      }
    }
    state = state.copyWith(cells: newCells);
  }

  void undo() {
    if (state.history.isEmpty) return;
    state = state.history.last;
  }

  bool checkAnswer() {
    if (state.isCorrect) return true;
    for (int i = 0; i < state.cells.length; i++) {
      if (state.cells[i].cipher != state.quote.key[state.cells[i].text]) {
        return false;
      }
    }
    state = state.copyWith(isCorrect: true);
    return true;
  }

  void buildAristocrat(GameMode gameMode) {
    List<Cell> newCells = [];
    Quote quote = Quote.getNewQuote();
    //add cells
    for (String i in quote.plainText.split('')) {
      if (Quote.isException(i)) {
        newCells.add(Cell(text: i, cipher: "", isException: true));
      } else {
        newCells.add(
          Cell(
            text: "",
            cipher: quote.key[i]!,
            isException: false,
            count: quote.frequencies[i]!,
          ),
        );
      }
    }
    //select first valid cell and update state
    int idx = 0;
    while (newCells[idx].isException) {
      idx++;
    }
    state = Game(quote: quote, cells: newCells, gameMode: gameMode);
    selectCell(idx);
    ref.read(keyboardProvider(arg).notifier).reset();
  }

  void buildPatristocrat(GameMode gameMode) {
    List<Cell> newCells = [];
    Quote quote = Quote.getNewQuote();
    //add cells
    for (String i in quote.plainText.split('')) {
      if (!Quote.isException(i)) {
        newCells.add(
          Cell(
            text: "",
            cipher: quote.key[i]!,
            isException: false,
            count: quote.frequencies[i]!,
          ),
        );
      }
    }
    //select first valid cell and update state
    state = Game(quote: quote, cells: newCells, gameMode: gameMode);
    selectCell(0);
    ref.read(keyboardProvider(arg).notifier).reset();
  }

  /* for Patristocrats
  void insertCell(String txt, int idx) {
    final updated = [...state];
    updated.insert(idx, Cell(text: txt, isLit: false, isSelected: false, count: 0));
    state = [...updated];
  }*/

  /*
  void removeCell() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }*/
}

final gameStateProvider = NotifierProvider.family<GameProvider, Game, String>(
  GameProvider.new,
);
