import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefHolder {
  static late WidgetRef _ref;

  static void init(WidgetRef ref) {
    _ref = ref;
  }

  static WidgetRef get ref => _ref;
}
