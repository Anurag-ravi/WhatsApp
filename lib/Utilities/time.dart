String timeFromEpoch(int epoch) {
  DateTime now = DateTime.fromMillisecondsSinceEpoch(epoch);
  int min = now.minute;
  String time = "${now.hour}:";
  if (min < 10) {
    time += "0${min}";
  } else {
    time += "${min}";
  }
  return time;
}
