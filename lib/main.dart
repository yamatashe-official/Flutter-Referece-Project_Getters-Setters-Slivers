import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';
import 'Screens/succession_screen.dart';

void main() {
  runApp(const MyApp());
  GestureBinding.instance.resamplingEnabled = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disney Coding Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  static Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const HomeScreen(),
          settings: settings,
        );
      case SuccessionScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SuccessionScreen(),
          settings: settings,
        );
    }
    throw Exception('Route not found');
  }
}
