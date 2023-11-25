import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingBouncingGrid.circle(
          size: 80,
          borderColor: const Color.fromARGB(255, 211, 138, 27),
          backgroundColor: const Color.fromARGB(255, 211, 138, 27),
        ),
      ),
    );
  }
}
