import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_hive/controller/todo_contoller.dart';
import 'package:todo_getx_hive/model/todo.dart';

// ignore: must_be_immutable
class TodoForm extends StatefulWidget {
  final String type;
  Todo? todo;
  TodoForm({Key? key, required this.type, this.todo}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _fromKey = GlobalKey<FormState>();
  late String title;

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();
    var bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: _fromKey,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Reja qo\'shish',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.todo != null ? widget.todo!.title : "",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Reajani kiriting';
                }
                return null;
              },
              onSaved: (value) => title = value!,
              decoration: const InputDecoration(
                  hintText: 'Reja nomini kiriting',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_fromKey.currentState!.validate()) {
                    _fromKey.currentState!.save();
                    Navigator.of(context).pop();
                    if (widget.type == 'new') {
                      todoController.addTodo(Todo(title: title));
                    } else {
                      todoController.updateTodo(widget.todo!, title);
                    }
                  }
                },
                child:
                    Text(widget.todo != null ? 'O\'zgartirish' : 'Qo\'shish'))
          ],
        ),
      ),
    );
  }
}
