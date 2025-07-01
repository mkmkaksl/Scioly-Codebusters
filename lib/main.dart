import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SolveRecordAdapter());
  Hive.registerAdapter(GameModeStatsAdapter());
  Hive.registerAdapter(SolvedQuoteAdapter());
  await Hive.openBox<GameModeStats>('statsBox');
  await Hive.openBox<SolvedQuote>('quotesBox');

  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomePage(),
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
      ),
    ),
  );
}
