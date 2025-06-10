//import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/library.dart';

//double check everything is final for gameStates
class KeyboardProvider extends FamilyNotifier<Keyboard, String> {
  @override
  Keyboard build(String arg) {
    return Keyboard();
  }

  void pressKey(String key) {
    //if (state.pressedKeys.contains(key)) return;
    final newHistory = [...state.history, state.copyWith()];
    String letter = ref.read(gameStateProvider(arg).notifier).setLetter(key);
    var newPressed = {...state.pressedKeys, key};
    final gameMode = ref.watch(
      gameStateProvider(arg).select((s) => s.gameMode),
    );
    if (gameMode == GameMode.manual) newPressed = {};
    if (newPressed.contains(letter)) newPressed.remove(letter);
    state = state.copyWith(pressedKeys: newPressed, history: newHistory);
  }

  void undo() {
    if (state.history.isEmpty) return;
    state = state.history.last;
    ref.read(gameStateProvider(arg).notifier).undo();
  }

  void reset() {
    state = Keyboard();
  }
}

final keyboardProvider =
    NotifierProvider.family<KeyboardProvider, Keyboard, String>(
      KeyboardProvider.new,
    );
