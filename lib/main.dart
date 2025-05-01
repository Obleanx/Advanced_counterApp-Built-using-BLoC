import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/theme/theme_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/counters/counter_bloc.dart';
import 'package:bloc_counter/FEATURES/BLoCs/achievements/achievements_bloc.dart';

// File: lib/main.dart

void main() {
  // Enable system overlays like status bar
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait orientation for better UX
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    // BLoC Providers at the root level to make them accessible throughout the app
    MultiBlocProvider(
      providers: [
        // CounterBloc: Manages the core counter logic and state
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        // ThemeBloc: Manages the theme based on counter value
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        // AchievementsBloc: Tracks and manages achievements
        BlocProvider<AchievementsBloc>(create: (context) => AchievementsBloc()),
      ],
      child: const MyApp(),
    ),
  );
}
