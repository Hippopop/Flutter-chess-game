import 'package:chess_game/src/services/systems/routes/router.dart';
import 'package:chess_game/src/services/systems/theme/theme.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: myRouter.routeInformationProvider,
      routeInformationParser: myRouter.routeInformationParser,
      routerDelegate: myRouter.routerDelegate,
      title: 'Flutter Chess',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.lightTheme,
      // home: const HomeScreen(),
    );
  }
}

