import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mac \'n\' Cheese Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: const Color(0xFF2C1810), // Dark brown
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37), // Gold
          primary: const Color(0xFF2C1810), // Dark brown
          secondary: const Color(0xFFD4AF37), // Gold
          surface: const Color(0xFFFFF8E1), // Cream
          background: const Color(0xFFFFF8E1), // Cream
        ),
        fontFamily: 'serif',
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
