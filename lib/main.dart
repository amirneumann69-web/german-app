import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GermanStoryApp());
}

class GermanStoryApp extends StatelessWidget {
  const GermanStoryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'German Stories',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
