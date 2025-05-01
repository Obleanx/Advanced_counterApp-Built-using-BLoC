import 'package:equatable/equatable.dart';
import 'package:bloc_counter/FEATURES/counter/models/achievement_model.dart';
// File: lib/features/counter/bloc/achievements/achievements_state.dart

// Represents the current achievement state
class AchievementsState extends Equatable {
  final List<AchievementModel> unlockedAchievements;
  final AchievementModel? currentNotification;

  const AchievementsState({
    required this.unlockedAchievements,
    this.currentNotification,
  });

  // Initial state with no achievements
  factory AchievementsState.initial() {
    return const AchievementsState(
      unlockedAchievements: [],
      currentNotification: null,
    );
  }

  // Helper method to create a copy of the state with updated values
  AchievementsState copyWith({
    List<AchievementModel>? unlockedAchievements,
    AchievementModel? currentNotification,
  }) {
    return AchievementsState(
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      currentNotification: currentNotification, // null is valid here
    );
  }

  @override
  List<Object?> get props => [unlockedAchievements, currentNotification];
}
