class Alarm {
  int hour;
  int minute;
  bool isAm;
  bool isActive;

  Alarm({
    required this.hour,
    required this.minute,
    required this.isAm,
    required this.isActive
  });
}

List<Alarm> alarmList = [
  Alarm(
    hour: 10,
    minute: 24,
    isAm: true,
    isActive: true
  ),
];

Alarm deleteAlarm(int index) {
  return alarmList.removeAt(index);
}

List<int> openedAt = [
  20,
  31,
  11,
  3,
  5,
  10
];

int add(String? payload) {
  if (int.parse(payload.toString()) == DateTime.now().minute) {
    return DateTime.now().second;
  } else {
    return 60;
  }
}