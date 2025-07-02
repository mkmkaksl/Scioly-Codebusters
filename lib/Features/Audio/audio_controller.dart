import 'dart:async';

import 'package:logging/logging.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioController {
  static final Logger _log = Logger('AudioController');

  SoLoud? _soloud;

  Future<void> initialize() async {
    _soloud = SoLoud.instance;
    await _soloud!.init();
  }

  void dispose() {
    _soloud?.deinit();
  }

  Future<void> playSound(String assetKey) async {
    final source = await _soloud!.loadAsset(assetKey);
    await _soloud!.play(source);
    _log.warning('Not implemented yet.');
  }

  Future<void> startMusic() async {
    _log.warning('Not implemented yet.');
  }
}
