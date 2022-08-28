import 'package:chess_game/src/views/entry_home.dart';
import 'package:chess_game/systems/theme/theme.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chess',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}

