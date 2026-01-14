import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeBoxName = 'theme_settings';
  static const String _isDarkModeKey = 'is_dark_mode';

  ThemeCubit() : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_themeBoxName);
    final isDarkMode = box.get(_isDarkModeKey, defaultValue: false) as bool;
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> toggleTheme() async {
    final newValue = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: newValue));

    final box = await Hive.openBox(_themeBoxName);
    await box.put(_isDarkModeKey, newValue);
  }

  Future<void> setDarkMode(bool value) async {
    emit(state.copyWith(isDarkMode: value));

    final box = await Hive.openBox(_themeBoxName);
    await box.put(_isDarkModeKey, value);
  }
}
