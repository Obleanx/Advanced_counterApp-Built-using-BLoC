import 'package:equatable/equatable.dart';
// File: lib/features/counter/bloc/theme/theme_event.dart

// Base class for all theme events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

// Event to update theme based on counter value
class UpdateTheme extends ThemeEvent {
  final int counterValue;

  const UpdateTheme(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}

// Event to toggle between dark and light mode
class ToggleBrightness extends ThemeEvent {}
