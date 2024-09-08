import 'task_model.dart';

class ExpansionModel {
  List<Task> tasks;
  String head;
  bool? isCompleted;
  bool isExpanded;

  ExpansionModel({
    required this.tasks,
    required this.head,
    this.isCompleted,
    required this.isExpanded,
  });
}
