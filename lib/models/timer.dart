import 'dart:async';

class TimerManager {
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  Timer? _ticker;
  final Duration _tickInterval = Duration(milliseconds: 100);

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _ticker = Timer.periodic(_tickInterval, (_) {
      _elapsed += _tickInterval;
    });
  }

  void pause() {
    _ticker?.cancel();
    _ticker = null;
    _isRunning = false;
  }

  void resume() {
    if (_isRunning) return;
    start(); // Same as resume
  }

  void reset() {
    pause();
    _elapsed = Duration.zero;
  }

  /// Returns the number of seconds as an integer
  int getCurrentTime() => _elapsed.inSeconds;
}
