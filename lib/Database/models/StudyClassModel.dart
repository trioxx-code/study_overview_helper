import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_overview_helper/util/Constants.dart';

part 'StudyClassModel.g.dart';

@HiveType(typeId: Constants.STUDY_CLASS_MODEL_TYPE_ID)
class StudyClassModel extends HiveObject {
  @HiveField(0)
  late String className;
  @HiveField(1)
  late int semester;
}
