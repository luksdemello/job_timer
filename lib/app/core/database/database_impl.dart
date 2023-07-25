import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

import './database.dart';

class DatabaseImpl implements Database {
  Isar? _databaseInsance;

  @override
  Future<Isar> openConnection() async {
    if (_databaseInsance == null) {
      final dir = await getApplicationSupportDirectory();
      _databaseInsance = await Isar.open(
        [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return _databaseInsance!;
  }
}
