import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Center(
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: 42),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      context.go("/board");
                    },
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.red.shade100,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red, width: 5),
                      ),
                      child: const Text(
                        "Play",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
