import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/counters/counter_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/counters/counter_event.dart';
// ignore_for_file: deprecated_member_use


class CounterControls extends StatelessWidget {
  const CounterControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main increment/decrement controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decrement button
              _buildControlButton(
                context,
                icon: Icons.remove,
                color: Colors.redAccent,
                onPressed: () {
                  context.read<CounterBloc>().add(DecrementCounter());
                },
                tooltip: 'Decrement',
              ),

              const SizedBox(width: 24),

              // Increment button
              _buildControlButton(
                context,
                icon: Icons.add,
                color: Colors.greenAccent,
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementCounter());
                },
                tooltip: 'Increment',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Additional controls row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Reset counter button
              _buildSmallButton(
                context,
                icon: Icons.refresh,
                label: 'Reset',
                onPressed: () {
                  context.read<CounterBloc>().add(ResetCounter());
                },
                tooltip: 'Reset to zero',
              ),

              const SizedBox(width: 16),

              // Add 10 button
              _buildSmallButton(
                context,
                icon: Icons.exposure_plus_2,
                label: '+10',
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementByAmount(10));
                },
                tooltip: 'Add 10',
              ),

              const SizedBox(width: 16),

              // Remove counter button
              _buildSmallButton(
                context,
                icon: Icons.delete_outline,
                label: 'Remove',
                onPressed: () {
                  _confirmDeleteCounter(context);
                },
                tooltip: 'Delete this counter',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build the main control buttons
  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color.withOpacity(0.2),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, size: 40, color: color.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }

  // Helper method to build smaller action buttons
  Widget _buildSmallButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  // Helper method to show a confirmation dialog before deleting counter
  void _confirmDeleteCounter(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Counter'),
            content: const Text(
              'Are you sure you want to delete this counter? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(RemoveCurrentCounter());
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('DELETE'),
              ),
            ],
          ),
    );
  }
}
