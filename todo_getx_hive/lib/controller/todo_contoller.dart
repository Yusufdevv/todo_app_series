import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_getx_hive/model/todo.dart';

class TodoController extends GetxController {
  List<Todo> _todos = [];
  late Box<Todo> todoBox;
  List<Todo> get todos {
    return _todos;
  }

  TodoController() {
    todoBox = Hive.box<Todo>('todos');
    _todos = [];
    for (var i = 0; i < todoBox.values.length; i++) {
      _todos.add(todoBox.getAt(i)!);
    }
  }

  addTodo(Todo todo) {
    _todos.add(todo);
    todoBox.add(todo);
    update();
  }

  deleteTodo(Todo todo) {
    int index = _todos.indexOf(todo);
    todoBox.deleteAt(index);
    _todos.removeWhere((element) => element.id == todo.id);
    update();
  }

  changeStatus(Todo todo) {
    int index = _todos.indexOf(todo);
    _todos[index].isCompleted = !_todos[index].isCompleted;
    _todos[index].save();
    // todoBox.putAt(index, _todos[index]);
    update();
  }

  updateTodo(Todo oldTodo, String title) {
    int index = _todos.indexOf(oldTodo);
    _todos[index].title = title;
    _todos[index].save();
    // todoBox.putAt(index, _todos[index]);
    update();
  }
}
