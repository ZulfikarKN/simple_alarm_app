import 'package:flutter/material.dart';
import 'package:simple_alarm_app/alarm.dart';
import 'package:simple_alarm_app/clock.dart';
import 'package:simple_alarm_app/data.dart';
import 'package:simple_alarm_app/notifications.dart';
import 'package:simple_alarm_app/statistic_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isActive = true;

  @override
  void initState(){
    super.initState();
    tz.initializeTimeZones();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    openedAt.add(add(payload));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StatisticScreen(payload: payload),
    ));
  } // Go to Statistic Page Function


  void _setAlarm() {
    setState(() {
      _isActive = !_isActive;
    });
  } // Function to change between Alarm or Clock

  int _AmPm(h) {
    if (isAm == true) {
      return h;
    } else {
      return h+12;
    }
  } // Used to adjust time based on Am Pm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded( // List of Active Alarm
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final Alarm place = alarmList[index];
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(onPressed: () {
                                  NotificationApi.cancelNotification(
                                      _AmPm(place.hour)+place.minute);
                                  setState(() {
                                    deleteAlarm(index);
                                  });
                                },
                                  icon: Icon(Icons.delete_outline_outlined, color: Colors.red,),),
                                Text(
                                  place.hour.toString().padLeft(2, '0') +
                                      ' : ' + place.minute.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white
                                  ),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          place.isAm = true;
                                        });
                                      },
                                      child: Text('AM',
                                        style: TextStyle(
                                          color: (place.isAm == true)
                                              ? Colors.red : Colors.white
                                        ),
                                      ),
                                    ),
                                    Text('PM',
                                      style: TextStyle(
                                          color: (place.isAm == true)
                                              ? Colors.white: Colors.blueAccent
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: alarmList.length,
                  ),
                ),
              ),
            ),
            Expanded( // Changing between Clock or Alarm
              flex: 1,
              child: Stack(
                children: [
                  Visibility(
                    child: Clock(),
                    visible: _isActive,
                  ),
                  Visibility(
                    child: AlarmChange(),
                    visible: !_isActive,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: (_isActive == true)
                  ? Icon(Icons.alarm) : Icon(Icons.access_time),
              onPressed: () {
                setState(() {
                  _setAlarm();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                NotificationApi.showScheduledNotification(
                    id: _AmPm(hour) + minute,
                    title: 'Your Time has Come',
                    body: 'Right now at, '
                        + hour.toString().padLeft(2,'0') + ' : '
                        + minute.toString().padLeft(2, '0'),
                    payload: minute.toString(),
                    when: DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        _AmPm(hour),
                        minute
                    )
                );
                setState(() {
                  addAlarm();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}