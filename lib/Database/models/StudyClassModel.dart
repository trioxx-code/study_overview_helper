import 'package:hive_flutter/hive_flutter.dart';

part 'StudyClassModel.g.dart';

@HiveType(typeId: 0)
class StudyClassModel extends HiveObject {
  @HiveField(0)
  late String className;
  @HiveField(1)
  late int semester;
}
