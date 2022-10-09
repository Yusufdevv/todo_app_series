import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({
    required this.task,
    Key? key,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final taskController = TextEditingController();

  @override
  void initState() {
    taskController.text = widget.task.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.1),
                offset: Offset(0, 4),
                blurRadius: 10)
          ]),
      child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.task.isCompleted ? Colors.green : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .8)),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          title: widget.task.isCompleted
              ? Text(
                  taskController.text,
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                )
              : TextField(
                  controller: taskController,
                  decoration: InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      widget.task.name = value;
                      widget.task.save();
                    }
                  },
                ),
          trailing: Text(
            DateFormat('hh:mm a').format(widget.task.createdAt),
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )),
    );
  }
}
