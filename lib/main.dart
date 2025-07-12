import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scioly_codebusters/Features/Settings/Models/setting_prefs.dart';
import 'library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() async {
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SolvedQuoteAdapter());
  Hive.registerAdapter(SettingPrefsAdapter());

  await Hive.openBox<SolvedQuote>('quotesBox');
  settingsBox = await Hive.openBox<SettingPrefs>('settingsBox');
  if (settingsBox?.get('prefs') == null) {
    await settingsBox?.put("prefs", SettingPrefs());
  }

  AudioController? audioController;
  if (!kIsWeb) {
    audioController = AudioController();
    await audioController.initialize();
  }

  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomePage(audioCont: audioController),
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
      ),
    ),
  );
}
