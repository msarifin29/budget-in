import 'package:flutter/material.dart';

ThemeData lightTheme() => ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 14),
        bodyMedium: TextStyle(fontSize: 16),
        bodyLarge: TextStyle(fontSize: 18),
        titleSmall: TextStyle(fontSize: 20),
        titleMedium: TextStyle(fontSize: 24),
        titleLarge: TextStyle(fontSize: 28),
        labelSmall: TextStyle(fontSize: 12),
      ),
    );
