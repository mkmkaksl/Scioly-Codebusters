import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scioly_codebusters/library.dart';

class DeleteCellAction extends Action<DeleteCellIntent> {
  final String gameKey;
  final WidgetRef ref;

  DeleteCellAction({required this.gameKey, required this.ref});

  @override
  void invoke(covariant DeleteCellIntent intent) {
    ref.read(keyboardProvider(gameKey).notifier).pressKey("", true);
  }
}

class DeleteCellIntent extends Intent {}
