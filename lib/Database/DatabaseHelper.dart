import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_overview_helper/util/Constants.dart';

class DatabaseHelper {
  static Future initHive() async {
    await Hive.initFlutter();
  }

  static Box getClasses() => Hive.box(Constants.HIVE_STUDY_CLASS);
  static Box getStacks() => Hive.box(Constants.HIVE_STACK);
}
