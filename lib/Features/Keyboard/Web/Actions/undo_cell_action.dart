import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class UndoCellAction extends Action<UndoCellIntent> {
  final String gameKey;
  final WidgetRef ref;

  UndoCellAction({required this.gameKey, required this.ref});

  @override
  void invoke(covariant UndoCellIntent intent) {
    ref.read(keyboardProvider(gameKey).notifier).undo();
  }
}

class UndoCellIntent extends Intent {}
