import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_hive/controller/todo_contoller.dart';
import 'package:todo_getx_hive/presentation/widgets/todo_form.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({Key? key}) : super(key: key);

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Rejalar'),
      ),
      body: GetBuilder(
        builder: (TodoController todoController) {
          final todos = todoController.todos;
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 10,
                          offset: const Offset(6, 6),
                        ),
                      ]),
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return TodoForm(
                              type: 'add',
                              todo: todo,
                            );
                          });
                    },
                    leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          todoController.changeStatus(todo);
                        }),
                    title: Text(todo.title),
                    trailing: IconButton(
                        onPressed: () {
                          todoController.deleteTodo(todo);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return TodoForm(type: 'new');
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
