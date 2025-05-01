import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/core/theme/app_theme.dart';
import 'package:bloc_counter/FEATURES/BLoCs/theme/theme_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/theme/theme_state.dart';
import 'package:bloc_counter/FEATURES/presentation/pages/counter_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder listens to ThemeBloc state changes
    // and rebuilds the MaterialApp with updated theme
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'BLoC Counter',
          debugShowCheckedModeBanner: false,
          // Theme is determined by ThemeBloc state
          theme: getAppTheme(themeState.brightness, themeState.colorScheme),
          home: const CounterPage(),
        );
      },
    );
  }
}
