import 'package:flutter/material.dart';
import 'package:todo_list/model/expansion_model.dart';
import '../controllers/tasks_controller.dart';
import '../model/task_model.dart';
// import '../models/panel_model.dart';
// import '../controllers/task_controller.dart';

class ExpansionPanelItem extends StatefulWidget {
  final ExpansionModel expansionModel;
  final Function(Task task) onDeleteTask;
  const ExpansionPanelItem({
    super.key,
    required this.expansionModel,
    required this.onDeleteTask,
  });

  @override
  _ExpansionPanelItemState createState() => _ExpansionPanelItemState();
}

class _ExpansionPanelItemState extends State<ExpansionPanelItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(22)),
          child: ExpansionPanelList(
            elevation: 0,
            dividerColor: Colors.blue,
            expandedHeaderPadding: const EdgeInsets.all(10),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                widget.expansionModel.isExpanded = isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: Colors.grey[200],
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  int completedTasks = widget.expansionModel.tasks
                      .where((task) => task.isFinsh)
                      .length;
                  int totalTasks = widget.expansionModel.tasks.length;

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.only(top: 18, bottom: 18, left: 2),
                    title: Text(
                      widget.expansionModel.head,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: completedTasks == totalTasks
                              ? Colors.green
                              : completedTasks == 0
                                  ? Colors.grey[700]
                                  : Colors.orange),
                      completedTasks == totalTasks
                          ? "Completed"
                          : "$completedTasks/$totalTasks Tasks Completed",
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.expansionModel.tasks.map((task) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 0,
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                              fontSize: 22,
                              decoration: task.isFinsh
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        leading: Checkbox(
                          activeColor: Colors.green,
                          value: task.isFinsh,
                          onChanged: (value) {
                            setState(() {
                              task.isFinsh = value!;
                            });
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showEditDialog(task);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                _deleteTask(task);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                isExpanded: widget.expansionModel.isExpanded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteTask(Task task) {
    widget.onDeleteTask(task);
  }

  void _showEditDialog(Task task) {
    final TextEditingController editingController =
        TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Edit",
            style: TextStyle(fontSize: 22),
          ),
          content: TextField(
            style: TextStyle(fontSize: 20),
            controller: editingController,
            decoration: const InputDecoration(
              hintText: "Edit this task",
              hintStyle: TextStyle(fontSize: 22),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (editingController.text.isNotEmpty) {
                  setState(() {
                    TasksController.editTask(task, editingController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        );
      },
    );
  }
}
