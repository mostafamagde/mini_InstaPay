import 'package:shared_preferences/shared_preferences.dart';

class SaveTime {
  static Future<void> saveCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int timestamp = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('currentTime', timestamp);
  }

  static Future<DateTime?> getSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? savedTimestamp = prefs.getInt('currentTime');
    if (savedTimestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(savedTimestamp);
    }
    await saveCurrentTime();
    return DateTime.now();
  }
}
