import 'package:flutter/material.dart';

import 'clock.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Clock(
            foregroundColor: Colors.white,
            value: 1,
          ),
        ],
      ),
    );
  }
}
