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

  Clock({
    Key key,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.value = 1,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> valueTween;
  Animation<double> curve;
  Timer _timer;
  int hours = 0;
  int minutes = 0;
  int seconds = 30;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else if (minutes > 0) {
          seconds = 60;
          minutes--;
          seconds--;
        } else if (hours > 0) {
          minutes = 60;
          seconds = 60;
          hours--;
          minutes--;
          seconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    run();
  }

  void run() {
    startTimer();
    this._controller = AnimationController(
      duration: Duration(seconds: ((hours * 3600) + (minutes * 60) + seconds)),
      vsync: this,
    );
    this._controller.forward();
    this.curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Clock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.value != oldWidget.value) {
      double beginValue =
          this.valueTween?.evaluate(this._controller) ?? oldWidget?.value ?? 0;
      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );
      this._controller
        ..value = 0
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.widget.backgroundColor;
    final foregroundColor = this.widget.foregroundColor;
    this.valueTween = Tween<double>(
      begin: 0,
      end: this.widget.value,
    );

    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              foregroundPainter: ClockPainter(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                percentage: this.valueTween.evaluate(this._controller),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.hours.toString(),
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      widget.minutes.toString(),
                      style: TextStyle(fontSize: 60),
                    ),
                    Text(
                      widget.seconds.toString(),
                      style: TextStyle(fontSize: 120),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
