import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
// File: lib/features/counter/bloc/theme/theme_state.dart

// Represents the current theme state
class ThemeState extends Equatable {
  final Brightness brightness;
  final ColorScheme colorScheme;

  const ThemeState({required this.brightness, required this.colorScheme});

  // Initial state with default theme
  factory ThemeState.initial() {
    return ThemeState(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
    );
  }

  // Helper method to create a copy of the state with updated values
  ThemeState copyWith({Brightness? brightness, ColorScheme? colorScheme}) {
    return ThemeState(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  List<Object> get props => [brightness, colorScheme];
}
