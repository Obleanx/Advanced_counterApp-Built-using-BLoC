import 'package:equatable/equatable.dart';
import 'package:bloc_counter/FEATURES/counter/models/counter_models.dart';
// File: lib/features/counter/bloc/counter/counter_state.dart

// Represents the current state of our counter feature
class CounterState extends Equatable {
  final List<CounterModel> counters; // List of all counters
  final int currentIndex; // Index of the currently active counter
  final List<int> history; // History of previous values for undo/redo
  final int historyIndex; // Current position in history
  final bool showConfetti; // Whether to show confetti animation

  // Convenience getter for the current counter value
  int get currentValue =>
      counters.isNotEmpty ? counters[currentIndex].value : 0;

  // Convenience getter for the current counter name
  String get currentName =>
      counters.isNotEmpty ? counters[currentIndex].name : 'Counter';

  // Can we undo?
  bool get canUndo => historyIndex > 0;

  // Can we redo?
  bool get canRedo => historyIndex < history.length - 1;

  const CounterState({
    required this.counters,
    required this.currentIndex,
    required this.history,
    required this.historyIndex,
    required this.showConfetti,
  });

  // Initial state when app starts
  factory CounterState.initial() {
    return CounterState(
      counters: [CounterModel(name: 'Main Counter', value: 0)],
      currentIndex: 0,
      history: [0], // Initial history with starting value
      historyIndex: 0,
      showConfetti: false,
    );
  }

  // Helper method to create a copy of the state with updated values
  CounterState copyWith({
    List<CounterModel>? counters,
    int? currentIndex,
    List<int>? history,
    int? historyIndex,
    bool? showConfetti,
  }) {
    return CounterState(
      counters: counters ?? this.counters,
      currentIndex: currentIndex ?? this.currentIndex,
      history: history ?? this.history,
      historyIndex: historyIndex ?? this.historyIndex,
      showConfetti: showConfetti ?? this.showConfetti,
    );
  }

  @override
  List<Object> get props => [
    counters,
    currentIndex,
    history,
    historyIndex,
    showConfetti,
  ];
}
