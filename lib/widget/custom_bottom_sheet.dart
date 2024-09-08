import 'package:flutter/material.dart';

import '../model/expansion_model.dart';
import '../model/task_model.dart';
import '../tools/select_time.dart';
import 'app_elevated_button.dart';

class TaskBottomSheet extends StatefulWidget {
  final Function(ExpansionModel) onAdd;

  TaskBottomSheet({required this.onAdd});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isTimeSelected = false;
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      "Add Task",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Time",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        selectTime(
                          onTimeSelected: (selectedTime, isTimeSelected) {
                            setState(() {
                              this.selectedTime = selectedTime;
                              this.isTimeSelected = isTimeSelected;
                            });
                          },
                          context: context,
                          selectedTime: selectedTime,
                          isTimeSelected: isTimeSelected,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xffbcbcbc),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.watch_later, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              isTimeSelected
                                  ? selectedTime.format(context)
                                  : "Select Time",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(fontSize: 19),
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your task ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a task ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                IconButton(
                  tooltip: "Add task at same time",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final task = Task(
                        title: textController.text,
                        isFinsh: false,
                      );
                      setState(() {
                        tasks.add(task);
                        textController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.add, size: 30),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          "${index + 1} - ${tasks[index].title}",
                          style: TextStyle(fontSize: 23),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                AppElevatedButton(
                  buttonText: "Confirm",
                  onPressed: () {
                    if (!isTimeSelected || tasks.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Data Missing",
                              style: TextStyle(fontSize: 22),
                            ),
                            content: const Text(
                              "Choose time and write your task",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      final expansionModel = ExpansionModel(
                        tasks: tasks,
                        head: selectedTime.format(context),
                        isExpanded: false,
                      );
                      widget.onAdd(expansionModel);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
