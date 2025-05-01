import 'package:equatable/equatable.dart';
// File: lib/features/counter/bloc/counter/counter_event.dart

// Base class for all counter events
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

// Event triggered when user increments counter
class IncrementCounter extends CounterEvent {}

// Event triggered when user decrements counter
class DecrementCounter extends CounterEvent {}

// Event triggered when user resets counter to zero
class ResetCounter extends CounterEvent {}

// Event triggered when user requests to undo the last counter change
class UndoCounter extends CounterEvent {}

// Event triggered when user requests to redo a previously undone counter change
class RedoCounter extends CounterEvent {}

// Event to add a named counter
class AddNamedCounter extends CounterEvent {
  final String name;

  const AddNamedCounter(this.name);

  @override
  List<Object> get props => [name];
}

class RemoveCurrentCounter extends CounterEvent {}

// Ensure event handling logic is implemented within the appropriate Bloc or Cubit class.

// Event to switch between counters
class SwitchCounter extends CounterEvent {
  final int index;

  const SwitchCounter(this.index);

  @override
  List<Object> get props => [index];
}

// Add the new event for incrementing by a specific amount
class IncrementByAmount extends CounterEvent {
  final int amount;

  const IncrementByAmount(this.amount);

  @override
  List<Object> get props => [amount];
}
