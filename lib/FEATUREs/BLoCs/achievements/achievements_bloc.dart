import 'achievements_event.dart';
import 'achievements_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/FEATURES/counter/models/achievement_model.dart';
// File: lib/features/counter/bloc/achievements/achievements_bloc.dart

class AchievementsBloc extends Bloc<AchievementEvent, AchievementsState> {
  // Define achievements that can be unlocked
  final List<AchievementModel> _allAchievements = [
    // Positive achievements with more fun text
    const AchievementModel(
      id: 'first_tap',
      title: '🔥 Tap Initiate',
      description: 'Your counting journey begins! First tap unleashed!',
      triggerValue: 1,
    ),
    const AchievementModel(
      id: 'reach_10',
      title: '⭐ Counting Cadet',
      description: 'You\'ve reached 10! The counter gods are watching...',
      triggerValue: 10,
    ),
    const AchievementModel(
      id: 'reach_50',
      title: '🚀 Counting Rocket',
      description: 'Level 50 achieved! Your tapping power is growing!',
      triggerValue: 50,
    ),
    const AchievementModel(
      id: 'reach_100',
      title: '🏆 Century Tapper',
      description: 'Triple digits! Your dedication is becoming legendary!',
      triggerValue: 100,
    ),
    const AchievementModel(
      id: 'reach_150',
      title: '💎 Tapping Prodigy',
      description:
          '150 counts! Your finger might need its own social media account!',
      triggerValue: 150,
    ),
    // Extended achievements beyond 100
    const AchievementModel(
      id: 'reach_250',
      title: '💎 Tapping Prodigy',
      description:
          '250 counts! Your finger might need its own social media account!',
      triggerValue: 250,
    ),

    const AchievementModel(
      id: 'reach_350',
      title: '💎 Tapping Prodigy',
      description:
          '350 counts! Your finger might need its own social media account!',
      triggerValue: 350,
    ),
    const AchievementModel(
      id: 'reach_500',
      title: '🥇 Half-K Hero',
      description:
          '500 reached! You\'re halfway to the big 1K! The counter legends speak of your deeds!',
      triggerValue: 500,
    ),
    const AchievementModel(
      id: 'reach_600',
      title: '💎 Tapping Prodigy',
      description:
          '600 counts! Your finger might need its own social media account!',
      triggerValue: 600,
    ),
    const AchievementModel(
      id: 'reach_750',
      title: '🌟 Ascended Tapper',
      description:
          '750 counts! The counter realm trembles at your approach to 1K!',
      triggerValue: 750,
    ),
    const AchievementModel(
      id: 'reach_1000',
      title: '👑 Counting Royalty',
      description:
          '1,000 REACHED! You now sit upon the Thousand Throne! All hail the counter monarch!',
      triggerValue: 1000,
    ),
    const AchievementModel(
      id: 'reach_2500',
      title: '🔮 Counter Mystic',
      description:
          '2,500 counts! You\'ve unlocked counter abilities beyond mortal understanding!',
      triggerValue: 2500,
    ),
    const AchievementModel(
      id: 'reach_5000',
      title: '⚡ Tapping Thundergod',
      description:
          '5,000 COUNTS! Your tapping prowess creates lightning strikes across the counter dimension!',
      triggerValue: 5000,
    ),
    const AchievementModel(
      id: 'reach_7500',
      title: '🌈 Counter Transcendent',
      description:
          '7,500! You\'ve reached a plane where few counters dare to venture!',
      triggerValue: 7500,
    ),
    const AchievementModel(
      id: 'reach_10000',
      title: '🌠 Counter LEGEND',
      description:
          '10,000 COUNTS ACHIEVED! Your name will be written in the ancient scrolls of counting!',
      triggerValue: 10000,
    ),
    const AchievementModel(
      id: 'reach_25000',
      title: '💫 Quarter-100K Champion',
      description:
          '25,000! The counter cosmos acknowledges your dedicated finger of destiny!',
      triggerValue: 25000,
    ),
    const AchievementModel(
      id: 'reach_50000',
      title: '☄️ Half-100K Harbinger',
      description:
          '50,000 COUNTS! Other counters whisper your name in reverence!',
      triggerValue: 50000,
    ),
    const AchievementModel(
      id: 'reach_100000',
      title: '🌞 COUNTER GOD',
      description:
          '100,000!!! You have ascended to COUNTER GODHOOD! The universe itself counts in your honor!',
      triggerValue: 100000,
    ),
  ];

  AchievementsBloc() : super(AchievementsState.initial()) {
    on<CheckAchievements>(_onCheckAchievements);
    on<DismissAchievement>(_onDismissAchievement);
  }

  // Method to check if any achievements have been unlocked
  void _onCheckAchievements(
    CheckAchievements event,
    Emitter<AchievementsState> emit,
  ) {
    // Find achievements that should be unlocked based on counter value
    final newlyUnlocked =
        _allAchievements
            .where(
              (achievement) =>
                  achievement.triggerValue <= event.counterValue &&
                  !state.unlockedAchievements.contains(achievement),
            )
            .toList();

    // If no new achievements, do nothing
    if (newlyUnlocked.isEmpty) return;

    // Add newly unlocked achievements to the list
    final updatedAchievements = List<AchievementModel>.from(
      state.unlockedAchievements,
    )..addAll(newlyUnlocked);

    // Show notification for the highest value achievement
    final highestAchievement = newlyUnlocked.reduce(
      (a, b) => a.triggerValue > b.triggerValue ? a : b,
    );

    // Emit updated state
    emit(
      state.copyWith(
        unlockedAchievements: updatedAchievements,
        currentNotification: highestAchievement,
      ),
    );
  }

  // Method to dismiss achievement notification
  void _onDismissAchievement(
    DismissAchievement event,
    Emitter<AchievementsState> emit,
  ) {
    // Only dismiss if it matches the current notification
    if (state.currentNotification?.id == event.id) {
      emit(state.copyWith(currentNotification: null));
    }
  }
}
