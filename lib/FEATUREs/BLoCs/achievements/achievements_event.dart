import 'package:equatable/equatable.dart';
// File: lib/features/counter/bloc/achievements/achievements_event.dart

// Base class for all achievement events
abstract class AchievementEvent extends Equatable {
  const AchievementEvent();

  @override
  List<Object> get props => [];
}

// Event to check for achievements based on counter value
class CheckAchievements extends AchievementEvent {
  final int counterValue;

  const CheckAchievements(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}

// Event to dismiss achievement notification
class DismissAchievement extends AchievementEvent {
  final String id;

  const DismissAchievement(this.id);

  @override
  List<Object> get props => [id];
}
