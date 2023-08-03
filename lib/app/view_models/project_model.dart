import 'package:job_timer/app/entities/project_status.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskViewModel> tasks;
}
