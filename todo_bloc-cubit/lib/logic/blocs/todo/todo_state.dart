part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  final List<Todo>? todos;

  const TodoState({this.todos});
}

class TodoInitial extends TodoState {
  final List<Todo> todos;
  
  const TodoInitial(this.todos);
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  
  const TodoLoaded(this.todos) : super(todos: todos);
}

class TodoAdded extends TodoState{
}

class TodoEdited extends TodoState{
}
class TodoToggled extends TodoState{
}
class TodoDeleted extends TodoState{
}


class TodoError extends TodoState{
  final String message;
  const TodoError(this.message);
}
