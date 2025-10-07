import 'package:get_storage/get_storage.dart';

const String _boxName = 'DirectionStorage';

class AppLocalStorageService {
  static final AppLocalStorageService _instance =
      AppLocalStorageService._internal();

  factory AppLocalStorageService() => _instance;

  AppLocalStorageService._internal() {
    _box = GetStorage(_boxName);
  }

  late final GetStorage _box;

  static const String _onboardingKey = 'has_completed_onboarding';

  Future<void> write<T>(String key, T value) async {
    await _box.write(key, value);
  }

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }

  Future<void> setOnboardingCompleted(bool value) async {
    await write<bool>(_onboardingKey, value);
  }

  bool get hasCompletedOnboarding {
    return read<bool>(_onboardingKey) ?? false;
  }
}
