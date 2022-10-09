import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_cubit/data/models/todo.dart';
import 'package:todo_cubit/logic/blocs/user/user_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserBloc userBloc;
  TodoBloc(this.userBloc)
      : super(
          TodoInitial([
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
          ]),
        ) {
    on<LoadTodosEvent>(_getTodos);
    on<AddNewTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  void _getTodos(LoadTodosEvent event, Emitter<TodoState> emit) {
    // should filter by userId
    final user = userBloc.currentUser;
    final todos = state.todos!.where((todo) => todo.userid == user.id).toList();
    emit(TodoLoaded(todos));
  }

  void _addTodo(AddNewTodoEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;

    try {
      final todo =
          Todo(id: UniqueKey().toString(), title: event.title, userid: user.id);
      final todos = [...state.todos!, todo];
      // final todos = state.todos;
      // todos!.add(todo);
      emit(TodoAdded());
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(const TodoError('Error occured!'));
    }
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    try {
      final todos = state.todos!.map((t) {
        if (t.id == event.id) {
          return Todo(id: event.id, title: event.title, isDone: t.isDone, userid: t.userid);
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

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos!.map((todo) {
      if (todo.id == event.id) {
        return Todo(
            id: event.id,
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

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final todos = state.todos;
    todos!.removeWhere((todo) => todo.id == event.id);
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
