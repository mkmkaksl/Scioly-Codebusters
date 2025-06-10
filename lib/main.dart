import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  //await Hive.initFlutter();
  runApp(
    ProviderScope(
      child: MaterialApp(home: HomePage(), theme: AppTheme.theme),
    ),
  );
}
