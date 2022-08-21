import 'package:chess_game/src/views/entry_home.dart';
import 'package:flutter/material.dart';

final Map<int, Color> _black700Map = {
  50: Colors.black,
  100: Colors.black12,
  200: Colors.black26,
  300: Colors.black38,
  400: Colors.black45,
  500: Colors.black54,
  600: Colors.black87,
  700: Colors.black,
  800: Colors.black,
  900: Colors.black,
};

final MaterialColor _black700Swatch =
    MaterialColor(Colors.black.value, _black700Map);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chess',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: _black700Swatch,
      ),
      home: const HomeScreen(),
    );
  }
}

