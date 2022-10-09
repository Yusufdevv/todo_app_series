import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/adapters.dart';
import '../../main.dart';
import '../../model/task.dart';
import '../widgets/task_item.dart';

// var tasks = [
//   Task.create(name: '🛍 Go Shopping'),
//   Task.create(name: '👨🏼‍💻 Code'),
//   Task.create(name: '🦮 Walk the dog'),
//   Task.create(name: '💪 Exercise')
// ];

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTasks(),
        builder: (context, Box<Task> box, child) {
          var tasks = box.values.toList();
          tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Text(
                      'What\'s up for Today?',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
              actions: [
                IconButton(
                  onPressed: () {
                    modalBottomWindow(context);
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            body: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      base.dataStore.deleteTask(task: task);
                    },
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'This task was deleted',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    key: Key(task.id),
                    child: TaskItem(
                      task: tasks[index],
                    ),
                  );
                }),
          );
        });
  }

  Future<dynamic> modalBottomWindow(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ListTile(
              title: TextField(
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Enter task name'),
                  onSubmitted: (value) {
                    Navigator.pop(context);
                    datePickerWindow(context, value);
                  },
                  autofocus: true),
            ),
          );
        });
  }

  Future<DateTime?> datePickerWindow(BuildContext context, String value) {
    final base = BaseWidget.of(context);
    return DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2023),
        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
      print('change $date ');
    }, onConfirm: (date) {
      if (value.isNotEmpty) {
        var task = Task.create(name: value, createdAt: date);
        base.dataStore.addTask(task: task);
      }
    }, currentTime: DateTime.now());
  }
}
