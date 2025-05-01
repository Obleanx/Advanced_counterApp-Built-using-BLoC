import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_counter/FEATURES/counter/models/counter_models.dart';
import 'package:bloc_counter/FEATURES/counter/models/achievement_model.dart';

// Abstract class defining the contract for counter repository
abstract class CounterRepository {
  // Counter methods
  Future<List<CounterModel>> getCounters();
  Future<void> saveCounters(List<CounterModel> counters);
  Future<int> getCurrentIndex();
  Future<void> saveCurrentIndex(int index);

  // Achievement methods
  Future<List<AchievementModel>> getAchievements();
  Future<List<String>> getUnlockedAchievementIds();
  Future<void> saveUnlockedAchievementIds(List<String> ids);

  // Theme methods
  Future<bool> getDarkMode();
  Future<void> saveDarkMode(bool isDark);
}

// Implementation of the CounterRepository using SharedPreferences
class CounterRepositoryImpl implements CounterRepository {
  // SharedPreferences keys
  static const String _countersKey = 'counters';
  static const String _currentIndexKey = 'current_index';
  static const String _unlockedAchievementsKey = 'unlocked_achievements';
  static const String _darkModeKey = 'dark_mode';

  final SharedPreferences _prefs;

  // Constructor requiring SharedPreferences instance
  CounterRepositoryImpl(this._prefs);

  @override
  Future<List<CounterModel>> getCounters() async {
    final String? countersJson = _prefs.getString(_countersKey);

    if (countersJson == null || countersJson.isEmpty) {
      // Return default counter if none exists
      return [const CounterModel(name: 'Default', value: 0)];
    }

    try {
      final List<dynamic> decoded = jsonDecode(countersJson);
      return decoded.map((item) {
        return CounterModel(
          name: item['name'] as String,
          value: item['value'] as int,
        );
      }).toList();
    } catch (e) {
      // Return default counter on error
      return [const CounterModel(name: 'Default', value: 0)];
    }
  }

  @override
  Future<void> saveCounters(List<CounterModel> counters) async {
    final List<Map<String, dynamic>> encoded =
        counters.map((counter) {
          return {'name': counter.name, 'value': counter.value};
        }).toList();

    await _prefs.setString(_countersKey, jsonEncode(encoded));
  }

  @override
  Future<int> getCurrentIndex() async {
    return _prefs.getInt(_currentIndexKey) ?? 0;
  }

  @override
  Future<void> saveCurrentIndex(int index) async {
    await _prefs.setInt(_currentIndexKey, index);
  }

  @override
  Future<List<AchievementModel>> getAchievements() async {
    // Predefined achievements
    return [
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
      const AchievementModel(
        id: 'negative',
        title: 'Below Zero',
        description: 'Go negative for the first time',
        triggerValue: -1,
      ),
      // Negative achievement
      const AchievementModel(
        id: 'negative',
        title: '🌑 Into the Void',
        description:
            'Venture into negative territory for the first time! The counter darkness awaits...',
        triggerValue: -1,
      ),
      // Additional negative milestones
      const AchievementModel(
        id: 'negative_10',
        title: '🌊 Deep Dive',
        description: 'Sunk to -10! How much deeper can you go?',
        triggerValue: -10,
      ),
      const AchievementModel(
        id: 'negative_50',
        title: '🕳️ The Abyss Gazes Back',
        description: 'Reached -50! You\'re falling with style!',
        triggerValue: -50,
      ),
      const AchievementModel(
        id: 'negative_100',
        title: '🌌 Negative Century',
        description:
            '-100 reached! You\'ve discovered the anti-counting universe!',
        triggerValue: -100,
      ),
    ];
  }

  @override
  Future<List<String>> getUnlockedAchievementIds() async {
    final String? unlockedJson = _prefs.getString(_unlockedAchievementsKey);

    if (unlockedJson == null || unlockedJson.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(unlockedJson);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveUnlockedAchievementIds(List<String> ids) async {
    await _prefs.setString(_unlockedAchievementsKey, jsonEncode(ids));
  }

  @override
  Future<bool> getDarkMode() async {
    return _prefs.getBool(_darkModeKey) ?? false;
  }

  @override
  Future<void> saveDarkMode(bool isDark) async {
    await _prefs.setBool(_darkModeKey, isDark);
  }
}
