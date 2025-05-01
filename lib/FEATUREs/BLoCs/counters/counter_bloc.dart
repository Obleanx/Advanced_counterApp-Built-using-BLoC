import 'counter_event.dart';
import 'counter_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/FEATURES/counter/models/counter_models.dart';
// File: lib/features/counter/bloc/counter/counter_bloc.dart

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // Define how each event is handled

    // Handle increment event
    on<IncrementCounter>(_onIncrementCounter);

    // Handle decrement event
    on<DecrementCounter>(_onDecrementCounter);

    // Handle reset event
    on<ResetCounter>(_onResetCounter);

    // Handle undo event
    on<UndoCounter>(_onUndoCounter);

    // Handle redo event
    on<RedoCounter>(_onRedoCounter);

    // Handle adding a new named counter
    on<AddNamedCounter>(_onAddNamedCounter);

    // Handle switching between counters
    on<SwitchCounter>(_onSwitchCounter);

    // Handle incrementing by a specific amount
    on<IncrementByAmount>(_onIncrementByAmount);
  }

  // Method to handle increment event
  void _onIncrementCounter(IncrementCounter event, Emitter<CounterState> emit) {
    // Create a new list of counters with the updated value
    final updatedCounters = List<CounterModel>.from(state.counters);
    updatedCounters[state.currentIndex] = CounterModel(
      name: state.counters[state.currentIndex].name,
      value: state.currentValue + 1,
    );

    // Calculate if we should show confetti (every 10th value)
    final showConfetti = (state.currentValue + 1) % 10 == 0;

    // Add haptic feedback on increment
    HapticFeedback.mediumImpact();

    // Create a new history list by:
    // 1. Taking all history items up to the current index
    // 2. Adding the new value
    final newHistory = List<int>.from(
      state.history.sublist(0, state.historyIndex + 1),
    )..add(state.currentValue + 1);

    // Emit updated state
    emit(
      state.copyWith(
        counters: updatedCounters,
        history: newHistory,
        historyIndex: state.historyIndex + 1,
        showConfetti: showConfetti,
      ),
    );
  }

  // Method to handle incrementing by a specific amount
  void _onIncrementByAmount(
    IncrementByAmount event,
    Emitter<CounterState> emit,
  ) {
    // Calculate the new value
    final newValue = state.currentValue + event.amount;

    // Create a new list of counters with the updated value
    final updatedCounters = List<CounterModel>.from(state.counters);
    updatedCounters[state.currentIndex] = CounterModel(
      name: state.counters[state.currentIndex].name,
      value: newValue,
    );

    // Calculate if we should show confetti (if the new value is a multiple of 10)
    final showConfetti = newValue % 10 == 0 && newValue > 0;

    // Add haptic feedback on increment
    HapticFeedback.mediumImpact();

    // Create a new history list
    final newHistory = List<int>.from(
      state.history.sublist(0, state.historyIndex + 1),
    )..add(newValue);

    // Emit updated state
    emit(
      state.copyWith(
        counters: updatedCounters,
        history: newHistory,
        historyIndex: state.historyIndex + 1,
        showConfetti: showConfetti,
      ),
    );
  }

  // // Method to handle decrement event
  // void _onDecrementCounter(DecrementCounter event, Emitter<CounterState> emit) {
  //   // Don't allow negative values
  //   if (state.currentValue <= 0) return;

  //   // Create a new list of counters with the updated value
  //   final updatedCounters = List<CounterModel>.from(state.counters);
  //   updatedCounters[state.currentIndex] = CounterModel(
  //     name: state.counters[state.currentIndex].name,
  //     value: state.currentValue - 1,
  //   );

  //   // Add light haptic feedback on decrement
  //   HapticFeedback.lightImpact();

  //   // Create a new history list
  //   final newHistory = List<int>.from(
  //     state.history.sublist(0, state.historyIndex + 1),
  //   )..add(state.currentValue - 1);

  //   // Emit updated state (never show confetti for decrement)
  //   emit(
  //     state.copyWith(
  //       counters: updatedCounters,
  //       history: newHistory,
  //       historyIndex: state.historyIndex + 1,
  //       showConfetti: false,
  //     ),
  //   );
  // }

  // Method to handle decrement event
  void _onDecrementCounter(DecrementCounter event, Emitter<CounterState> emit) {
    // Remove the check that prevents negative values
    // if (state.currentValue <= 0) return;

    // Create a new list of counters with the updated value
    final updatedCounters = List<CounterModel>.from(state.counters);
    updatedCounters[state.currentIndex] = CounterModel(
      name: state.counters[state.currentIndex].name,
      value: state.currentValue - 1,
    );

    // Add light haptic feedback on decrement
    HapticFeedback.lightImpact();

    // Create a new history list
    final newHistory = List<int>.from(
      state.history.sublist(0, state.historyIndex + 1),
    )..add(state.currentValue - 1);

    // Emit updated state (never show confetti for decrement)
    emit(
      state.copyWith(
        counters: updatedCounters,
        history: newHistory,
        historyIndex: state.historyIndex + 1,
        showConfetti: false,
      ),
    );
  }

  // Method to handle reset event
  void _onResetCounter(ResetCounter event, Emitter<CounterState> emit) {
    // Create a new list of counters with reset value
    final updatedCounters = List<CounterModel>.from(state.counters);
    updatedCounters[state.currentIndex] = CounterModel(
      name: state.counters[state.currentIndex].name,
      value: 0,
    );

    // Add heavy haptic feedback on reset
    HapticFeedback.heavyImpact();

    // Create a new history list
    final newHistory = List<int>.from(
      state.history.sublist(0, state.historyIndex + 1),
    )..add(0);

    // Emit updated state
    emit(
      state.copyWith(
        counters: updatedCounters,
        history: newHistory,
        historyIndex: state.historyIndex + 1,
        showConfetti: false,
      ),
    );
  }

  // Method to handle undo event
  void _onUndoCounter(UndoCounter event, Emitter<CounterState> emit) {
    // Check if we can undo
    if (!state.canUndo) return;

    // Get the previous value from history
    final previousValue = state.history[state.historyIndex - 1];

    // Create a new list of counters with the previous value
    final updatedCounters = List<CounterModel>.from(state.counters);
    updatedCounters[state.currentIndex] = CounterModel(
      name: state.counters[state.currentIndex].name,
      value: previousValue,
    );

    // Emit updated state with decremented history index
    emit(
      state.copyWith(
        counters: updatedCounters,
        historyIndex: state.historyIndex - 1,
        showConfetti: false,
      ),
    );
  }

  // Method to handle redo event
  void _onRedoCounter(RedoCounter event, Emitter<CounterState> emit) {
    // Check if we can redo
    if (!state.canRedo) return;

    // Get the next value from history
    final nextValue = state.history[state.historyIndex + 1];

    // Create a new list of counters with the next value
    final updatedCounters = List<CounterModel>.from(state.counters);
    updatedCounters[state.currentIndex] = CounterModel(
      name: state.counters[state.currentIndex].name,
      value: nextValue,
    );

    // Calculate if we should show confetti
    final showConfetti = nextValue % 10 == 0 && nextValue > 0;

    // Emit updated state with incremented history index
    emit(
      state.copyWith(
        counters: updatedCounters,
        historyIndex: state.historyIndex + 1,
        showConfetti: showConfetti,
      ),
    );
  }

  // Method to handle adding a new named counter
  void _onAddNamedCounter(AddNamedCounter event, Emitter<CounterState> emit) {
    // Create a new counter with the provided name
    final newCounter = CounterModel(name: event.name, value: 0);

    // Add the new counter to the list
    final updatedCounters = List<CounterModel>.from(state.counters)
      ..add(newCounter);

    // Reset history for the new counter
    final newHistory = [0];

    // Emit updated state
    emit(
      state.copyWith(
        counters: updatedCounters,
        currentIndex: updatedCounters.length - 1, // Switch to the new counter
        history: newHistory,
        historyIndex: 0,
        showConfetti: false,
      ),
    );
  }

  // Method to handle switching between counters
  void _onSwitchCounter(SwitchCounter event, Emitter<CounterState> emit) {
    // Validate the index
    if (event.index < 0 || event.index >= state.counters.length) return;

    // Get the current value of the selected counter
    final selectedValue = state.counters[event.index].value;

    // Reset history for the selected counter
    final newHistory = [selectedValue];

    // Emit updated state
    emit(
      state.copyWith(
        currentIndex: event.index,
        history: newHistory,
        historyIndex: 0,
        showConfetti: false,
      ),
    );
  }
}
