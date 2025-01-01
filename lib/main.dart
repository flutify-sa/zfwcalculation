import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zfwcalc/toggleselector.dart';
import 'package:zfwcalc/welcomescreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToggleSelector(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZFW Calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const WelcomeScreen(),
    );
  }
}
