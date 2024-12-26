import 'package:shared_preferences/shared_preferences.dart';

class TimeSaving {
  const TimeSaving(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<void> saveCurrentTime() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    await _sharedPreferences.setInt('currentTime', timestamp);
  }

  Future<DateTime?> getSavedTime() async {
    int? savedTimestamp = _sharedPreferences.getInt('currentTime');
    if (savedTimestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(savedTimestamp);
    }
    await saveCurrentTime();
    return DateTime.now();
  }
}
