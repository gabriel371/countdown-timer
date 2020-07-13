import 'package:flutter/material.dart';

import 'clock.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _running = false;

  @override
  Widget build(BuildContext context) {
    int counterValue = ((_hours * 3600) + (_minutes * 60) + _seconds);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !_running
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          FlatButton(
                            child: Icon(
                              Icons.arrow_drop_up,
                              size: 60,
                            ),
                            onPressed: _hours > 23
                                ? null
                                : () {
                                    setState(() {
                                      _hours++;
                                    });
                                  },
                          ),
                          Text(
                            _hours.toString().padLeft(2, '0'),
                            style: TextStyle(fontSize: 50),
                          ),
                          Text('Hours'),
                          FlatButton(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 60,
                            ),
                            onPressed: _hours <= 0
                                ? null
                                : () {
                                    setState(() {
                                      _hours--;
                                    });
                                  },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            child: Icon(
                              Icons.arrow_drop_up,
                              size: 60,
                            ),
                            onPressed: _minutes >= 59
                                ? () {
                                    setState(() {
                                      _minutes = 0;
                                      _hours++;
                                    });
                                  }
                                : () {
                                    setState(() {
                                      _minutes++;
                                    });
                                  },
                          ),
                          Text(
                            _minutes.toString().padLeft(2, '0'),
                            style: TextStyle(fontSize: 50),
                          ),
                          Text('Minutes'),
                          FlatButton(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 60,
                            ),
                            onPressed: _minutes <= 0
                                ? null
                                : () {
                                    setState(() {
                                      _minutes--;
                                    });
                                  },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FlatButton(
                            child: Icon(
                              Icons.arrow_drop_up,
                              size: 60,
                            ),
                            onPressed: _seconds >= 59
                                ? () {
                                    setState(() {
                                      _seconds = 0;
                                      _minutes++;
                                    });
                                  }
                                : () {
                                    setState(() {
                                      _seconds++;
                                    });
                                  },
                          ),
                          Text(
                            _seconds.toString().padLeft(2, '0'),
                            style: TextStyle(fontSize: 50),
                          ),
                          Text('Seconds'),
                          FlatButton(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 60,
                            ),
                            onPressed: _seconds <= 0
                                ? null
                                : () {
                                    setState(() {
                                      _seconds--;
                                    });
                                  },
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            !_running
                ? FlatButton(
                    child: Text('Clear'),
                    onPressed: counterValue != 0
                        ? () {
                            setState(() {
                              _hours = 0;
                              _minutes = 0;
                              _seconds = 0;
                            });
                          }
                        : null,
                  )
                : Container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            _running == true
                ? Clock(
                    hours: _hours,
                    minutes: _minutes,
                    seconds: _seconds,
                    sum: counterValue,
                  )
                : Container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[900],
              ),
              child: IconButton(
                icon: !_running ? Icon(Icons.play_arrow) : Icon(Icons.stop),
                onPressed: counterValue <= 0
                    ? null
                    : () {
                        setState(() {
                          _running = !_running;
                        });
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
