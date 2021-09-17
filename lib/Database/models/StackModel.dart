import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_overview_helper/util/Constants.dart';

part "StackModel.g.dart";

@HiveType(typeId: Constants.STACK_MODEL_TYPE_ID)
class StackModel extends HiveObject {
  @HiveField(0)
  late String className;
  @HiveField(1)
  late Map content;
}
