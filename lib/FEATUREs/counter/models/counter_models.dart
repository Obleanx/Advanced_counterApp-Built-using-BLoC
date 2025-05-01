import 'package:equatable/equatable.dart';
// File: lib/features/counter/data/models/counter_model.dart

// Model for a counter with a name and value
class CounterModel extends Equatable {
  final String name;
  final int value;

  const CounterModel({required this.name, required this.value});

  @override
  List<Object> get props => [name, value];
}
