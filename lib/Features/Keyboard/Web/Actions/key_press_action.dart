import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class KeyPressAction extends Action<KeyPressIntent> {
  final String gameKey;
  final WidgetRef ref;

  KeyPressAction({required this.gameKey, required this.ref});

  @override
  void invoke(covariant KeyPressIntent intent) {
    ref.read(keyboardProvider(gameKey).notifier).pressKey(intent.key, true);
  }
}

class KeyPressIntent extends Intent {
  final String key;
  const KeyPressIntent({required this.key});
}
