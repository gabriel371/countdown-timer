import 'dart:async';

import 'package:flutter/material.dart';

import 'clock_painter.dart';

class Clock extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  int hours;
  int minutes;
  int seconds;
  int sum;

  Clock({
    Key key,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.value = 1,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.sum = 0,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> valueTween;
  Animation<double> curve;
  Timer _timer;
  int hours = 0;
  int minutes = 0;
  int seconds = 30;
  bool dynamicClock = false;

  int get getHours {
    return widget.hours;
  }

  int get getMinutes {
    return widget.minutes;
  }

  int get getSeconds {
    return widget.seconds;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (getSeconds > 0) {
          setState(() {
            widget.seconds--;
          });
        } else if (getMinutes > 0) {
          setState(() {
            widget.seconds = 60;
            widget.minutes--;
            widget.seconds--;
          });
        } else if (getHours > 0) {
          setState(() {
            widget.minutes = 60;
            widget.seconds = 60;
            widget.hours--;
            widget.minutes--;
            widget.seconds--;
          });
        } else {
          _timer.cancel();
          _controller.stop();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    animate();
  }

  void animate() {
    _controller = AnimationController(
      duration: Duration(seconds: widget.sum),
      vsync: this,
    );
    _controller.forward();
    curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor;
    valueTween = Tween<double>(
      begin: 0,
      end: 1,
    );

    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: ClockPainter(
              backgroundColor: backgroundColor,
              foregroundColor: Colors.white,
              percentage: valueTween.evaluate(_controller),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getHours.toString(),
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    getMinutes.toString(),
                    style: TextStyle(fontSize: 60),
                  ),
                  Text(
                    getSeconds.toString(),
                    style: TextStyle(fontSize: 120),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
