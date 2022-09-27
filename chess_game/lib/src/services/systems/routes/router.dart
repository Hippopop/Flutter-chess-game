import 'package:chess_game/src/views/entry_home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter myRouter = GoRouter(
    initialLocation: '/board',
  routes: [
    GoRoute(
      path: '/board',
      name: 'boardScreen',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    )
  ],
  errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      )),
);
