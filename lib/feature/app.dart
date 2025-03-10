import 'package:flutter/material.dart';
import 'home/widgets/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF8F8F8)),
      home: HomeContent(),
    );
  }
}
