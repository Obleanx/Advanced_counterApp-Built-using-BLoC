import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/theme/theme_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/theme/theme_event.dart';
import 'package:bloc_counter/FEATURES/BLoCs/counters/counter_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/counters/counter_event.dart';
import 'package:bloc_counter/FEATURES/BLoCs/counters/counter_state.dart';
import 'package:bloc_counter/FEATURES/counter/models/achievement_model.dart';
import 'package:bloc_counter/FEATURES/BLoCs/achievements/achievements_bloc.dart';
import 'package:bloc_counter/FEATURES/presentation/widgets/counter_display.dart';
import 'package:bloc_counter/FEATURES/BLoCs/achievements/achievements_event.dart';
import 'package:bloc_counter/FEATURES/BLoCs/achievements/achievements_state.dart';
import 'package:bloc_counter/FEATURES/presentation/widgets/counter_controls.dart';
import 'package:bloc_counter/FEATURES/presentation/widgets/achievement_banner.dart';
// File: lib/features/counter/presentation/pages/counter_page.dart

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with SingleTickerProviderStateMixin {
  // Controller for confetti animation
  late ConfettiController _confettiController;
  // Animation controller for page transitions
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start the fade-in animation when the page loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Helper method to show dialog for adding a new counter
  void _showAddCounterDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Counter'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Counter Name',
                hintText: 'e.g., Exercise Reps, Water Glasses...',
              ),
              autofocus: true,
              textCapitalization: TextCapitalization.words,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    // Dispatch event to add named counter
                    context.read<CounterBloc>().add(
                      AddNamedCounter(controller.text),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('ADD'),
              ),
            ],
          ),
    );
  }

  // Helper method to show achievements dialog
  void _showAchievementsDialog(
    BuildContext context,
    List<AchievementModel> achievements,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Achievements'),
            content: SizedBox(
              width: double.maxFinite,
              child:
                  achievements.isEmpty
                      ? const Center(
                        child: Text(
                          'No achievements yet. Keep counting!',
                          textAlign: TextAlign.center,
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: achievements.length,
                        itemBuilder: (context, index) {
                          final achievement = achievements[index];
                          return ListTile(
                            leading: const Icon(
                              Icons.emoji_events,
                              color: Colors.amber,
                            ),
                            title: Text(achievement.title),
                            subtitle: Text(achievement.description),
                          );
                        },
                      ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CLOSE'),
              ),
            ],
          ),
    );
  }

  // Helper method to show settings dialog
  void _showSettingsDialog(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        // We need to add the SetBrightness event to the ThemeBloc
                        // Let's create a compatible event for this
                        context.read<ThemeBloc>().add(ToggleBrightness());
                      },
                    ),
                  ],
                ),
                const Divider(),
                // About section
                const Text(
                  'BLoC Counter App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A feature-rich counter app demonstrating BLoC pattern, animations, and more!',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CLOSE'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leo\'s BLoC Counter'),

        actions: [
          // Achievement icon that shows a dialog with all unlocked achievements
          BlocBuilder<AchievementsBloc, AchievementsState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.emoji_events),
                onPressed: () {
                  _showAchievementsDialog(context, state.unlockedAchievements);
                },
                tooltip: 'Achievements',
              );
            },
          ),
          // Theme toggle button
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Dispatch event to toggle brightness
              context.read<ThemeBloc>().add(ToggleBrightness());
            },
            tooltip: 'Toggle theme',
          ),
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Main content area
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Counter display (value and name)
                  BlocConsumer<CounterBloc, CounterState>(
                    // Listen for state changes in CounterBloc
                    listener: (context, state) {
                      // When counter value changes, check for achievements
                      context.read<AchievementsBloc>().add(
                        CheckAchievements(state.currentValue),
                      );

                      // Update theme based on counter value
                      context.read<ThemeBloc>().add(
                        UpdateTheme(state.currentValue),
                      );

                      // Play confetti animation when milestone reached
                      if (state.showConfetti) {
                        _confettiController.play();
                      }
                    },
                    // Build UI based on current CounterBloc state
                    builder: (context, state) {
                      return CounterDisplay(
                        count: state.currentValue,
                        name: state.currentName,
                      );
                    },
                  ),

                  const SizedBox(height: 50),

                  // Counter controls (increment, decrement, etc.)
                  const CounterControls(),

                  const SizedBox(height: 30),

                  // Counter switcher (select between different counters)
                  BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < state.counters.length; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ChoiceChip(
                                  label: Text(state.counters[i].name),
                                  selected: i == state.currentIndex,
                                  onSelected: (_) {
                                    context.read<CounterBloc>().add(
                                      SwitchCounter(i),
                                    );
                                  },
                                ),
                              ),
                            // Add new counter button
                            ActionChip(
                              avatar: const Icon(Icons.add),
                              label: const Text("New"),
                              onPressed: () {
                                _showAddCounterDialog(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Confetti effect overlay
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -math.pi / 2, // straight up
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.1,
            ),

            // Achievement notification
            BlocBuilder<AchievementsBloc, AchievementsState>(
              builder: (context, state) {
                if (state.currentNotification != null) {
                  return AchievementBanner(
                    achievement: state.currentNotification!,
                    onDismiss: () {
                      context.read<AchievementsBloc>().add(
                        DismissAchievement(state.currentNotification!.id),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      // Floating action button for quick increment
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(IncrementCounter());
        },
        tooltip: 'Quick Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
