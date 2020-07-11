import 'package:flutter/material.dart';

import 'clock_painter.dart';

class Clock extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  Clock({
    Key key,
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> valueTween;
  Animation<double> curve;

  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    this._controller.repeat();
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
                      'Placeholder',
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
