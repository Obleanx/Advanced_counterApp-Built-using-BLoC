import 'package:equatable/equatable.dart';
// File: lib/features/counter/data/models/achievement_model.dart

// Model for an achievement
class AchievementModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final int triggerValue;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.triggerValue,
  });

  @override
  List<Object> get props => [id, title, description, triggerValue];
}
