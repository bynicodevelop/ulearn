import 'package:firebase_database/firebase_database.dart';
import 'package:leadee/models/activity.dart';

class CommonService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<Map<String, Activity>> getActivties(String locale) async {
    Map<String, Activity> activities = {};

    DataSnapshot data = await _database.reference().child('activities').once();

    Map<dynamic, dynamic> map = data.value;

    if (map != null && map.length > 0) {
      map.forEach((key, value) {
        activities.putIfAbsent(key, () => Activity(key, value[locale]));
      });
    }

    return activities;
  }
}
