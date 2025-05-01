import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int count;
  final String name;

  const CounterDisplay({super.key, required this.count, required this.name});

  @override
  Widget build(BuildContext context) {
    // Apply different styles based on the count value
    final textTheme = Theme.of(context).textTheme;
    final color =
        count > 0
            ? count > 30
                ? Colors.green
                : Theme.of(context).colorScheme.primary
            : count < 0
            ? Colors.red
            : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Counter name with subtitle styling
        Text(
          name,
          style: textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Counter value with large display styling
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.scale(scale: 0.8 + (0.2 * value), child: child);
          },
          child: Text(
            '$count',
            style: textTheme.displayLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Additional message based on count value
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            _getCountMessage(),
            key: ValueKey<int>(count),
            style: textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to generate a message based on the count value
  String _getCountMessage() {
    if (count == 0) return "Let's start counting!";
    if (count > 50) return "Wow, that's impressive!";
    if (count > 25) return "You're doing great!";
    if (count > 10) return "Nice progress!";
    if (count > 0) return "Keep it up!";
    return "Try going positive!";
  }
}
