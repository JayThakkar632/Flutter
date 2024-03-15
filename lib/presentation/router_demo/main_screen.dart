import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/first_screen');
              },
              child: Text("Screen 1"),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/second_screen');
              },
              child: Text("Screen 2"),
            ),
          ],
        ),
      ),
    );
  }
}
