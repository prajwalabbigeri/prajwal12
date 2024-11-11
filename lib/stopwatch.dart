import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  String formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor() % 60;
    int minutes = (milliseconds / (1000 * 60)).floor() % 60;
    int hours = (milliseconds / (1000 * 60 * 60)).floor();
    return "${hours.toString().padLeft(2, "0")}:"
        "${minutes.toString().padLeft(2, "0")}:"
        "${seconds.toString().padLeft(2, "0")}";
  }

  void _startStopwatch() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _milliseconds += 100;
      });
    });
  }

  void _stopStopwatch() {
    if (!_isRunning) return;
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _resetStopwatch() {
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Stopwatch',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              formatTime(_milliseconds),
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopStopwatch,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}