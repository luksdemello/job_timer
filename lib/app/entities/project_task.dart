import 'package:isar/isar.dart';

part 'project_task.g.dart';

@collection
class ProjectTask {
  Id? id;
  late String name;
  late int duration;
  late DateTime createdAt = DateTime.now();
}
