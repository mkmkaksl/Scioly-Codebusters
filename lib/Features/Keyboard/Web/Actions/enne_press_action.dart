import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class EnnePressAction extends Action<EnnePressIntent> {
  final String gameKey;
  final WidgetRef ref;

  EnnePressAction({required this.gameKey, required this.ref});

  @override
  void invoke(covariant EnnePressIntent intent) {
    ref
        .read(keyboardProvider(gameKey).notifier)
        .pressKey('ñ'.toUpperCase(), true);
  }
}

class EnnePressIntent extends Intent {
  const EnnePressIntent();
}
