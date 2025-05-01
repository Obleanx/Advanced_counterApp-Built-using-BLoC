import 'theme_event.dart';
import 'theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// File: lib/features/counter/bloc/theme/theme_bloc.dart

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<UpdateTheme>(_onUpdateTheme);
    on<ToggleBrightness>(_onToggleBrightness);
  }

  // Method to handle theme updates based on counter value
  void _onUpdateTheme(UpdateTheme event, Emitter<ThemeState> emit) {
    // Generate dynamic color based on counter value
    final hue = (event.counterValue * 12) % 360;
    final Color seedColor =
        HSLColor.fromAHSL(1.0, hue.toDouble(), 0.7, 0.5).toColor();

    // Create a new color scheme with the dynamic color
    final ColorScheme newColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: state.brightness,
    );

    // Emit updated state
    emit(state.copyWith(colorScheme: newColorScheme));
  }

  // Method to handle toggling between light and dark mode
  void _onToggleBrightness(ToggleBrightness event, Emitter<ThemeState> emit) {
    // Toggle brightness
    final newBrightness =
        state.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light;

    // Create a new color scheme with the updated brightness
    final ColorScheme newColorScheme = ColorScheme.fromSeed(
      seedColor: state.colorScheme.primary,
      brightness: newBrightness,
    );

    // Emit updated state
    emit(
      state.copyWith(brightness: newBrightness, colorScheme: newColorScheme),
    );
  }
}
