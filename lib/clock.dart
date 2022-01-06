import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simple_alarm_app/clock_painter.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  int secondclock = 0;
  int minuteclock = 0;
  int hourclock = 0;
  late Timer timer;
  bool _isAm = true;

  @override
  void initState(){
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        secondclock = now.second;
        minuteclock = now.minute;
        if (now.hour >= 12) {
          _isAm = false;
          hourclock = now.hour - 12;
        } else {
          hourclock = now.hour;
          _isAm = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 300,
                    width: 300,
                    child: CustomPaint(
                      size: Size(250, 250),
                      painter: ClockPainter(
                          second: secondclock,
                          minute: minuteclock,
                          hour: hourclock,
                          isAM: _isAm
                      ),
                    ),
                  ),
                  Text(
                    hourclock.toString().padLeft(2, '0') + ' : ' + minuteclock.toString().padLeft(2, '0'),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Container(
                    height: 60,
                    width: 130,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: 30,
                      width: 65,
                      child: Text((_isAm == true) ? 'AM' : 'PM',
                        style: TextStyle(
                          color: (_isAm == true) ? Colors.red : Colors.blueAccent,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ], //children Column
      ),
    );
  }
}