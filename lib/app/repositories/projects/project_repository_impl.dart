import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<void> register(project) async {
    try {
      final isar = await _database.openConnection();

      await isar.writeTxn(() async {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final isar = await _database.openConnection();
    final projects =
        await isar.projects.filter().statusEqualTo(status).findAll();

    return projects;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final isar = await _database.openConnection();
    final project = await findById(projectId);

    project.tasks.add(task);

    isar.writeTxn(() => project.tasks.save());

    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final isar = await _database.openConnection();
    final project = await isar.projects.get(projectId);

    if (project == null) {
      throw Failure(message: 'Projeto não encontrado');
    }

    return project;
  }
}
