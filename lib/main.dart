import 'package:finn_utils/finn_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:pgoldapp/src/app.dart';

final mediaStorePlugin = MediaStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FinnUtilStorage.initialize();

  runApp(const ProviderScope(child: PGoldApp()));
}
