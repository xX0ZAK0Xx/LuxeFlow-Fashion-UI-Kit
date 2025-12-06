import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeMode themeMode;
  const SetTheme(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;
  static const String _themeKey = 'theme_mode';

  ThemeBloc({required this.sharedPreferences}) : super(const ThemeState(ThemeMode.system)) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = sharedPreferences.getString(_themeKey);
    if (savedTheme == 'light') {
      add(const SetTheme(ThemeMode.light));
    } else if (savedTheme == 'dark') {
      add(const SetTheme(ThemeMode.dark));
    } else {
      add(const SetTheme(ThemeMode.system));
    }
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await sharedPreferences.setString(_themeKey, newMode == ThemeMode.light ? 'light' : 'dark');
    emit(ThemeState(newMode));
  }

  Future<void> _onSetTheme(SetTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeState(event.themeMode));
  }
}
