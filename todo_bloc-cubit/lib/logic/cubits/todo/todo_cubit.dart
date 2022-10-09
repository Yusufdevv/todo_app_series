import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../data/models/todo.dart';
import '../user/user_cubit.dart';


part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserCubit userCubit;
  TodoCubit({required this.userCubit})
      : super(TodoInitial([
          Todo(
              id: UniqueKey().toString(),
              title: 'Go home',
              isDone: false,
              userid: '1'),
          Todo(
              id: UniqueKey().toString(),
              title: 'Go shopping',
              isDone: true,
              userid: '2'),
          Todo(
              id: UniqueKey().toString(),
              title: 'Go swimming',
              isDone: false,
              userid: '2'),
        ]));

  void getTodos() {
    // should filter by userId
    final user = userCubit.currentUser;
    final todos = state.todos!.where((todo) => todo.userid == user.id).toList();
    emit(TodoLoaded(todos));
  }

  void addTodo(String title) {
    final user = userCubit.currentUser;

    try {
      final todo =
          Todo(id: UniqueKey().toString(), title: title, userid: user.id);
      final todos = [...state.todos!, todo];
      // final todos = state.todos;
      // todos!.add(todo);
      emit(TodoAdded());
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occured!'));
    }
  }

  void editTodo(String id, String title) {
    try {
      final todos = state.todos!.map((t) {
        if (t.id == id) {
          return Todo(id: id, title: title, isDone: t.isDone, userid: t.userid);
        }
        return t;
      }).toList();
      emit(TodoEdited());
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occured!'));
    }
  }

  //   void editTodo(Todo todo) {
  //   try {
  //     final todos = state.todos;
  //     final index = todos!.indexWhere((t) => t.id == todo.id);
  //     todos[index] = todo;
  //     emit(TodoEdited());
  //     emit(TodoState(todos: todos));
  //   } catch (e) {
  //     emit(const TodoError('Error occured!'));
  //   }
  // }

  void toggleTodo(String id) {
    final todos = state.todos!.map((todo) {
      if (todo.id == id) {
        return Todo(
            id: id,
            title: todo.title,
            isDone: !todo.isDone,
            userid: todo.userid);
      }
      return todo;
    }).toList();
    emit(TodoToggled());
    emit(TodoLoaded(todos));
  }

  // void toggleTodo(String id) {
  //   final todos = state.todos;
  //   final index = todos!.indexWhere((t) => t.id == id);
  //   todos[index].isDone = !todos[index].isDone;
  //   emit(TodoToggled());
  //   emit(TodoState(todos: todos));
  // }

  void deleteTodo(String id) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == id);
    emit(TodoDeleted());
    emit(TodoLoaded(todos)); // emit(TodoState(todos: todos)) => avvalgi holati
  }

  List<Todo> searchTodos(String title) {
    return state.todos!
        .where(
          (todo) => todo.title.toLowerCase().contains(title.toLowerCase()),
        )
        .toList();
  }
}
