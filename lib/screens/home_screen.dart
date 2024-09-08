import 'package:flutter/material.dart';
import 'package:todo_list/tools/generate_day_info.dart';
import '../widget/custom_bottom_sheet.dart';

import '../controllers/tasks_controller.dart';
import '../widget/expansion_panel_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: const Color(0xfffefefe),
          appBar: AppBar(
            backgroundColor: const Color(0xfffefefe),
            toolbarHeight: 100,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Color(0xff141414),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      generateDayInfo(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 149, 149, 149),
                          fontSize: 22),
                    ),
                    const SizedBox(width: 23),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          body: ListView.builder(
            itemCount: TasksController.panels.length,
            itemBuilder: (context, index) {
              final panel = TasksController.panels[index];
              return ExpansionPanelItem(
                expansionModel: panel,
                onDeleteTask: (task) {
                  setState(() {
                    TasksController.deleteTask(panel, task);
                    if (panel.tasks.isEmpty) {
                      TasksController.deletePanel(panel);
                    }
                  });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              side: const BorderSide(
                color: Colors.white,
                width: 2,
                style: BorderStyle.solid,
              ),
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45), bottom: Radius.circular(5)),
                ),
                context: context,
                builder: (context) {
                  return TaskBottomSheet(
                    onAdd: (panel) {
                      setState(() {
                        TasksController.addPanel(panel);
                      });
                    },
                  );
                },
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  "Add Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
