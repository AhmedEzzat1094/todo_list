import 'package:todo_list/model/expansion_model.dart';

import '../model/task_model.dart';
// import '../model/expansion_model.dart';

class TasksController {
  static List<ExpansionModel> panels = [];

  static void addPanel(ExpansionModel panel) {
    panels.add(panel);
  }

  static void deletePanel(ExpansionModel panel) {
    panels.remove(panel);
  }

  static void editTask(Task task, String newDescription) {
    task.title = newDescription;
  }

  static void deleteTask(ExpansionModel panel, Task task) {
    panel.tasks.remove(task);
  }
}