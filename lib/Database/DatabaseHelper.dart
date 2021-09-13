
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {

  static Future initHive() async {
    await Hive.initFlutter();
  }

}