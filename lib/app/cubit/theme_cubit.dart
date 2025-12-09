// lib/core/theme/theme_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        emit(ThemeMode.dark);
      case ThemeMode.dark:
        emit(ThemeMode.system);
      case ThemeMode.system:
        emit(ThemeMode.light);
    }
  }

  void setTheme(ThemeMode mode) => emit(mode);
}
