import 'package:flutter/material.dart';
import 'entryscreen.dart'; // Make sure to import your EntryScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Check if the swipe was to the left
          if (details.velocity.pixelsPerSecond.dx < 0) {
            // Navigate to EntryScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EntryScreen()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/zfw.png'), // Load your image
              const SizedBox(
                  height: 20), // Add some space between image and text
              const Text(
                'Swipe to enter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
